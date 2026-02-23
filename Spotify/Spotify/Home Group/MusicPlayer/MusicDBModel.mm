//
//  MusicDBModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/10.
//

#import "MusicDBModel.h"
#import "WCDB/WCDBObjc.h"
#import "SpotifySongsModels.h"
@implementation MusicDBModel
+ (instancetype) shared {
  static MusicDBModel *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}
- (instancetype)init 
{
  self = [super init];
  if (self) {
    self.tableName = @"favouriteSongsTable";
    self.downLoadSongTableName = @"downLoadSongsTable";
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"SpotifyData.db"];
    self.dataBase = [[WCTDatabase alloc] initWithPath:dbPath];
    if ([self.dataBase canOpen]) {
      BOOL result = [self.dataBase createTable:self.tableName withClass:SpotifySongsModels.class];
      BOOL result2 = [self.dataBase createTable:self.downLoadSongTableName withClass:SpotifySongsModels.class];
      if(result && result2) {
        NSLog(@"数据库打开成功，建表成功");
        NSLog(@"数据库路径: %@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
      } else {
        NSLog(@"建表失败");
      }
    }
    return self;
  }
  return self;
}

#pragma - mark - 点赞歌曲的增，删，查， 判断逻辑
- (BOOL) likeSong: (SpotifySongsModels *) song {
  if (!song) {
    return NO;
  }
  return [self.dataBase insertOrReplaceObject:song intoTable:self.tableName];
}
- (BOOL) unLikeSong: (SpotifySongsModels *) song {
  return [self.dataBase deleteFromTable:self.tableName where:SpotifySongsModels.songID == song.songID];
}
- (BOOL) isSongLiked: (NSString *) songId {
  SpotifySongsModels *obj = [self.dataBase getObjectOfClass:SpotifySongsModels.class fromTable:self.tableName where:SpotifySongsModels.songID == songId];
  return (obj != nil);
}
- (NSArray<SpotifySongsModels *> *) getAllLikeSong {
  return [self.dataBase getObjectsOfClass:SpotifySongsModels.class fromTable:self.tableName];
}
#pragma - mark - 下载歌曲的增，查， 判断逻辑
- (BOOL) saveDownLoadSongs: (SpotifySongsModels *) songs {
  if (!songs) {
    return NO;
  }
  return [self.dataBase insertOrReplaceObject:songs intoTable:self.downLoadSongTableName];

}
- (BOOL) isDownLoadSongs: (NSString *) songId {
  SpotifySongsModels *obj = [self.dataBase getObjectOfClass:SpotifySongsModels.class fromTable:self.downLoadSongTableName where:SpotifySongsModels.songID == songId];
  return (obj != nil);
}
- (NSArray<SpotifySongsModels *> *) getAllDownLoadSongs {
  return [self.dataBase getObjectsOfClass:SpotifySongsModels.class fromTable:self.downLoadSongTableName];
}
@end
