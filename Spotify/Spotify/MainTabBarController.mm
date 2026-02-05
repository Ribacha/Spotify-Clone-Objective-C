//
//  MainTabBarController.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import "MainTabBarController.h"
#import "VCHomePage.h"
#import "VCSearchPage.h"
#import "VCMusicLibrary.h"
#import "MiniPlayerView.h"
#import "Masonry/Masonry.h"
#import "VCMusicPlayer.h"
#import "MusicPlayerManager.h"
#import "SpotifySongsModels.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  VCHomePage *homePage = [[VCHomePage alloc] init];
  VCSearchPage *SearchPage = [[VCSearchPage alloc] init];
  VCMusicLibrary *MusicLibraryPage = [[VCMusicLibrary alloc] init];
  UINavigationController *navhomePage = [[UINavigationController alloc] initWithRootViewController:homePage];
  UINavigationController *navsearchPage = [[UINavigationController alloc] initWithRootViewController:SearchPage];
  UINavigationController *navmusicLibraryPage = [[UINavigationController alloc] initWithRootViewController:MusicLibraryPage];
  NSArray *arr = @[navhomePage, navsearchPage, navmusicLibraryPage];
  self.viewControllers = arr;
  homePage.title = @"主页";
  homePage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页"
                                                      image:[UIImage systemImageNamed:@"house"]
                                              selectedImage:[UIImage systemImageNamed:@"house.fill"]];
  SearchPage.title = @"搜索";
  SearchPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"搜索"
                                                        image:[UIImage systemImageNamed:@"magnifyingglass"]
                                                selectedImage:nil];
  MusicLibraryPage.title = @"音乐库";
  MusicLibraryPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"音乐库"
                                                              image:[UIImage systemImageNamed:@"books.vertical"]
                                                      selectedImage:[UIImage systemImageNamed:@"books.vertical.fill"]];
  self.tabBar.tintColor = [UIColor greenColor];
  // 播放器
  self.minPlayerView = [[MiniPlayerView alloc] init];
  [self.view addSubview:self.minPlayerView];
  [self.minPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-49);
    make.left.right.equalTo(self.view);
    make.height.mas_equalTo(60);
  }];
  // 跳转播放界面
  [self addNofication];
  __weak typeof (self) weakself = self;
  self.minPlayerView.tapAction = ^{
    NSLog(@"你点击了 mini 播放器");
    VCMusicPlayer *playerVC = [[VCMusicPlayer alloc] init];
    playerVC.modalPresentationStyle = UIModalPresentationAutomatic;//卡片样式zh
    [weakself presentViewController:playerVC animated:YES completion:nil];
  };
  self.minPlayerView.playButtonAction = ^(BOOL isPlaying) {
    [[MusicPlayerManager shared] togglePlayPause];
    NSLog(@"点击了播放");
  };
  // TabBar
  if (@available(iOS 13.0, *)) {
    UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];//创建一个不透明的背景
    appearance.backgroundColor = [UIColor blackColor];
    appearance.stackedLayoutAppearance.normal.iconColor = [UIColor grayColor];
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    appearance.stackedLayoutAppearance.selected.iconColor = [UIColor colorWithRed:29/255.0
                                                                            green:185/255.0
                                                                             blue:84/255.0
                                                                            alpha:1.0];
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:29/255.0
                                                                                                                        green:185/255.0
                                                                                                                         blue:84/255.0
                                                                                                                        alpha:1.0], NSFontAttributeName: [UIFont systemFontOfSize:13.0]};

    self.tabBar.standardAppearance = appearance;
    if (@available(iOS 15.0, *)) {
      self.tabBar.scrollEdgeAppearance = appearance;
    }
  } else {
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor greenColor];
    self.tabBar.unselectedItemTintColor = [UIColor grayColor];
  }
}
- (void) addNofication {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelSongChanged) name:@"MusicPlayerDidChangeSongNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerStateChange) name:@"MusicPlayerStateDidChangeNotification" object:nil];
}
- (void) handelSongChanged {
  SpotifySongsModels *models = [MusicPlayerManager shared].currentModel;
  [self.minPlayerView updateWithModelInfo:models];
}
- (void) handlePlayerStateChange {
  BOOL isPlaying = [MusicPlayerManager shared].isPlaying;
  [self.minPlayerView updatePLayStatus:isPlaying];
}
- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
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
