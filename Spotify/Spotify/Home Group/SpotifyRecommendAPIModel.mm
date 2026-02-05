//
//  SpotifyRecommendAPIModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/23.
//

#import "SpotifyRecommendAPIModel.h"
#import "SpotifyModels.h"
#import "SpotifyAPIManager.h"
#import "YYModel/YYModel.h"

@implementation SpotifyRecommendAPIModel

+ (void)fetchRecommedtions:(void (^)(NSArray<SpotifyModels *> *models, NSError *error))completion {
    NSDictionary *params = @{ @"limit": @30 };
    [[SpotifyAPIManager sharedManager] GET:@"/personalized" parameters:params completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (completion) completion(nil, error);
            return;
        }
        NSArray *resultJSON = responseObject[@"result"];
        NSArray *albums = [NSArray yy_modelArrayWithClass:[SpotifyModels class] json:resultJSON];
        if (completion) {
            completion(albums, nil);
        }
    }];
}

@end
