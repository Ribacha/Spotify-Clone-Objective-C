//
//  HomeGirdTableViewCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/27.
//

#import <UIKit/UIKit.h>
#import "SpotifyModels.h"
#import "MusicCardCollectionView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(SpotifyModels *clickedModel);
@interface HomeGirdTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray<SpotifyModels *> *girdModels;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ClickBlock pushBlock;

@end

NS_ASSUME_NONNULL_END
