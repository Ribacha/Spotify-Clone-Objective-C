//
//  SpotifyAPIManager.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import "SpotifyAPIManager.h"

// 你的本地服务器地址 (模拟器请使用 http://localhost:3000 或 http://127.0.0.1:3000)
// 如果是真机调试，需要填你电脑的局域网 IP，例如 http://192.168.1.5:3000
static NSString *const kBaseURL = @"http://localhost:3000";

@interface SpotifyAPIManager()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation SpotifyAPIManager

+ (instancetype)sharedManager {
    static SpotifyAPIManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
      _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
      // 网易云 API 返回的是 JSON
      _manager.responseSerializer = [AFJSONResponseSerializer serializer];
      // 允许接收的类型
      _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
      _manager.requestSerializer.timeoutInterval = 15.0;
    }
    return self;
}

- (void)GET:(NSString *)endpoint parameters:(NSDictionary *)params completion:(APICompletion)completion {
    NSLog(@"[API Request] GET %@ Params: %@", endpoint, params);
    [_manager GET:endpoint parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[API Error] %@", error);
        if (completion) {
            completion(nil, error);
        }
    }];
}

@end
