//
//  SearchModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import "SpotifySearchModel.h"
#import "SpotifyAPIManager.h"
#import "SpotifySongsModels.h"
#import "YYModel/YYModel.h"
@implementation SpotifySearchModel
+ (void) searchWithKeyWord :(NSString *) keyWord completion :(void(^)(NSArray<SpotifySongsModels *> * results, NSError * _Nullable error))completion {
  // 判空条件
  if (!keyWord|| keyWord.length == 0) {
    if (completion) {
      completion(@[], nil);
    }
  }

  NSDictionary *params = @{
    @"keywords" : keyWord,
    @"type" : @(1)
  };

  [[SpotifyAPIManager sharedManager] GET:@"/search" parameters:params completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      NSLog(@"[search model]请求失败 %@", error);
      if (completion) {
        completion(nil, error);
      }
      return;
    }
    NSDictionary *resultDict = responseObject[@"result"];
    NSArray *songArray = resultDict[@"songs"];
    if (!songArray || ![songArray isKindOfClass:[NSArray class]] || songArray.count == 0) {
      NSLog(@"[search models]没有搜到关于%@的结果", keyWord);
      if (completion) {
        return completion(@[], nil);
      }
      return;
    }
    NSArray<SpotifySongsModels *> *models = [NSArray yy_modelArrayWithClass:[SpotifySongsModels class] json:songArray];
    NSMutableArray<NSString *> *idArray = [NSMutableArray array];
    for (SpotifySongsModels *m in models) {
      if (m.songID) {
        [idArray addObject:m.songID];
      }
    }
    NSString *idsQuary = [idArray componentsJoinedByString:@","];// why
    [self fentchDetailsWithID:idsQuary completion:^(NSDictionary *idToPicMap, NSError *error) {
      for (SpotifySongsModels *m in models) {
        m.picURl = idToPicMap[m.songID];
      }
      dispatch_async(dispatch_get_main_queue(), ^{
        if (completion) {
          completion(models, nil);
        }
      });
    }];
  }];
}
+ (void) fentchDetailsWithID: (NSString *) ids completion: (void(^) (NSDictionary *idToPicMap, NSError *error))completion {
  [[SpotifyAPIManager sharedManager] GET:@"/song/detail" parameters:@{@"ids": ids} completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
    if (error || !responseObject[@"songs"]) {
      completion(@{}, nil);
      return;
    }
    NSMutableDictionary<NSString *, NSString *> *map = [NSMutableDictionary dictionary];
    NSArray *songs = responseObject[@"songs"];
    for (NSDictionary *dict in songs) {
      NSString *sID = [NSString stringWithFormat:@"%@", dict[@"id"]];
      NSString *pUrl = dict[@"al"][@"picUrl"];
      if (sID && pUrl) {
        map[sID] = pUrl;
      }
    }
    completion(map, nil);
  }];
}
@end
