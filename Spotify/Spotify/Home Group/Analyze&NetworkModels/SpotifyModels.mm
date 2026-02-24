//
//  SpotifyModels.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/18.
//

#import "SpotifyModels.h"

@implementation SpotifyImage
@end

@implementation SpotifySimpleAlbum
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"images" : [SpotifyImage class]};
}
@end
@implementation SpotifyModels
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"images" : [SpotifyImage class]};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"id" : @"id",
        @"name" : @"name",
        @"imageUrl" : @[@"picUrl", @"coverImgUrl", @"images[0].url"],
        @"artistName" : @"creator.nickname" 
    };
}
@end
