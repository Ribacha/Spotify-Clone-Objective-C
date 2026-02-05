//
//  AlbumSongsTableViewCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/1/11.
//

#import "AlbumSongsTableViewCell.h"
#import "Masonry/Masonry.h"
#import "SpotifySongsModels.h"
@implementation AlbumSongsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupTracksInfo];
  }
  return self;
}
- (void) setupTracksInfo {
  self.numberLabel = [[UILabel alloc] init];
  self.numberLabel.textColor = [UIColor lightGrayColor];
  self.numberLabel.font = [UIFont systemFontOfSize:14];
  [self.contentView addSubview:self.numberLabel];
  [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.contentView).offset(10);
    make.centerY.equalTo(self.contentView);
    make.width.mas_equalTo(30);
  }];
  self.songsLabel = [[UILabel alloc] init];
  self.songsLabel.textColor = [UIColor whiteColor];
  self.songsLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
  [self.contentView addSubview:self.songsLabel];
  [self.songsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.numberLabel.mas_right).offset(15);
    make.right.equalTo(self.contentView).offset(15);
    make.top.equalTo(self.contentView).offset(10);
  }];
  self.artistLabel = [[UILabel alloc] init];
  self.artistLabel.textColor = [UIColor grayColor];
  self.artistLabel.font = [UIFont systemFontOfSize:13];
  [self.contentView addSubview:self.artistLabel];
  [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.numberLabel.mas_right).offset(15);
    make.right.equalTo(self.contentView).offset(10);
    make.top.equalTo(self.songsLabel.mas_bottom).offset(5);
  }];

}
- (void) configureModel:(SpotifySongsModels *) models index: (NSInteger) index {
  self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
  self.songsLabel.text = models.track;
  self.artistLabel.text = models.artist;

}
@end
