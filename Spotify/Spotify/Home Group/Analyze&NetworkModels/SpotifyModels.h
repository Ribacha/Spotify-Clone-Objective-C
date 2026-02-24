//
//  SpotifyModels.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/18.
//

#import <Foundation/Foundation.h>
#import "YYModel/YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpotifyImage : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@end

@interface SpotifySimpleAlbum : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<SpotifyImage *> *images;
@end

@interface SpotifyModels : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) SpotifySimpleAlbum *album;
@property (nonatomic, strong) NSArray<SpotifyImage *> *images;
@end
NS_ASSUME_NONNULL_END
