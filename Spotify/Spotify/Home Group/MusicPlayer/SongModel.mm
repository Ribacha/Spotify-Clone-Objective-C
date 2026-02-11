//
//  SongModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/10.
//

#import "SongModel.h"
#import "WCDB/WCDBObjc.h"
@implementation SongModel
WCDB_IMPLEMENTATION(SongModel)

WCDB_SYNTHESIZE(songId)
WCDB_SYNTHESIZE(time)
WCDB_SYNTHESIZE(track)
WCDB_SYNTHESIZE(artist)
WCDB_SYNTHESIZE(coverUrl)

WCDB_PRIMARY(songId)
@end
