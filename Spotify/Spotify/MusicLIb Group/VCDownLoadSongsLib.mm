//
//  VCDownLoadSongsLib.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import "VCDownLoadSongsLib.h"
#import "Masonry/Masonry.h"
#import "SpotifyArtistAPIModel.h"
#import "AlbumDetailView.h"
#import "AlbumSongsTableViewCell.h"
#import "VCMusicPlayer.h"
#import "MusicPlayerManager.h"
#import "MusicDBModel.h"
#import "SpotifySongsModels.h"
@interface VCDownLoadSongsLib ()

@end

@implementation VCDownLoadSongsLib
- (void)loadView {
  self.mainView = [[AlbumDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.view = self.mainView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self setupBackButton];
  self.mainView.backgroundColor = [UIColor blackColor];
  self.mainView.tableView.dataSource = self;
  self.mainView.tableView.delegate = self;
  self.mainView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
  [self.mainView.tableView registerClass:[AlbumSongsTableViewCell class] forCellReuseIdentifier:@"AlbumSongsTableViewCell"];
  [self.mainView.tableView reloadData];
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
  [self.view addGestureRecognizer:panGesture];
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:NO animated:NO];
  [self fentchData];
}
- (void) fentchData {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSArray *songs = [[MusicDBModel shared] getAllDownLoadSongs];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.allmodels = songs;
      //objc中的泛型和编译器推断不能使用 songs
      [self.mainView updateWithTitle:@"我下载的歌曲" imageURL:[NSURL URLWithString: self.allmodels.firstObject.picURl] descText:@""];
      [self.mainView.tableView reloadData];
    });
  });
}

- (void) setupBackButton {
  UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
  [backBtn setImage:[UIImage systemImageNamed:@"chevron.left"] forState:UIControlStateNormal];
  [backBtn setTintColor:[UIColor whiteColor]];
  [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:backBtn];
  [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(16);
    make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
    make.width.height.mas_equalTo(30);
  }];
}
- (void) goBack {
  [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.allmodels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  AlbumSongsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumSongsTableViewCell" forIndexPath:indexPath];
  SpotifySongsModels *model = self.allmodels[indexPath.row];
  [cell configureModel:model index:indexPath.row + 1];
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  SpotifySongsModels *clickModels = self.allmodels[indexPath.row];
  [[MusicPlayerManager shared] fetchSongModels:self.allmodels];
  [MusicPlayerManager shared].currentindex = indexPath.row;
  [[MusicPlayerManager shared] playMusic:clickModels];
  VCMusicPlayer *player = [[VCMusicPlayer alloc] init];
  player.modalPresentationStyle = UIModalPresentationOverFullScreen;
  [self presentViewController:player animated:YES completion:nil];
}

#pragma mark - 删除歌曲逻辑调度
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Delete";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    SpotifySongsModels *modelToDelete = self.allmodels[indexPath.row];
    [[MusicPlayerManager shared] deleteDownLoadedSongsFile:modelToDelete];
    [[MusicDBModel shared] removeDownLoadSong:modelToDelete];
    NSMutableArray *tempArray = [self.allmodels mutableCopy];
    [tempArray removeObjectAtIndex:indexPath.row];
    self.allmodels = [tempArray copy];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
  }
}
#pragma mark - 拖拽下滑关闭逻辑
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
  CGPoint translation = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  switch (pan.state) {
    case UIGestureRecognizerStateChanged: {
      if (translation.y > 0) {
        self.view.transform = CGAffineTransformMakeTranslation(0, translation.y);
      }
      break;
    }
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled: {
      if (translation.y > 150 || velocity.y > 800) {
        [UIView animateWithDuration:0.25 animations:^{
          self.view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
          [self dismissViewControllerAnimated:NO completion:nil];
        }];
      } else {
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:velocity.y / 100.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          self.view.transform = CGAffineTransformIdentity;
        } completion:nil];
      }
      break;
    }
      break;

    default:
      break;
  }
}
@end
