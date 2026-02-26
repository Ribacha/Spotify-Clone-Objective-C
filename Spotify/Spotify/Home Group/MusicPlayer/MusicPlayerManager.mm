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
#import "MusicDBModel.h"
@interface MusicPlayerManager ()

@end
@implementation MusicPlayerManager
static MusicPlayerManager *_instance = nil;
static NSInteger const maxCacheSize = 100 * 1024 * 1024;

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

//获取SandBox缓存目录
- (NSString *) getCacheDictionary {
  NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  NSString *musicCacheDir = [cachePath stringByAppendingPathComponent:@"musicCache"];
  NSFileManager *manager = [NSFileManager defaultManager];
  if (![manager fileExistsAtPath:musicCacheDir]) {
    [manager createDirectoryAtPath:musicCacheDir withIntermediateDirectories:YES attributes:nil error:nil];
  }
  return musicCacheDir;
}
//获取SandBox下载目录
- (NSString *) getDownloadDictionary {
  NSString *downLoadPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  NSString *dir = [downLoadPath stringByAppendingString:@"downLoadSpace"];
  NSFileManager *manager = [NSFileManager defaultManager];
  if (![manager fileExistsAtPath:dir]) {
    [manager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
  }
  return dir;
}
//获取缓存绝对路径
- (NSString *)getLocalPathForSongID: (NSString *)songID {
  return [[self getCacheDictionary] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", songID]];
}
//获取下载绝对路径
- (NSString *) getLocalDownLoadPathForSongID: (NSString *)songID {
  return [[self getDownloadDictionary] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", songID]];
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
//播放音乐代码
- (void) playMusic: (SpotifySongsModels *) models {
  self.currentModel = models;
  self.isPlaying = YES;
  self.isPreloadingNextSong = NO;
  BOOL isLiked = [[MusicDBModel shared] isSongLiked:self.currentModel.songID];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicPlayerDidChangeSongNotification" object:nil userInfo:@{
    @"isLiked" : @(isLiked)
  }];
  [self postStateNotification];
  NSString *localPath = [self getLocalPathForSongID:models.songID];
  if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
    NSLog(@"内存中含有,播放本地歌曲");
    [self playStreamWithURL:localPath];
    [self touchFileToCheckIn:localPath];
    return;
  }
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
      models.songUrl = muiscURL;
      NSLog(@"成功%@", muiscURL);
      [weakSelf playStreamWithURL:muiscURL];
      [weakSelf downLoadSongInBackGround:models];
    });
  }];
}
//下载缓存代码
- (void) downLoadSongInBackGround: (SpotifySongsModels *) models {
  NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:models.songUrl]];
  [[[NSURLSession sharedSession] downloadTaskWithRequest:req completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error && location) {
      NSString *destPath = [self getLocalPathForSongID:models.songID];

      NSFileManager *fileManager = [NSFileManager defaultManager];
      if ([fileManager fileExistsAtPath:destPath]) {
        [fileManager removeItemAtPath:destPath error:nil];
      }
      [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:destPath] error:nil];
      NSLog(@"下载完成");
      NSLog(@"%@", [self getCacheDictionary]);
    }
  }] resume];
  [self checkAndPruneCache];
}
//下载音乐代码
- (void) downLoadCurrentSongForUser {
  if (!self.currentModel) {
    return;
  }
  SpotifySongsModels *models = self.currentModel;
  if ([self isSongDownLoad:models.songID]) {
    NSLog(@"已经下载在音乐库中了");
    NSLog(@"%@", [self getDownloadDictionary]);
    return;
  }
  NSLog(@"开始手动下载");
  NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:models.songUrl]];
  [[[NSURLSession sharedSession] downloadTaskWithRequest:req completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error && location) {
      NSString *destPath = [self getLocalDownLoadPathForSongID:models.songID];

      NSFileManager *fileManager = [NSFileManager defaultManager];
      if ([fileManager fileExistsAtPath:destPath]) {
        [fileManager removeItemAtPath:destPath error:nil];
      }
      [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:destPath] error:nil];
      [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:destPath] error:nil];
      [[MusicDBModel shared] saveDownLoadSongs:models];
      NSLog(@"下载完成");
      dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicDownLoadDidFinishedNotification" object:nil];
      });
      NSLog(@"%@", [self getDownloadDictionary]);

    }
  }] resume];

}
- (BOOL) isSongDownLoad: (NSString *)songID {
  NSString *fileName = [NSString stringWithFormat:@"%@.mp3", songID];
  NSString *path = [[self getDownloadDictionary] stringByAppendingPathComponent:fileName];
  return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
//LRU 清除缓存代码
- (void) checkAndPruneCache {
  NSFileManager *file = [NSFileManager defaultManager];
  NSString *dir = [self getCacheDictionary];
  NSArray *files = [file contentsOfDirectoryAtPath:dir error:nil];
  NSMutableArray *fileInfos = [NSMutableArray array];
  NSInteger totalSizes = 0;
  for (NSString *name in files) {
    NSString *path = [dir stringByAppendingPathComponent:name];
    NSDictionary *attr = [file attributesOfItemAtPath:path error:nil];
    totalSizes += [attr fileSize];
    [fileInfos addObject:@{
      @"path" : path,
      @"date" : [attr fileModificationDate],
      @"size" : @([attr fileSize])
    }];
  }
    if (totalSizes < maxCacheSize) {
      return;
    }
    NSLog(@"超出开始清理");
    [fileInfos sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
      return  [obj1[@"date"] compare:obj2[@"date"]];
    }];
    for (NSDictionary *info in fileInfos) {
      if (totalSizes < maxCacheSize) {
        return;
      }
      [file removeItemAtPath:info[@"path"] error:nil];
      totalSizes -= [info[@"size"] unsignedIntegerValue];
      NSLog(@"已经清除缓存");
    }
}

