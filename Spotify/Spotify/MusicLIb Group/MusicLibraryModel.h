//
//  MusicLibraryModel.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LibraryActionType) {
  LibraryActionTypeLiked,
  LibraryActionTypeDownLoad,
  LibraryActionTypeLocal,
  LibraryActionTypeRecent
};
@interface LibraryMeunItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign) LibraryActionType type;

+(instancetype) itemWithTitle: (NSString *) title type: (LibraryActionType)type;
@end
@interface UserProfileModel : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) UIImage *avatorImage;
@end
NS_ASSUME_NONNULL_END
