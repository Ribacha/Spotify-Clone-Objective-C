//
//  SpotifySongsModels.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/1.
//

#import "SpotifySongsModels.h"
#import "YYModel/YYModel.h"

@implementation SpotifySongsModels

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"track" : @"name",
        @"songID" : @"id",
        @"picURl" : @[@"al.picUrl", @"album.picUrl",@"album.artist.img1v1Url",@"artists[0].img1v1Url"],
        @"artist" : @"ar[0].name"
    };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSArray *artistArray = dic[@"ar"];
  if (!artistArray) {
    artistArray = dic[@"artists"];
  }
    if ([artistArray isKindOfClass:[NSArray class]] && artistArray.count > 0) {
        self.artist = artistArray.firstObject[@"name"];
    } else {
        self.artist = @"Unknown Artist";
    }
    if (dic[@"id"]) {
        self.songID = [NSString stringWithFormat:@"%@", dic[@"id"]];
    }
    return YES;
}

- (NSString *)description {
    return [self yy_modelDescription];
}

@end
