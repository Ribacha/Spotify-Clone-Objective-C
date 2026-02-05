//
//  MusicCardCollectionView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/24.
//

#import <UIKit/UIKit.h>
#import "SpotifyModels.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^ClickBlock)(SpotifyModels *clickedModel);
@interface MusicCardCollectionView : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray<SpotifyModels *> *girdModels;
- (void) configureWithModel: (SpotifyModels *)model;
@end

NS_ASSUME_NONNULL_END
