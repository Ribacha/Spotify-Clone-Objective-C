//
//  AlbumTableViewCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/19.
//

#import <UIKit/UIKit.h>
#import "SpotifyModels.h"
#import "AlbumCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(SpotifyModels *clickedModel);
@interface AlbumTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) NSArray<SpotifyModels *> *albums;
@property (nonatomic, strong) UILabel *headerLabel;
- (void)configureWithTitle:(NSString *)title albums:(NSArray<SpotifyModels *> *)albums;
@property (nonatomic, strong) ClickBlock pushBlock;
@end

NS_ASSUME_NONNULL_END 
