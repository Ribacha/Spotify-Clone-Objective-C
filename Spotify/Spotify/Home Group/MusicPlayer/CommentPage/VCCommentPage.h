//
//  VCCommentPage.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import <UIKit/UIKit.h>
#import "CommentPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VCCommentPage : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSString *songID;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CommentPageModel *> *dataSource;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, assign) BOOL isLoading;
@end

NS_ASSUME_NONNULL_END
