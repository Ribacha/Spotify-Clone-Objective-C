//
//  MiniPlayerView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/8.
//

#import <UIKit/UIKit.h>
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface MiniPlayerView : UIView
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, copy) void (^playButtonAction) (BOOL isPlaying);
@property (nonatomic, copy) void (^tapAction) (void);
- (void) updatePLayStatus: (BOOL) isPlaying ;
- (void) updateWithModelInfo :(SpotifySongsModels *) models ;
@end

NS_ASSUME_NONNULL_END
