//
//  MusicPlayerManager.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/9.
//

#import <UIKit/UIKit.h>
#import "SpotifySongsModels.h"
#import "SpotifyArtistAPIModel.h"
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayerManager : NSObject
+ (instancetype) shared ;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) SpotifySongsModels *currentModel;
@property (nonatomic, strong) NSArray <SpotifySongsModels *> *playlist;
@property (nonatomic, assign) NSInteger currentindex;
@property (nonatomic, strong) NSString *IDStr;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, assign) NSTimeInterval currentTime;
@property (nonatomic, assign) NSTimeInterval totalDuration;
@property (nonatomic, strong) id timeObserver;
- (void) pause;
- (void) play;
- (void) postStateNotification;
- (void) togglePlayPause;
- (void) playNext;
- (void) playPrevious;
- (void) playMusic: (SpotifySongsModels *) models;
- (void) fentchID: (NSString *)String;
- (void) fetchSongModels:  (NSArray<SpotifySongsModels *> *) playlist;
- (void) seekToTime:(NSTimeInterval) time;
@end

NS_ASSUME_NONNULL_END
