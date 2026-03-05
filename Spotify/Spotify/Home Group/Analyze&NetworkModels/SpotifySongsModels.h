//
//  SpotifySongsModels.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/1.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDBObjc.h>
NS_ASSUME_NONNULL_BEGIN

@interface SpotifySongsModels : NSObject<WCTTableCoding>

@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *track;
@property (nonatomic, strong) NSString *songID;
@property (nonatomic, strong) NSString *picURl;
@property (nonatomic, strong) NSString *songUrl;
@property (nonatomic, assign) NSTimeInterval lastPlayTime;
@property (nonatomic, assign) NSString *desc;
WCDB_PROPERTY(songID);
WCDB_PROPERTY(picURl);
WCDB_PROPERTY(track);
WCDB_PROPERTY(artist);
WCDB_PROPERTY(songUrl);
WCDB_PROPERTY(lastPlayTime);
WCDB_PROPERTY(desc);
@end

NS_ASSUME_NONNULL_END
