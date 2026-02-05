//
//  SearchResultCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/1/30.
//

#import "SearchResultCell.h"
#import "Masonry/Masonry.h"
#import "SDWebImage/SDWebImage.h"
@implementation SearchResultCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.coverImage = [[UIImageView alloc] init];
  self.coverImage.backgroundColor = [UIColor grayColor];
  [self.contentView addSubview:self.coverImage];
  [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView.mas_left).offset(16);
    make.centerY.equalTo(self.contentView.mas_centerY);
    make.size.mas_equalTo(CGSizeMake(50, 50));
  }];
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = [UIColor whiteColor];
  [self.contentView addSubview:self.titleLabel];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.coverImage.mas_right).offset(15);
    make.top.equalTo(self.contentView).offset(5);
    make.right.equalTo(self.contentView.mas_right).offset(-30);
  }];
  self.artistLabel = [[UILabel alloc] init];
  self.artistLabel.textColor = [UIColor lightGrayColor];
  [self.contentView addSubview:self.artistLabel];
  [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.coverImage.mas_right).offset(15);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    make.right.equalTo(self.contentView.mas_right).offset(-40);
  }];
}
- (void) setModels:(SpotifySongsModels *)models {
  self.titleLabel.text = models.track;
  self.artistLabel.text = models.artist;
  NSLog(@"%@", models.picURl);
  [self.coverImage sd_setImageWithURL:[NSURL URLWithString:models.picURl]];
}
@end
