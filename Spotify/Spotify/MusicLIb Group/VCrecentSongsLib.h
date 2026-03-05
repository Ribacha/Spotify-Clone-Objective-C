//
//  VCrecentSongsLib.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/3/4.
//

#import <UIKit/UIKit.h>
#import "Masonry/Masonry.h"
#import "SpotifyArtistAPIModel.h"
#import "AlbumDetailView.h"
#import "AlbumSongsTableViewCell.h"
#import "VCMusicPlayer.h"
#import "MusicPlayerManager.h"
#import "MusicDBModel.h"
#import "SpotifySongsModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface VCrecentSongsLib : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray<SpotifySongsModels *> *allmodels;
@property (nonatomic, strong) AlbumDetailView *mainView;
@end

NS_ASSUME_NONNULL_END
