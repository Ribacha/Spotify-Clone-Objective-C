//
//  VCAlbumDetail.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/2.
//

#import "VCAlbumDetail.h"
#import "Masonry/Masonry.h"
#import "SpotifyArtistAPIModel.h"
#import "AlbumDetailView.h"
#import "AlbumSongsTableViewCell.h"
#import "VCMusicPlayer.h"
#import "MusicPlayerManager.h"
@interface VCAlbumDetail ()

@end

@implementation VCAlbumDetail
- (void)loadView {
  self.mainView = [[AlbumDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.view = self.mainView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self setupBackButton];
  [self fetchData];
  self.mainView.tableView.dataSource = self;
  self.mainView.tableView.delegate = self;
  [self.mainView.tableView registerClass:[AlbumSongsTableViewCell class] forCellReuseIdentifier:@"AlbumSongsTableViewCell"];
  [self.mainView.tableView reloadData];
}

- (void) fetchData {
  __weak typeof (self) weakSelf = self;
//  [[MusicPlayerManager shared] fentchID:self.IDStr];
  [SpotifyArtistAPIModel fetchAlbumsTracksWithID:self.IDStr completion:^(NSArray<SpotifySongsModels *> * _Nonnull models, NSError * _Nonnull error) {
    if (error) {
      NSLog(@"发生错误 %@", error);
      return;
    }
    if (models.count > 0) {
      dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.allmodels = models;
        NSLog(@"歌曲数据%@", weakSelf.allmodels);
        [self.mainView updateWithTitle:models.firstObject.track imageURL:models.firstObject.picURl];
        [weakSelf.mainView.tableView reloadData];
      });
    }
  }];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
