//
//  VCHomePage.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/16.
//

#import <UIKit/UIKit.h>
#import "SpotifyModels.h"
#import "SpotifyAPIManager.h"
#import "AlbumTableViewCell.h"
#import "AlbumCollectionViewCell.h"
#import "HomePageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VCHomePage : UIViewController<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<HomePageModel *> *sections;
@property (nonatomic, strong) NSArray<SpotifyModels *> *albums;
@property (nonatomic, strong) NSArray<SpotifyModels*> *girdData;
@property (nonatomic, strong) NSArray<SpotifyModels*> *allModels;
@end

NS_ASSUME_NONNULL_END
