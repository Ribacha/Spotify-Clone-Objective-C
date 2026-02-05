//
//  SpotifyArtistAPIModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/1.
//

#import "SpotifyArtistAPIModel.h"
#import "SpotifySongsModels.h"
#import "YYModel/YYModel.h"
#import "SpotifyAPIManager.h"

@implementation SpotifyArtistAPIModel

+ (void)fetchAlbumsTracksWithID:(NSString *)albumID completion:(void (^)(NSArray<SpotifySongsModels *> *models, NSError *error))completion {

    if (!albumID) {
        if (completion) completion(nil, [NSError errorWithDomain:@"App" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"ID为空"}]);
        return;
    }
    NSDictionary *params = @{ @"id": albumID };

    [[SpotifyAPIManager sharedManager] GET:@"/playlist/detail" parameters:params completion:^(id  _Nullable responseObject, NSError * _Nullable error) {

        if (error) {
            NSLog(@"[API Error] 获取歌单详情失败: %@", error);
            if (completion) completion(nil, error);
            return;
        }
        NSArray *songsJSON = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *playlistDict = responseObject[@"playlist"];
            if ([playlistDict isKindOfClass:[NSDictionary class]]) {
                songsJSON = playlistDict[@"tracks"];
            }
        }
        // 容错处理
        if (!songsJSON || ![songsJSON isKindOfClass:[NSArray class]]) {
            NSLog(@"[Data Error] 无法解析 tracks 数据, 原始数据结构可能不匹配");
            if (completion) completion(@[], nil);
            return;
        }
        // 转换模型
        NSArray *tracks = [NSArray yy_modelArrayWithClass:[SpotifySongsModels class] json:songsJSON];

        if (completion) {
            completion(tracks, nil);
        }
    }];
}
+ (void) fetchMusicURLWithID: (NSString *) songID completion:(void(^)(NSString *_Nullable muiscURL, NSError *_Nullable error) )completion {
  if (!songID) {
    return;
  }
  NSDictionary *params = @{
    @"id" : songID,
    @"level" : @"standard"
  };
  [[SpotifyAPIManager sharedManager] GET:@"/song/url/v1" parameters:params completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
    if(error) {
      if (completion) {
        completion(nil, error);
        return;
      }
    }
    NSArray *dataArray = responseObject[@"data"];
    if ([dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
      NSDictionary *songInfo = dataArray.firstObject;
      NSString *url = songInfo[@"url"];
      if (url && ![url isKindOfClass:[NSNull class]] && url.length > 0) {
        if (completion) {
          completion(url, nil);
        }
      } else {
        NSString *fallbackURL = [NSString stringWithFormat:@"https://music.163.com/song/media/outer/url?id=%@.mp3", songID];
        if (completion) {
          completion(fallbackURL, nil);
        }
      }
    } else {
      if (completion) {
        completion(nil, [NSError errorWithDomain:@"ParseError" code:-1 userInfo:nil]);
      }
    }

  }];
}
@end
