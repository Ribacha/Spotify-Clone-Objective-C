//
//  LoginView.h
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LoginView : UIView

@property (nonatomic, strong, readonly) UITextField* usernameField;
@property (nonatomic, strong, readonly) UITextField* passwordField;
@property (nonatomic, strong, readonly) UIButton* ButtonLogin;

@end

NS_ASSUME_NONNULL_END
