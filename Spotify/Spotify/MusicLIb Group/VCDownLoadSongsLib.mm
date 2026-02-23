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
  [super viewDidLoad];
  [self setupBackButton];
  self.mainView.tableView.dataSource = self;
  self.mainView.tableView.delegate = self;
  [self.mainView.tableView registerClass:[AlbumSongsTableViewCell class] forCellReuseIdentifier:@"AlbumSongsTableViewCell"];
  [self.mainView.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self fentchData];
}
- (void) fentchData {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSArray *songs = [[MusicDBModel shared] getAllDownLoadSongs];
    dispatch_async(dispatch_get_main_queue(), ^{
      self.allmodels = songs;
      //objc中的泛型和编译器推断不能使用 songs
      [self.mainView updateWithTitle:@"我下载的歌曲" imageURL:self.allmodels.firstObject.picURl];
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
  [self presentViewController:player animated:YES completion:nil];

}

/*
#pragma mark - Navigation
*/

@end
