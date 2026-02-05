//
//  VCSearchPage.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import "VCSearchPage.h"
#import "SearchResultCell.h"
#import "SpotifySearchModel.h"
#import "VCMusicPlayer.h"
#import "MusicPlayerManager.h"
#import "SpotifySongsModels.h"
@interface VCSearchPage ()

@end

@implementation VCSearchPage

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  [self setupTableView];
  [self setupSearchController];
}
- (void) setupTableView {
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  self.tableView.backgroundColor = [UIColor blackColor];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.rowHeight = 70;
  [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:@"SearchResultCell"];
  [self.view addSubview:self.tableView];
}
- (void) setupSearchController {
  self.searchController =  [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.obscuresBackgroundDuringPresentation = NO;
  self.searchController.searchBar.placeholder = @"Artist, Songs, PodCasts";
  self.searchController.searchBar.barStyle = UIBarStyleBlack;
  self.searchController.searchBar.tintColor = [UIColor whiteColor];
  self.navigationItem.searchController = self.searchController;
  self.definesPresentationContext = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.results.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
  cell.models = self.results[indexPath.row];
  return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  SpotifySongsModels *selectedModel = self.results[indexPath.row];
  [[MusicPlayerManager shared] fetchSongModels:self.results];
  [MusicPlayerManager shared].currentindex = indexPath.row;
  [[MusicPlayerManager shared] playMusic:selectedModel];
  VCMusicPlayer *player = [[VCMusicPlayer alloc] init];
  [self presentViewController:player animated:YES completion:nil];
}
- (void) updateSearchResultsForSearchController:(UISearchController *)searchController {
  NSString *input = searchController.searchBar.text;
  if (!input || input.length == 0) {
    self.results = @[];
    [self.tableView reloadData];
    return;
  }
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performSearch) object:nil];
  [self performSelector:@selector(performSearch) withObject:nil afterDelay:0.5];
}
- (void) performSearch {
  NSString *keyWord = self.searchController.searchBar.text;
  if (keyWord == 0) {
    return;
  }
  __weak typeof(self) weakSelf = self;
  [SpotifySearchModel searchWithKeyWord:keyWord completion:^(NSArray<SpotifySongsModels *> * _Nonnull results, NSError * _Nullable error) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (error) {
        return;
      }
      weakSelf.results = results;
      [weakSelf.tableView reloadData];
    });
  }];
}
@end
