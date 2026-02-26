//
//  CommentPageModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CommentPageRepliedModel : NSObject
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *timeStr;
@end

@interface CommentPageModel : NSObject
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *commentID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, strong) NSArray<CommentPageRepliedModel *> *beReplied;
@property (nonatomic, assign) BOOL isExpand;
@property (nonatomic, assign) BOOL needsExpandButton;
+ (void) fentchCommentFromSongID:(NSString *)songID offset:(NSInteger)offset limit:(NSInteger) limit completion:(void(^)(NSArray<CommentPageModel *> *comments, BOOL hasMore, NSError *error )) completion;
@end

NS_ASSUME_NONNULL_END
