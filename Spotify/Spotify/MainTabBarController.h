//
//  MainTabBarController.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import <UIKit/UIKit.h>
#import "MiniPlayerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainTabBarController : UITabBarController
@property (nonatomic, strong) MiniPlayerView *minPlayerView;
@end

NS_ASSUME_NONNULL_END
