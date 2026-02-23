//
//  MusicPlayerDetailView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/9.
//

#import <UIKit/UIKit.h>
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MusicPlayerDetailViewDelegate <NSObject>
- (void) playerViewDidTapPlayPause;
- (void) playerViewDidTapNext;
- (void) playerViewDidTapPreivous;
- (void) playerViewDidSeekToTime: (NSTimeInterval) time;
- (void) playerViewDidTapLikeButton;
- (void) playerViewDidTapDownLoadButton;
@end


@interface MusicPlayerDetailView : UIView
@property (nonatomic, weak) id<MusicPlayerDetailViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *songLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UISlider *progressSlider;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *downLoadButton;
@property (nonatomic, assign) BOOL isFlag;
- (void)updatePlayState:(BOOL)isPlaying;
- (void) updateWithModel: (SpotifySongsModels *) models;
- (void) updateProgress: (NSTimeInterval) current total:(NSTimeInterval) total;
- (void) updatelikeState: (BOOL) isLiked;
- (void) updateDownLoadState: (BOOL) isDownLoad;
@end

NS_ASSUME_NONNULL_END
