//
//  LibraryRootView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/9.
//

#import "LibraryRootView.h"
#import "LibraryMenuCell.h"
#import "LibraryHeaderView.h"
#import "Masonry/Masonry.h"
@implementation LibraryRootView
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.backgroundColor = [UIColor blackColor];
  self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_bg"]];
  self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.backgroundImageView.clipsToBounds = YES;
  [self addSubview:self.backgroundImageView];
  [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.right.equalTo(self);
    make.height.mas_equalTo(350);
  }];

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  CGFloat width = ([UIScreen mainScreen].bounds.size.width - 48) / 2;
  layout.itemSize = CGSizeMake(width, 100);
  layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
  layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);

  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = [UIColor clearColor];
  [self.collectionView registerClass:[LibraryMenuCell class] forCellWithReuseIdentifier:@"LibraryMenuCell"];
  [self.collectionView registerClass:[LibraryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LibraryHeaderView"];
  [self addSubview:self.collectionView];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  self.collectionView.alwaysBounceVertical = YES;
  UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
  self.blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
  self.blurView.alpha = 0;
  [self addSubview:self.blurView];
  [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.right.equalTo(self);
    make.height.mas_equalTo(100);
  }];
}
- (void) updateBlurAlphaWithScrollOffset: (CGFloat)offsetY {
  CGFloat maxAlphaOffset = 150.0;
  CGFloat alpha = offsetY / maxAlphaOffset;
  self.blurView.alpha = alpha;
}
- (void) updateParallaxBackgroundWithOffset: (CGFloat) offsetY {
  if (offsetY < 0) {
    [self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self).offset(offsetY);
      make.height.mas_equalTo(350 - offsetY);
    }];
  } else {
    [self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self).offset(-offsetY * 0.5);
      make.height.mas_equalTo(350);
    }];
  }
}
@end
