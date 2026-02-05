//
//  MusicPlayerDetailView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/9.
//

#import "MusicPlayerDetailView.h"
#import "Masonry/Masonry.h"
#import "SpotifySongsModels.h"
#import "SDWebImage/SDWebImage.h"
@interface MusicPlayerDetailView ()
@end

@implementation MusicPlayerDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.coverImage = [[UIImageView alloc] init];
  self.coverImage.layer.cornerRadius = 10;
  self.coverImage.clipsToBounds = YES;
  self.coverImage.contentMode = UIViewContentModeScaleAspectFill;
  [self addSubview:self.coverImage];
  [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.mas_safeAreaLayoutGuideTop).offset(50);
    make.centerX.equalTo(self);
    make.width.height.mas_equalTo(300);
  }];
  self.songLabel = [[UILabel alloc] init];
  self.songLabel.textColor = [UIColor whiteColor];
  self.songLabel.font = [UIFont systemFontOfSize:24];
  self.songLabel.textAlignment = NSTextAlignmentCenter;
  [self addSubview:self.songLabel];
  [self.songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.coverImage.mas_bottom).offset(30);
    make.left.right.equalTo(self).inset(20);
  }];
  self.progressSlider = [[UISlider alloc] init];
  self.progressSlider.minimumTrackTintColor = [UIColor whiteColor];
  self.progressSlider.maximumTrackTintColor = [UIColor darkGrayColor];
  self.progressSlider.thumbTintColor = [UIColor whiteColor];
  [self.progressSlider addTarget:self action:@selector(sliderTouchDown) forControlEvents:UIControlEventTouchDown];
  [self.progressSlider addTarget:self action:@selector(sliderTouchUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
//  [self.progressSlider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
  [self addSubview:self.progressSlider];
  [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.songLabel.mas_bottom).offset(70);
    make.left.right.equalTo(self).inset(20);
  }];
  self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//  [self.playButton setImage:[UIImage systemImageNamed:@"pause.circle.fill"] forState:UIControlStateNormal];
  [self updatePlayState:NO];
  self.playButton.tintColor = [UIColor whiteColor];
  [self.playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.playButton];
  UIButton *prevBtn = [self createControlBtn:@"backward.end.fill" action:@selector(prevAction)];
  UIButton *nextBtn = [self createControlBtn:@"forward.end.fill" action:@selector(nextAction)];
  [self addSubview:prevBtn];
  [self addSubview:nextBtn];
  [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.progressSlider.mas_bottom).offset(50);
    make.centerX.equalTo(self);
    make.width.height.mas_equalTo(90);
  }];
  [prevBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.playButton);
    make.right.equalTo(self.playButton.mas_left).offset(-70);
    make.width.height.mas_equalTo(80);
  }];
  [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.playButton);
    make.left.equalTo(self.playButton.mas_right).offset(70);
    make.width.height.mas_equalTo(80);
  }];
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
  tapGesture.cancelsTouchesInView = NO;
  [self.progressSlider addGestureRecognizer:tapGesture];
  [self.progressSlider addTarget:self action:@selector(sliderTouchDown) forControlEvents:UIControlEventTouchDown];
}
- (void) playAction {
  if ([self.delegate respondsToSelector:@selector(playerViewDidTapPlayPause)]) {
    [self.delegate playerViewDidTapPlayPause];
  }
}
- (void) prevAction {
  if ([self.delegate respondsToSelector:@selector(playerViewDidTapPreivous)]) {
    [self.delegate playerViewDidTapPreivous];
  }
}
- (void) nextAction {
  if ([self.delegate respondsToSelector:@selector(playerViewDidTapNext)]){
    [self.delegate playerViewDidTapNext];
  }
}
- (UIButton *)createControlBtn:(NSString *)imgName action:(SEL)sel {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:30 weight:UIImageSymbolWeightRegular];
    UIImage *img = [UIImage systemImageNamed:imgName withConfiguration:config];

    [btn setImage:img forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void) updatePlayState: (BOOL) isPlaying {
  NSString *imageName = isPlaying ? @"pause.circle.fill" : @"play.circle.fill";
  UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:80 weight:UIImageSymbolWeightMedium];
  UIImage *img = [UIImage systemImageNamed:imageName withConfiguration:config];
  [self.playButton setImage:img forState:UIControlStateNormal];
}
- (void) updateWithModel: (SpotifySongsModels *) models {
  self.songLabel.text = models.track;
  [self.coverImage sd_setImageWithURL:[NSURL URLWithString: models.picURl]];
  self.artistLabel.text = models.artist;
}
- (void) updateProgress: (NSTimeInterval) current total:(NSTimeInterval) total {
  if (!self.isFlag) {
    self.progressSlider.maximumValue = total;
    self.progressSlider.value = current;
  }
}
- (void) sliderTouchDown {
  self.isFlag = YES;
}
- (void) sliderTouchUp {
  self.isFlag = NO;
  if ([self.delegate respondsToSelector:@selector(playerViewDidSeekToTime:)]) {
    [self.delegate playerViewDidSeekToTime:self.progressSlider.value];
  }
}
- (void) handleTap: (UITapGestureRecognizer *)gesture {
  CGPoint touchPoint = [gesture locationInView:self.progressSlider];
  CGFloat width = self.progressSlider.frame.size.width;
  float ratio = touchPoint.x / width;
  float seekTime = self.progressSlider.maximumValue * ratio;
  [self.progressSlider setValue:seekTime animated:YES];
  if ([self.delegate respondsToSelector:@selector(playerViewDidSeekToTime:)]) {
    [self.delegate playerViewDidSeekToTime:seekTime];
  }
}
@end
