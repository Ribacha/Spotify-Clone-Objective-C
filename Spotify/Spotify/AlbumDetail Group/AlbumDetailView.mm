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
  self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 360)];
  self.headerView.backgroundColor = [UIColor blackColor];
  self.RecommendImage = [[UIImageView alloc] init];
  self.RecommendImage.contentMode = UIViewContentModeScaleAspectFit;
  self.RecommendImage.clipsToBounds = YES;
  [self.headerView addSubview:self.RecommendImage];
  [self.RecommendImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.headerView).offset(50);
    make.centerX.equalTo(self.headerView);
    make.width.height.mas_equalTo(200);
  }];
  self.RecommendLabel = [[UILabel alloc] init];
  self.RecommendLabel.textColor = [UIColor whiteColor];
  self.RecommendLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:35];
  self.RecommendLabel.adjustsFontSizeToFitWidth = YES;
  [self.headerView addSubview:self.RecommendLabel];
  [self.RecommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.RecommendImage.mas_bottom).offset(30);
    make.centerX.equalTo(self.headerView);
    make.width.lessThanOrEqualTo(self.headerView).offset(-40);
  }];
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.font = [UIFont systemFontOfSize:14];
    self.descLabel.numberOfLines = 3; // 默认最多显示 3 行
    [self.headerView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.RecommendLabel.mas_bottom).offset(15);
      make.left.right.equalTo(self.headerView).inset(20);
    }];
    self.expandButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.expandButton setTitle:@"展开" forState:UIControlStateNormal];
    [self.expandButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.expandButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.expandButton addTarget:self action:@selector(toggleExpandAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.expandButton];

    [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.descLabel.mas_bottom).offset(5);
      make.right.equalTo(self.headerView).offset(-20);
      make.bottom.equalTo(self.headerView).offset(-20);
    }];
  self.tableView.tableHeaderView = self.headerView;

}
#pragma mark - 简介展开
- (void)toggleExpandAction {
    self.isExpanded = !self.isExpanded;
    if (self.isExpanded) {
        self.descLabel.numberOfLines = 0;
        [self.expandButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        self.descLabel.numberOfLines = 3;
        [self.expandButton setTitle:@"展开" forState:UIControlStateNormal];
    }
    [self.tableView beginUpdates];
    [UIView animateWithDuration:0.3 animations:^{
        [self updateHeaderViewHeight];
        [self.headerView layoutIfNeeded];
    }];
    [self.tableView endUpdates];
}


- (void)updateHeaderViewHeight {
    self.descLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 40;
    [self.headerView setNeedsLayout];
    [self.headerView layoutIfNeeded];
    CGSize targetSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, UILayoutFittingCompressedSize.height);
    CGFloat height = [self.headerView systemLayoutSizeFittingSize:targetSize
                                    withHorizontalFittingPriority:UILayoutPriorityRequired
                                          verticalFittingPriority:UILayoutPriorityFittingSizeLevel].height;
    CGRect frame = self.headerView.frame;
    if (frame.size.height != height) {
        frame.size.height = height;
        self.headerView.frame = frame;
        self.tableView.tableHeaderView = self.headerView;
    }
}
- (void) updateWithTitle: (NSString*) title imageURL: (NSURL*) url descText: (NSString*) descText {
    self.RecommendLabel.text = title;
    [self.RecommendImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    if (!descText || descText.length == 0) {
        self.descLabel.text = @"暂无歌单简介";
        self.expandButton.hidden = YES;
    } else {
        self.descLabel.text = descText;
        self.expandButton.hidden = NO;
    }
    [self updateHeaderViewHeight];
}

@end
