//
//  MusicLibraryModel.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/17.
//

#import "MusicLibraryModel.h"

@implementation LibraryMeunItem
/// 工厂方法
+(instancetype) itemWithTitle: (NSString *) title type: (LibraryActionType)type {
  LibraryMeunItem *item = [[LibraryMeunItem alloc] init];
  item.title = title;
  item.type = type;
  return item;
}
@end

@implementation UserProfileModel
@end
