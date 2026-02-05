//
//  VCLogin.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class VCLogin;
@protocol LoginViewControllerDelegate <NSObject>
- (void)loginViewControllerDidSucceed:(VCLogin *)controller;
@end
@interface VCLogin : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
