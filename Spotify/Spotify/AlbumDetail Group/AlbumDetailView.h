//
//  AlbumDetailView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2026/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlbumDetailView : UIView
@property (nonatomic, strong) UIImageView *RecommendImage;
@property (nonatomic, strong) UILabel *RecommendLabel;
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *expandButton;
- (void) updateWithTitle: (NSString*) title imageURL: (NSURL*) url descText: (NSString*) descText;
@end

NS_ASSUME_NONNULL_END
