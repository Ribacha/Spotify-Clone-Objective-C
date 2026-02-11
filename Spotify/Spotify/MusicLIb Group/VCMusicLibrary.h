//
//  VCMusicLibrary.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import <UIKit/UIKit.h>
#import "MusicLibraryModel.h"
#import "LibraryMenuCell.h"
#import "LibraryRootView.h"
#import "LibraryHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface VCMusicLibrary : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, LibraryHeaderViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) LibraryRootView *rootView;
@property (nonatomic, strong) UserProfileModel *currentUser;
@property (nonatomic, strong) NSArray<LibraryMeunItem *> *menuItem;


@end

NS_ASSUME_NONNULL_END
