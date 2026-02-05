//
//  MusicCardCollectionView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/24.
//

#import "MusicCardCollectionView.h"
#import "Masonry/Masonry.h"
#import "SDWebImage/SDWebImage.h"
@implementation MusicCardCollectionView
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.contentView.backgroundColor = [UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:1.0];
  self.contentView.layer.cornerRadius = 4;
  self.contentView.clipsToBounds = YES;

  self.coverImageView = [[UIImageView alloc] init];
  self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
  self.coverImageView.clipsToBounds = YES;
  [self.contentView addSubview:self.coverImageView];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = [UIColor whiteColor];
  self.titleLabel.font = [UIFont systemFontOfSize:13];
  self.titleLabel.numberOfLines = 2;
  [self.contentView addSubview:self.titleLabel];

  [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.bottom.equalTo(self.contentView);
    make.width.equalTo(self.coverImageView.mas_height);
  }];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.coverImageView.mas_right).offset(8);
    make.right.equalTo(self.contentView).offset(-8);
    make.centerY.equalTo(self.contentView);
  }];
}
- (void)configureWithModel:(SpotifyModels *)model {
    self.titleLabel.text = model.name;

    // --- 修改开始 ---
    // 直接使用我们在 Model 里映射好的 imageUrl
    NSURL *url = nil;
    if (model.imageUrl && model.imageUrl.length > 0) {
        url = [NSURL URLWithString:model.imageUrl];
    }

    [self.coverImageView sd_setImageWithURL:url
                           placeholderImage:[UIImage imageNamed:@"placeholder"]];
    // --- 修改结束 ---
}

@end
