//
//  MiniPlayerView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/8.
//

#import "MiniPlayerView.h"
#import "SpotifySongsModels.h"
#import "Masonry/Masonry.h"
#import "SDWebImage/SDWebImage.h"
@implementation MiniPlayerView
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self insertSubview:blurView atIndex:0];
    [blurView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
    self.layer.cornerRadius = 30;
    self.clipsToBounds = YES;
    //毛玻璃圆角效果
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletap)];
    [self addGestureRecognizer:tap];
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.coverImageView = [UIImageView new];
  self.coverImageView.layer.cornerRadius = 16;
  self.coverImageView.clipsToBounds = YES;
  self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.coverImageView.backgroundColor = [UIColor whiteColor];
  [self addSubview:self.coverImageView];
  self.titleLabel = [UILabel new];
  self.titleLabel.textColor = [UIColor whiteColor];
  self.titleLabel.font = [UIFont systemFontOfSize:14];
  [self addSubview:self.titleLabel];
  self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.playButton setTintColor:[UIColor whiteColor]];
  [self.playButton addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
  [self.playButton setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
  [self addSubview:self.playButton];
  [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(15);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(40);
  }];
  [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-15);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(30);
  }];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.coverImageView.mas_right).offset(10);
    make.right.equalTo(self.playButton.mas_left).offset(-10);
    make.centerY.equalTo(self);
  }];
}
- (void) playBtnClick {
  if (self.playButtonAction) {
    self.playButtonAction(YES);
  }
}
- (void) handletap {
  if (self.tapAction) {
    self.tapAction();
  }
}
- (void) updatePLayStatus: (BOOL) isPlaying {
  NSString *imageName = isPlaying ? @"pause.fill" : @"play.fill";
  [self.playButton setImage:[UIImage systemImageNamed:imageName] forState:UIControlStateNormal];
}
- (void) updateWithModelInfo :(SpotifySongsModels *) models {
  self.titleLabel.text = models.track;
  [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:models.picURl]];
}
@end
