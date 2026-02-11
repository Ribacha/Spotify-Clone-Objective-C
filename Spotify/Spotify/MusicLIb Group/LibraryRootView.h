//
//  LibraryRootView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LibraryRootView : UIView
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *blurView;
- (void) updateBlurAlphaWithScrollOffset: (CGFloat)offsetY;
- (void) updateParallaxBackgroundWithOffset: (CGFloat) offsetY;
@end

NS_ASSUME_NONNULL_END
