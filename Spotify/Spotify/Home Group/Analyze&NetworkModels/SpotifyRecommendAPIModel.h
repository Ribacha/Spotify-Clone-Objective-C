//
//  SpotifyRecommendAPIModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/23.
//

#import <Foundation/Foundation.h>
#import "SpotifyModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpotifyRecommendAPIModel : NSObject
+ (void) fetchRecommedtions: (void (^) (NSArray<SpotifyModels *> *models, NSError *error)) completion;
@end

NS_ASSUME_NONNULL_END
