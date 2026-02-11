//
//  LibraryMenuCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/9.
//

#import "LibraryMenuCell.h"
#import "MusicLibraryModel.h"
#import "Masonry/Masonry.h"
@implementation LibraryMenuCell
- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.containerView = [[UIView alloc] init];
  self.containerView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
  self.containerView.layer.cornerRadius = 30;
  self.containerView.clipsToBounds = YES;
  [self.contentView addSubview:self.containerView];
  [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView);
  }];
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:25];
  self.titleLabel.textColor = [UIColor whiteColor];
  [self.containerView addSubview:self.titleLabel];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.containerView);
  }];
}
- (void) configureWithItem: (LibraryMeunItem *)item {
  self.titleLabel.text = item.title;
}
@end
