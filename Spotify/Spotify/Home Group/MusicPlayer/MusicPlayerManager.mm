//
//  MusicPlayerManager.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/9.
//

#import "MusicPlayerManager.h"
#import "SpotifySongsModels.h"
#import "MiniPlayerView.h"
#import "SpotifyArtistAPIModel.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicPlayerManager ()

@end

@implementation MusicPlayerManager
static MusicPlayerManager *_instance = nil;

+ (instancetype) shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[super allocWithZone:NULL] init];
  });
  return _instance;
}

- (instancetype) init {
  self = [super init];
  if (self) {
    self.isPlaying = NO;
  }
  return self;
}

- (void) pause {
  if (self.player) {
    [self.player pause];
  }
  self.isPlaying = NO;
  [self postStateNotification];
}

- (void) play {
  if (self.player) {
    [self.player play];
  }
  self.isPlaying = YES;
  [self postStateNotification];
}

- (void) togglePlayPause {
  if (self.isPlaying) {
    [self pause];
    self.isPlaying = NO;
  } else {
    [self play];
    self.isPlaying = YES;
  }
  [self postStateNotification];
}

- (void) playNext {
  if (self.playlist == 0) {
    return;
  }
  self.currentindex++;
  if (self.currentindex >= self.playlist.count) {
    self.currentindex = 0;
  }
  [self playMusic:self.playlist[self.currentindex]];
}

- (void) playPrevious {
  if (self.playlist.count == 0) {
    return;
  }
  self.currentindex--;
  if (self.currentindex < 0) {
    self.currentindex = self.playlist.count - 1;
  }
  [self playMusic:self.playlist[self.currentindex]];
}

- (void) postStateNotification {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicPlayerStateDidChangeNotification" object:nil];
}

- (void) playMusic: (SpotifySongsModels *) models {
  self.currentModel = models;
  self.isPlaying = YES;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicPlayerDidChangeSongNotification" object:nil];
  [self postStateNotification];
  NSLog(@"马上播放： %@，歌曲 id：%@ ",models.track, models.songID);
  __weak typeof(self) weakSelf = self;
  [SpotifyArtistAPIModel fetchMusicURLWithID:models.songID completion:^(NSString * _Nullable muiscURL, NSError * _Nullable error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!weakSelf) {
        return;
      }
      if (error || !muiscURL) {
        NSLog(@"失败");
        return;
      }
      NSLog(@"成功%@", muiscURL);
      [weakSelf playStreamWithURL:muiscURL];
    });
  }];
}


- (void) playStreamWithURL: (NSString *)url {
  NSURL *songURL = [NSURL URLWithString:url];
  AVPlayerItem *item = [AVPlayerItem playerItemWithURL:songURL];
  if (!self.player) {
    self.player = [AVPlayer playerWithPlayerItem:item];
  } else {
    [self.player replaceCurrentItemWithPlayerItem:item];
  }
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
  if (self.timeObserver) {
    [self.player removeTimeObserver:self.timeObserver];
    self.timeObserver = nil;
  }
  __weak typeof(self) weakSelf = self;
  self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
    NSTimeInterval current = CMTimeGetSeconds(time);
    NSTimeInterval total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
    if (isnan(current) || isnan(total)) {
      return;
    }
    weakSelf.currentTime = current;
    weakSelf.totalDuration = total;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicPlayerProgressDidUpdateNotification" object:nil];
  }];
  [self.player play];
  self.isPlaying = YES;
  [self postStateNotification];
}//播放方法

- (void) seekToTime:(NSTimeInterval) time {
  [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
    if (finished) {
      [self play];
    }
  }];
}
- (void) handlePlayEnd {
  [self playNext];
}

- (void) fetchSongModels:  (NSArray<SpotifySongsModels *> *) playlist {
  self.playlist = playlist;
  NSLog(@"歌单数据 %@", self.playlist);
}
@end
