//
//  AlbumSongsTableViewCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/1/11.
//

#import <UIKit/UIKit.h>
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlbumSongsTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *songsLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *numberLabel;
- (void) configureModel:(SpotifySongsModels *) models index: (NSInteger) index;
@end

NS_ASSUME_NONNULL_END
