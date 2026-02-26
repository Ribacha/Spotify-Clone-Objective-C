//
//  CommentPageModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import "CommentPageModel.h"
#import "SpotifyAPIManager.h"
@implementation CommentPageRepliedModel
@end
@implementation CommentPageModel
+ (void) fentchCommentFromSongID:(NSString *)songID offset:(NSInteger)offset limit:(NSInteger) limit completion:(void(^)(NSArray<CommentPageModel *> *comments, BOOL hasMore, NSError *error )) completion {
  NSString *endPoint = @"/comment/music";
  NSDictionary *params = @{
    @"id" :songID,
    @"limit" :@(limit),
    @"offset" :@(offset)
  };
  [[SpotifyAPIManager sharedManager] GET:endPoint parameters:params completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
    if (error) {
      completion(nil, NO, error);
      return;
    }
    BOOL hasMore = [responseObject[@"more"] boolValue];
    NSArray *commentsData = responseObject[@"comments"];
    NSMutableArray *modelsArray = [NSMutableArray array];
    for (NSDictionary *dict in commentsData) {
      CommentPageModel *model = [[CommentPageModel alloc] init];
      model.commentID = [NSString stringWithFormat:@"%@", dict[@"commentId"]];
      model.content = [dict[@"content"] isKindOfClass:[NSNull class]] ? @"" : dict[@"content"];
      model.userName = [dict[@"user"][@"nickname"] isKindOfClass:[NSNull class]] ? @"" : dict[@"user"][@"nickname"];
      model.avatarUrl =[dict[@"user"][@"avatarUrl"] isKindOfClass:[NSNull class]] ? @"" : dict[@"user"][@"avatarUrl"];
      model.timeStr = [dict[@"timeStr"] isKindOfClass:[NSNull class]] ? @"" : dict[@"timeStr"];
      NSArray *rCommentsArray = dict[@"beReplied"];
      NSMutableArray *repliesArray = [NSMutableArray array];
      for (NSDictionary *replyDict in rCommentsArray) {
        CommentPageRepliedModel *rModel = [[CommentPageRepliedModel alloc] init];
        rModel.content = [replyDict[@"content"] isKindOfClass:[NSNull class]] ? @"" : replyDict[@"content"];
        rModel.avatarUrl = [replyDict[@"user"][@"avatarUrl"] isKindOfClass:[NSNull class]] ? @"" : replyDict[@"user"][@"avatarUrl"];
        rModel.userName = [replyDict[@"user"][@"nickname"] isKindOfClass:[NSNull class]] ? @"" : replyDict[@"user"][@"nickname"];
        rModel.timeStr = [replyDict[@"timeStr"] isKindOfClass:[NSNull class]] ? @"" : replyDict[@"timeStr"];
        [repliesArray addObject:rModel];
      }
      model.beReplied = repliesArray;
      model.isExpand = NO;
      [model caculateNeedsExpandButton];
      [modelsArray addObject:model];
    }
    if (completion) {
      completion(modelsArray, hasMore, nil);
    }
  }];
}
- (void) caculateNeedsExpandButton {
  if (!self.content || self.content.length == 0) {
    self.needsExpandButton = NO;
    return;
  }
  CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width - 30;
  NSTextStorage *storage = [[NSTextStorage alloc] initWithString:self.content attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
  NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
  NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX)];
  [layoutManager addTextContainer:container];
  [storage addLayoutManager:layoutManager];
  NSInteger glyphCount = [layoutManager numberOfGlyphs];
  __block NSInteger lines = 0;
  [layoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, glyphCount) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
    lines++;
    if (lines > 3) {
      *stop = YES;
    }
  }];
  self.needsExpandButton = lines > 3;

}
@end
