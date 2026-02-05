//
//  SpotifyAPIManager.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

// 定义通用的请求回调
typedef void (^APICompletion)(id _Nullable responseObject, NSError * _Nullable error);

@interface SpotifyAPIManager : NSObject

+ (instancetype)sharedManager;

// 通用的 GET 请求方法
- (void)GET:(NSString *)endpoint parameters:(nullable NSDictionary *)params completion:(APICompletion)completion;

@end

NS_ASSUME_NONNULL_END
