//
//  AlbumCollectionViewCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/20.
//

#import "AlbumCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Masonry/Masonry.h"
@implementation AlbumCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupUI];
  }
  return self;
}
- (void)setupUI {
  self.coverImageView = [[UIImageView alloc] init];
  self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.coverImageView.clipsToBounds = YES;
  self.coverImageView.layer.cornerRadius = 4;
  [self.contentView addSubview:self.coverImageView];
  [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.left.right.equalTo(self.contentView);
      make.height.equalTo(self.coverImageView.mas_width);
  }];
  _titleLabel = [[UILabel alloc] init];
  _titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
  _titleLabel.textColor = [UIColor whiteColor];
  _titleLabel.numberOfLines = 1;
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  [self.contentView addSubview:_titleLabel];
  [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.coverImageView.mas_bottom).offset(5);
    make.left.right.equalTo(self.contentView);
    make.height.mas_equalTo(20);
  }];
}
- (void)configureWithAlbum:(SpotifyModels *)album {
    self.titleLabel.text = album.name;

    // --- 修改开始 ---
    // 移除所有复杂的 if (album.images.count > 0) 判断
    // 直接使用 imageUrl
    NSURL *url = nil;
    if (album.imageUrl.length > 0) {
        url = [NSURL URLWithString:album.imageUrl];
    }

    [self.coverImageView sd_setImageWithURL:url
                           placeholderImage:[UIImage imageNamed:@"placeholder_cover"]
                                    options:SDWebImageRetryFailed];
    // --- 修改结束 ---
}
@end
