//
//  VCHomePage.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import "VCHomePage.h"
#import "AlbumTableViewCell.h"
#import "HomeGirdTableViewCell.h"
#import "SpotifyRecommendAPIModel.h"
#import "MusicCardCollectionView.h"
#import "Masonry/Masonry.h"
#import "VCAlbumDetail.h"
#import "MusicPlayerManager.h"
@interface VCHomePage ()

@end

@implementation VCHomePage

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  self.girdData = [NSArray array];
  [self setupTableView];
  [self fetchData];

}
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void) setupTableView {
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerClass:[AlbumTableViewCell class] forCellReuseIdentifier:@"SectionCell"];
  [self.tableView registerClass:[HomeGirdTableViewCell class] forCellReuseIdentifier:@"HomeGirdTableViewCell"];
  self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
  [self.view addSubview:self.tableView];
}
- (void) fetchData {
    __weak typeof(self) weakSelf = self;

    // 调用我们刚才改好的 Netease 接口
    [SpotifyRecommendAPIModel fetchRecommedtions:^(NSArray<SpotifyModels *> * _Nonnull models, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"数据获取失败: %@", error);
            // 这里可以加一个提示框 HUD
            return;
        }

        // 确保有数据
        if (models.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 1. 保存所有数据
                weakSelf.allModels = models;

                // 2. 分配给顶部 GridView (比如取前 6 个，或者最后 6 个)
                // 网易云通常返回 30 个，我们取前 6 个给顶部网格
                if (models.count >= 6) {
                    weakSelf.girdData = [models subarrayWithRange:NSMakeRange(0, 6)];
                } else {
                    weakSelf.girdData = models; // 数据不够就全给
                }

                // 3. 刷新 UI
                [weakSelf.tableView reloadData];
            });
        }
    }];
}

#pragma mark - CellSet

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 0. 顶部 GridView Section 不变
    if (indexPath.section == 0) {
        HomeGirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGirdTableViewCell" forIndexPath:indexPath];
        cell.girdModels = self.girdData;
        __weak typeof(self) weakSelf = self;
        cell.pushBlock = ^(SpotifyModels * _Nonnull clickedModel) {
            // 这里 ID 已经是网易云的 ID 了
            NSLog(@"点击 Grid: %@ - ID: %@", clickedModel.name, clickedModel.id);
            VCAlbumDetail *detailVC = [[VCAlbumDetail alloc] init];
          detailVC.albumModel = clickedModel;
          detailVC.IDStr = clickedModel.id;
          detailVC.hidesBottomBarWhenPushed = YES;
          [weakSelf.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }

    // 1. 处理下面的普通 Section
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionCell" forIndexPath:indexPath];
    NSArray<SpotifyModels *> *source = self.allModels;

    // 如果没有数据，直接返回空 cell 防止崩溃
    if (!source || source.count == 0) {
        return cell;
    }

    // 2. 使用刚才写的安全切片方法来伪造由于“分类”的数据
    // 假设 Grid 用掉了前 6 个 (index 0-5)
    // 我们从 index 6 开始往后切分

    switch (indexPath.section) {
        case 1: {
            // 取 index 6 开始的 6 个
            NSArray *data = [self safeSubarrayFrom:source range:NSMakeRange(6, 6)];
            [cell configureWithTitle:@"为你推荐" albums:data];
            break;
        }
        case 2: {
            // 取 index 12 开始的 6 个
            NSArray *data = [self safeSubarrayFrom:source range:NSMakeRange(12, 6)];
            [cell configureWithTitle:@"华语精选" albums:data]; // 标题可以改得像网易云一点
            break;
        }
        case 3: {
            // 取 index 18 开始的 6 个
            NSArray *data = [self safeSubarrayFrom:source range:NSMakeRange(18, 6)];
            [cell configureWithTitle:@"流行趋势" albums:data];
            break;
        }
        case 4: {
            // 取 index 24 开始的 6 个
            NSArray *data = [self safeSubarrayFrom:source range:NSMakeRange(24, 6)];
            [cell configureWithTitle:@"编辑推荐" albums:data];
            break;
        }
        default:
            break;
    }
  __weak typeof(self) weakSelf = self;
  cell.pushBlock = ^(SpotifyModels * _Nonnull clickedModel) {
      // 这里 ID 已经是网易云的 ID 了
      NSLog(@"点击 Grid: %@ - ID: %@", clickedModel.name, clickedModel.id);
      VCAlbumDetail *detailVC = [[VCAlbumDetail alloc] init];
      detailVC.albumModel = clickedModel;
      detailVC.IDStr = clickedModel.id;
      detailVC.hidesBottomBarWhenPushed = YES;
      [weakSelf.navigationController pushViewController:detailVC animated:YES];
  };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return 200;
  } else {
    return 230;
  }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (section != 0) {
    return nil;
  }
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 70)];
  header.backgroundColor = [UIColor clearColor];
  UILabel *label = [[UILabel alloc] init];
  label.font = [UIFont systemFontOfSize:38 weight:UIFontWeightBold];
  label.textColor = [UIColor whiteColor];
  label.text = @"你好啊!";
  [header addSubview:label];
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(header).offset(16);
    make.centerY.equalTo(header).offset(-20);
  }];
  return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return section == 0 ? 70 : 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0.01;
}
// 安全获取子数组，防止越界崩溃
- (NSArray *)safeSubarrayFrom:(NSArray *)source range:(NSRange)range {
    if (range.location >= source.count) {
        return @[];
    }
    NSUInteger length = MIN(range.length, source.count - range.location);
    return [source subarrayWithRange:NSMakeRange(range.location, length)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