//播放方法
- (void) playStreamWithURL: (NSString *)url {
  NSURL *songURL = nil;
  if ([url hasPrefix:@"http"] || [url hasPrefix:@"https"]) {
    songURL = [NSURL URLWithString:url];
  } else {
    songURL = [NSURL fileURLWithPath:url];
  }
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
    if (total > 0 && (total - current) <= 15.0) {
      if (!weakSelf.isPreloadingNextSong) {
        [weakSelf startPreloadNextSong];
      }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicPlayerProgressDidUpdateNotification" object:nil];
  }];
  [self.player play];
  self.isPlaying = YES;
  [self postStateNotification];
}
//预加载函数
- (void) startPreloadNextSong {
  if (self.playlist.count == 0) {
    return;
  }
  NSInteger nextIndex = self.currentindex + 1;
  if (nextIndex >= self.playlist.count) {
    nextIndex = 0;
  }
  SpotifySongsModels *nextModels = self.playlist[nextIndex];
  NSString *LocalPath = [self getLocalPathForSongID:nextModels.songID];
  if ([[NSFileManager defaultManager] fileExistsAtPath:LocalPath]) {
    return;
  }
  self.isPreloadingNextSong = YES;
  NSLog(@"开始预加载%@", nextModels.track);
  __weak typeof(self) weakSelf = self;
  [SpotifyArtistAPIModel fetchMusicURLWithID:nextModels.songID completion:^(NSString * _Nullable muiscURL, NSError * _Nullable error) {
    if (error || !muiscURL) {
      weakSelf.isPreloadingNextSong = NO;
      return;
    }
    nextModels.songUrl = muiscURL;
    [weakSelf downLoadSongInBackGround:nextModels];
  }];
}
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
- (void) TapLikedButton {
  SpotifySongsModels *currentSong = self.currentModel;
  BOOL isLiked = [[MusicDBModel shared] isSongLiked:currentSong.songID];
  if (isLiked) {
    [[MusicDBModel shared] unLikeSong:currentSong];
  } else {
    [[MusicDBModel shared] likeSong:currentSong];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"MusicLikeStatusDidChangeNitification" object:nil];
}

- (void) touchFileToCheckIn:(NSString *)path {
  //修改文件时间
  NSDictionary *attrs = @{NSFileModificationDate : [NSDate date]};
  //把修改后的时间还给文件
  [[NSFileManager defaultManager] setAttributes:attrs ofItemAtPath:path error:nil];
}

@end
