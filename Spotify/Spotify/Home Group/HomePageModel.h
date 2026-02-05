//
//  HomePageModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import <Foundation/Foundation.h>
#import "SpotifyModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomePageModel : NSObject
@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, strong) NSArray<SpotifyModels *> *albums;
@end

NS_ASSUME_NONNULL_END
