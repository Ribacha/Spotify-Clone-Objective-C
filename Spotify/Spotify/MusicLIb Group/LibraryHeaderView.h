//
//  LibraryHeaderView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/9.
//

#import <UIKit/UIKit.h>
#import "MusicLibraryModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol LibraryHeaderViewDelegate <NSObject>
- (void) didTapAvatar;
@end

@interface LibraryHeaderView : UICollectionReusableView
@property (nonatomic, weak) id<LibraryHeaderViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
- (void) updateWithUser: (UserProfileModel *)user;
@end

NS_ASSUME_NONNULL_END
