//
//  CommentPageTableViewCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import <UIKit/UIKit.h>
#import "Masonry/Masonry.h"
#import "CommentPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentPageTableViewCell : UITableViewCell
@property (nonatomic, copy) void (^expendButtonTappedBlock) (void);
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIButton *expandButton;
@property (nonatomic, strong) UIView *replyBgView;
@property (nonatomic, strong) UIStackView *replyStackView;
@property (nonatomic, strong) MASConstraint *expandButtonHeightConstraint;
- (void) configureModelWithComment :(CommentPageModel *) model;
@end

NS_ASSUME_NONNULL_END
