//
//  AlbumCollectionViewCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/20.
//

#import <UIKit/UIKit.h>
#import "SpotifyModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlbumCollectionViewCell : UICollectionViewCell
- (void) configureWithAlbum: (SpotifyModels *) album;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
-(void) configureWithAlbum:(SpotifyModels *)album;
@end

NS_ASSUME_NONNULL_END
