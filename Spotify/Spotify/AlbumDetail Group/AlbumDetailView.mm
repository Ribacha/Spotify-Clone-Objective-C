//
//  AlbumDetailView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/1/11.
//

#import "AlbumDetailView.h"
#import "Masonry/Masonry.h"
#import "SDWebImage/SDWebImage.h"
@implementation AlbumDetailView
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
  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  self.tableView.backgroundColor = [UIColor blackColor];
  [self addSubview:self.tableView];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 360)];
  headerView.backgroundColor = [UIColor blackColor];
  self.RecommendImage = [[UIImageView alloc] init];
  self.RecommendImage.contentMode = UIViewContentModeScaleAspectFit;
  self.RecommendImage.clipsToBounds = YES;
  [headerView addSubview:self.RecommendImage];
  [self.RecommendImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(headerView).offset(50);
    make.centerX.equalTo(headerView);
    make.width.height.mas_equalTo(200);
  }];
  self.RecommendLabel = [[UILabel alloc] init];
  self.RecommendLabel.textColor = [UIColor whiteColor];
  self.RecommendLabel.font = [UIFont systemFontOfSize:35];
  self.RecommendLabel.adjustsFontSizeToFitWidth = YES;
  [headerView addSubview:self.RecommendLabel];
  [self.RecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.RecommendImage.mas_bottom).offset(30);
//    make.left.right.equalTo(self).inset(20);
    make.centerX.equalTo(headerView);
    make.width.lessThanOrEqualTo(headerView).offset(-40);
  }];
  self.tableView.tableHeaderView = headerView;

}
- (void) updateWithTitle: (NSString*) title imageURL: (NSURL*) url {
  self.RecommendLabel.text = title;
  [self.RecommendImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
