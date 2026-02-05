//
//  VCMusicPlayer.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/8.
//

#import <UIKit/UIKit.h>
#import "MusicPlayerManager.h"
#import "MusicPlayerDetailView.h"
NS_ASSUME_NONNULL_BEGIN

@interface VCMusicPlayer : UIViewController<MusicPlayerDetailViewDelegate>
@property (nonatomic, strong) MusicPlayerDetailView *mainView;
@end

NS_ASSUME_NONNULL_END
