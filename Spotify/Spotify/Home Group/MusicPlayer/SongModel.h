//
//  SongModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/10.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDBObjc.h>
NS_ASSUME_NONNULL_BEGIN

@interface SongModel : NSObject<WCTTableCoding>
@property (nonatomic, assign) NSInteger songId;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *track;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, assign) NSInteger time;

WCDB_PROPERTY(songId);
WCDB_PROPERTY(coverUrl);
WCDB_PROPERTY(track);
WCDB_PROPERTY(artist);
WCDB_PROPERTY(time);
@end

NS_ASSUME_NONNULL_END
