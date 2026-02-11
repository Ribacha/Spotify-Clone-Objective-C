//
//  LibraryMenuCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/9.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class LibraryMeunItem;
@interface LibraryMenuCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *containerView;
- (void) configureWithItem: (LibraryMeunItem *)item ;
@end

NS_ASSUME_NONNULL_END
