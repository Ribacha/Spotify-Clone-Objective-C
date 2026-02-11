//
//  LibraryHeaderView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/9.
//

#import "LibraryHeaderView.h"
#import "Masonry/Masonry.h"
#import "MusicLibraryModel.h"
@implementation LibraryHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.backgroundColor = [UIColor clearColor];
  self.avatarImageView = [[UIImageView alloc] init];
  self.avatarImageView.layer.cornerRadius = 33;
  self.avatarImageView.clipsToBounds = YES;
  self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
  [self addSubview:self.avatarImageView];
  [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.mas_left).offset(20);
    make.top.equalTo(self.mas_top).offset(100);
    make.size.mas_equalTo(CGSizeMake(70, 70));
  }];
  self.nameLabel = [[UILabel alloc] init];
  self.nameLabel.textColor = [UIColor whiteColor];
  self.nameLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:30];
  [self addSubview:self.nameLabel];
  [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImageView.mas_right).offset(20);
    make.centerY.equalTo(self.avatarImageView.mas_centerY);
  }];
  ///点击手势
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTapped)];
  [self.avatarImageView addGestureRecognizer:tap];
}
- (void) avatarTapped {
  if (self.delegate && [self.delegate respondsToSelector:@selector(didTapAvatar)]) {
    [self.delegate didTapAvatar];
  }
}
///更新数据
- (void)updateWithUser:(UserProfileModel *)user {
  self.nameLabel.text = user.userName;
  self.avatarImageView.image = user.avatorImage ?: [UIImage imageNamed:@"default_avatar"];
}

@end
