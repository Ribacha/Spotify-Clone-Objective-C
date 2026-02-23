//
//  VCMusicLibrary.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import "VCMusicLibrary.h"
#import <UIKit/UIKit.h>
#import "MusicLibraryModel.h"
#import "LibraryMenuCell.h"
#import "LibraryRootView.h"
#import "LibraryHeaderView.h"
#import "VCLikeSongsLib.h"
#import "VCDownLoadSongsLib.h"
@interface VCMusicLibrary ()

@end

@implementation VCMusicLibrary
- (void)loadView {
  self.rootView = [[LibraryRootView alloc] init];
  self.view = self.rootView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupData];
  self.rootView.collectionView.delegate = self;
  self.rootView.collectionView.dataSource = self;
  [self.rootView.collectionView reloadData];

}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}
#pragma mark - SetData
- (void) setupData {
  self.currentUser = [[UserProfileModel alloc] init];
  self.currentUser.userName = @"Guts";
  self.currentUser.avatorImage = [UIImage imageNamed:@"default_avatar"];
  self.menuItem = @[
    [LibraryMeunItem itemWithTitle:@"收藏歌曲" type:LibraryActionTypeLiked],
    [LibraryMeunItem itemWithTitle:@"下载歌曲" type:LibraryActionTypeDownLoad],
    [LibraryMeunItem itemWithTitle:@"最近收听" type:LibraryActionTypeRecent],
    [LibraryMeunItem itemWithTitle:@"本地音乐" type:LibraryActionTypeLocal]
  ];
}
#pragma mark - collectinView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.menuItem.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  LibraryMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LibraryMenuCell" forIndexPath:indexPath];
  [cell configureWithItem:self.menuItem[indexPath.row]];
  return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    LibraryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LibraryHeaderView"  forIndexPath:indexPath];
    headerView.delegate = self;
    [headerView updateWithUser:self.currentUser];
    return headerView;
  }
  return [[UICollectionReusableView alloc] init];
}
#pragma mark - collectinView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  LibraryMeunItem *item = self.menuItem[indexPath.row];
  switch (item.type) {
    case LibraryActionTypeLiked: {
      VCLikeSongsLib *likeMusicVC = [[VCLikeSongsLib alloc] init];
      likeMusicVC.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:likeMusicVC animated:YES];
      NSLog(@"点击了收藏音乐");
    }
      break;
    case LibraryActionTypeDownLoad: {
      VCDownLoadSongsLib *downLoadMusicVC = [[VCDownLoadSongsLib alloc] init];
      downLoadMusicVC.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:downLoadMusicVC animated:YES];
      NSLog(@"点击了下载音乐");
    }
      break;
    default:
      break;
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offsetY = scrollView.contentOffset.y;
  [self.rootView updateBlurAlphaWithScrollOffset:offsetY];
  [self.rootView updateParallaxBackgroundWithOffset:offsetY];
}
@end
