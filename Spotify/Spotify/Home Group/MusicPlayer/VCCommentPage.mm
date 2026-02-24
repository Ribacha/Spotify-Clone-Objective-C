//
//  VCCommentPage.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/2/23.
//

#import "VCCommentPage.h"
#import "CommentPageTableViewCell.h"
#import "Masonry/Masonry.h"
#import "CommentPageModel.h"
@interface VCCommentPage ()

@end

@implementation VCCommentPage

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  self.dataSource = [NSMutableArray array];
  self.offset = 0;
  self.limit = 20;
  self.hasMore = YES;
  self.isLoading = NO;
  [self setupUI];
  [self LoadData];
}
- (void) setupUI {
  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
  self.tableView.backgroundColor = [UIColor clearColor];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.estimatedRowHeight = 100;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  [self.tableView registerClass:[CommentPageTableViewCell class] forCellReuseIdentifier:@"CommentPageTableViewCell"];
  [self.view addSubview:self.tableView];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
}
- (void) LoadData {
  if (!self.songID) {
    return;
  }
  if (!self.hasMore || self.isLoading) {
    return;
  }
  self.isLoading = YES;
  __weak typeof(self) WeakSelf = self;
  [CommentPageModel fentchCommentFromSongID:self.songID offset:self.offset limit:self.limit completion:^(NSArray<CommentPageModel *> * _Nonnull comments, BOOL hasMore, NSError * _Nonnull error) {
    WeakSelf.isLoading = NO;
    if (!error && comments) {
      WeakSelf.offset += comments.count;
      WeakSelf.hasMore = hasMore;
      [WeakSelf.dataSource addObjectsFromArray:comments];
      [WeakSelf.tableView reloadData];
    } else {
      NSLog(@"获取评论失败");
    }
  }];
}

#pragma mark - UITableViewDataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CommentPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentPageTableViewCell" forIndexPath:indexPath];
  CommentPageModel *model = self.dataSource[indexPath.row];
  [cell configureModelWithComment:model];
  __weak typeof(self) WeakSelf = self;
  __weak typeof(cell) WeakCell = cell;
  cell.expendButtonTappedBlock = ^{
    model.isExpand = !model.isExpand;
    [WeakCell configureModelWithComment:model];
    [WeakSelf.tableView beginUpdates];
    [WeakSelf.tableView endUpdates];
  };
  return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offsetY = scrollView.contentOffset.y;
  CGFloat contentHeight = scrollView.contentSize.height;
  CGFloat height = scrollView.bounds.size.height;
  if (offsetY > contentHeight - height - 150) {
    [self LoadData];
  }
}
@end
