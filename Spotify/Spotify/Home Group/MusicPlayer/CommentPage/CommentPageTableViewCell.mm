//
//  CommentPageTableViewCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import "CommentPageTableViewCell.h"
#import "Masonry/Masonry.h"
#import "SDWebImage/SDWebImage.h"
@implementation CommentPageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
  }
  return self;
}
- (void) setupUI {
  self.avatarImageView = [[UIImageView alloc] init];
  self.avatarImageView.layer.cornerRadius = 20;
  self.avatarImageView.clipsToBounds = YES;
  [self.contentView addSubview:self.avatarImageView];
  [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.equalTo(self.contentView).offset(15);
    make.width.height.mas_equalTo(40);
  }];
  self.nameLabel = [[UILabel alloc] init];
  self.nameLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:15];
  self.nameLabel.textColor = [UIColor whiteColor];
  [self.contentView addSubview:self.nameLabel];
  [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImageView.mas_right).offset(10);
    make.top.equalTo(self.avatarImageView.mas_top);
  }];
  self.timeLabel = [[UILabel alloc] init];
  self.timeLabel.font = [UIFont fontWithName:@"NotoSerifTC-Light" size:12];
  self.timeLabel.textColor = [UIColor whiteColor];
  [self.contentView addSubview:self.timeLabel];
  [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.avatarImageView.mas_bottom);
    make.left.equalTo(self.nameLabel.mas_left);
  }];
  self.commentLabel = [[UILabel alloc] init];
  self.commentLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:16];
  self.commentLabel.textColor = [UIColor whiteColor];
  [self.contentView addSubview:self.commentLabel];
  [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.avatarImageView.mas_bottom).offset(15);
    make.left.equalTo(self.contentView).offset(15);
    make.right.equalTo(self.contentView).offset(-15);
  }];
  self.expandButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [self.expandButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  self.expandButton.titleLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:14];
  [self.expandButton addTarget:self action:@selector(expandTapped) forControlEvents:UIControlEventTouchUpInside];
  [self.contentView addSubview:self.expandButton];
  [self.expandButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.commentLabel);
    make.top.equalTo(self.commentLabel.mas_bottom).offset(5);
    self.expandButtonHeightConstraint = make.height.mas_equalTo(20);
  }];
  self.replyBgView = [[UIView alloc] init];
  self.replyBgView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3];
  self.replyBgView.layer.cornerRadius = 6;
  self.replyBgView.clipsToBounds = YES;
  [self.contentView addSubview:self.replyBgView];
  [self.replyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.expandButton.mas_bottom).offset(5);
    make.left.equalTo(self.commentLabel);
    make.right.equalTo(self.contentView).offset(-15);
    make.bottom.equalTo(self.contentView).offset(-15).priority(999);
  }];
  self.replyStackView = [[UIStackView alloc] init];
  self.replyStackView.axis = UILayoutConstraintAxisVertical;
  self.replyStackView.spacing = 6;
  self.replyStackView.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8);
  self.replyStackView.layoutMarginsRelativeArrangement = YES;
  [self.contentView addSubview:self.replyStackView];
  [self.replyStackView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.replyBgView);
  }];



}
- (void)configureModelWithComment:(CommentPageModel *)model {
  [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
  self.nameLabel.text = model.userName;
  self.timeLabel.text = model.timeStr;
  self.commentLabel.text = model.content;
  if (model.needsExpandButton) {
    self.expandButton.hidden = NO;
    self.expandButtonHeightConstraint.mas_equalTo(20);
    if (model.isExpand) {
      self.commentLabel.numberOfLines = 0;
      [self.expandButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
      self.commentLabel.numberOfLines = 3;
      [self.expandButton setTitle:@"展开" forState:UIControlStateNormal];
    }
  } else {
    self.commentLabel.numberOfLines = 0;
    self.expandButton.hidden = YES;
    self.expandButtonHeightConstraint.mas_equalTo(0);
  }
  [self.replyStackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  if (model.beReplied.count > 0) {
    self.replyBgView.hidden = NO;
    for (CommentPageRepliedModel *reply in model.beReplied) {
      UIView *replyBubbleView = [self creatReplyViewWithModel:reply];
      [self.replyStackView addArrangedSubview:replyBubbleView];
    }
    [self.replyBgView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.expandButton.mas_bottom).offset(5);
    }];
  } else {
    self.replyBgView.hidden = YES;
    [self.replyBgView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.expandButton.mas_bottom).offset(0);
    }];
  }

}
- (void) expandTapped {
  if (self.expendButtonTappedBlock) {
    self.expendButtonTappedBlock();
  }
}
- (UIView *) creatReplyViewWithModel :(CommentPageRepliedModel *)reply {
  UIView *container = [[UIView alloc] init];
  UIImageView *avatarView= [[UIImageView alloc] init];
  avatarView.layer.cornerRadius = 12;
  avatarView.layer.masksToBounds = YES;
  [avatarView sd_setImageWithURL:[NSURL URLWithString:reply.avatarUrl]];
  [container addSubview:avatarView];
  [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.equalTo(container).offset(6);
    make.size.mas_equalTo(CGSizeMake(24, 24));
  }];
  UILabel *nameLabel = [[UILabel alloc] init];
  nameLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:13];
  nameLabel.textColor = [UIColor whiteColor];
  nameLabel.text = reply.userName;
  [container addSubview:nameLabel];
  [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(avatarView.mas_right).offset(8);
    make.top.equalTo(avatarView);
  }];
  UILabel *timeLabel = [[UILabel alloc] init];
  timeLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:10];
  timeLabel.textColor = [UIColor grayColor];
  timeLabel.text = reply.timeStr;
  [container addSubview:timeLabel];
  [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(nameLabel.mas_right).offset(6);
    make.centerY.equalTo(nameLabel);
  }];
  UILabel *replyCommentLabel = [[UILabel alloc] init];
  replyCommentLabel.font = [UIFont fontWithName:@"NotoSerifTC-ExtraBold" size:15];
  replyCommentLabel.textColor = [UIColor whiteColor];
  replyCommentLabel.text = reply.content;
  replyCommentLabel.numberOfLines = 0;
  [container addSubview:replyCommentLabel];
  [replyCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(nameLabel);
    make.top.equalTo(nameLabel.mas_bottom).offset(4);
    make.right.equalTo(container).offset(-6);
    make.bottom.equalTo(container).offset(-6);
  }];
  return container;
}
@end
