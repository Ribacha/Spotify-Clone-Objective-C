//
//  SearchResultCell.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/1/30.
//

#import <UIKit/UIKit.h>
#import "SpotifySongsModels.h"
NS_ASSUME_NONNULL_BEGIN

@interface SearchResultCell : UITableViewCell
@property (nonatomic, strong) SpotifySongsModels *models;
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@end

NS_ASSUME_NONNULL_END
