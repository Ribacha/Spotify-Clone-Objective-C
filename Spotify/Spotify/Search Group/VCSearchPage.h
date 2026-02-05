//
//  VCSearchPage.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import <UIKit/UIKit.h>
#import "SpotifySearchModel.h"
#import "SearchResultCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface VCSearchPage : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray<SpotifySongsModels *> *results;

@end

NS_ASSUME_NONNULL_END
