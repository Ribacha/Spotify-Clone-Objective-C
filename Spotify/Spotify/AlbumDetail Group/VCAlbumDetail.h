//
//  VCAlbumDetail.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/2.
//

#import <UIKit/UIKit.h>
#import "SpotifyModels.h"
#import "SpotifySongsModels.h"
#import "AlbumDetailView.h"
NS_ASSUME_NONNULL_BEGIN

@interface VCAlbumDetail : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) SpotifyModels * albumModel;
@property (nonatomic, strong) NSString *IDStr;
@property (nonatomic, strong) NSArray <SpotifySongsModels *> * allmodels;
@property (nonatomic, strong) AlbumDetailView *mainView;
@end

NS_ASSUME_NONNULL_END
