//
//  SpotifyArtistAPIModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/1.
//

#import <Foundation/Foundation.h>
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpotifyArtistAPIModel : NSObject
+ (void) fetchAlbumsTracksWithID: (NSString *) albumID completion: (void (^) (NSArray<SpotifySongsModels *> *models, NSError *error)) completion;
+ (void) fetchMusicURLWithID: (NSString *) songID completion:(void(^)(NSString *_Nullable muiscURL, NSError *_Nullable error) )completion;
@end

NS_ASSUME_NONNULL_END
