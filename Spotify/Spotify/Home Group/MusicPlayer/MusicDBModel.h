//
//  MusicDBModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/10.
//

#import <Foundation/Foundation.h>
#import "WCDB/WCDBObjc.h"
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface MusicDBModel : NSObject
@property (nonatomic, strong) WCTDatabase *dataBase;
@property (nonatomic, strong) NSString *tableName;
@property (nonatomic, strong) NSString *downLoadSongTableName;
+ (instancetype) shared;
- (BOOL) likeSong: (SpotifySongsModels *) song;
- (BOOL) unLikeSong: (SpotifySongsModels *) song;
- (BOOL) isSongLiked: (NSString *) songId;
- (NSArray<SpotifySongsModels *> *) getAllLikeSong;
- (BOOL) saveDownLoadSongs: (SpotifySongsModels *) songs;
- (BOOL) isDownLoadSongs: (NSString *) songId;
- (NSArray<SpotifySongsModels *> *) getAllDownLoadSongs;
@end

NS_ASSUME_NONNULL_END
