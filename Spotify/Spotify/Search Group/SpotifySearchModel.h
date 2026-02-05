//
//  SearchModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import <Foundation/Foundation.h>
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpotifySearchModel : NSObject
+ (void) searchWithKeyWord :(NSString *) keyWord completion :(void(^)(NSArray<SpotifySongsModels *> * results, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
