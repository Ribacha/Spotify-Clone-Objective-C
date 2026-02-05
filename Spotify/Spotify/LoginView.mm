//
//  LoginView.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/13.
//

#import "LoginView.h"
#import "Masonry/Masonry.h"
@interface LoginView ()
@property (nonatomic, strong, readwrite) UITextField* usernameField;
@property (nonatomic, strong, readwrite) UITextField* passwordField;
@property (nonatomic, strong, readwrite) UIButton* ButtonLogin;
@end
@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    self.backgroundColor = [UIColor blackColor];
    self.usernameField = [[UITextField alloc] init];
    self.usernameField.borderStyle = UITextBorderStyleNone;
    self.usernameField.backgroundColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    self.usernameField.textColor = [UIColor whiteColor];
    self.usernameField.layer.cornerRadius = 20;
    self.usernameField.clipsToBounds = YES;
    self.usernameField.font = [UIFont systemFontOfSize:25];
    self.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  请输入用户名 (a)"
                                                                                     attributes:@{ NSForegroundColorAttributeName: [UIColor lightGrayColor] }];
    [self addSubview:self.usernameField];
    [self.usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.mas_centerX);
      make.top.equalTo(self.mas_top).offset(300);
      make.width.equalTo(@300);
      make.height.equalTo(@80);
    }];
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.borderStyle = UITextBorderStyleNone;
    self.passwordField.backgroundColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    self.passwordField.textColor = [UIColor whiteColor];
    self.passwordField.layer.cornerRadius = 20;
    self.passwordField.clipsToBounds = YES;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.font = [UIFont systemFontOfSize:25];
    self.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  请输入密码 (a)"
                                                                                       attributes:@{ NSForegroundColorAttributeName: [UIColor lightGrayColor] }];
    [self addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.mas_centerX);
      make.top.equalTo(self.mas_top).offset(420);
      make.width.equalTo(@300);
      make.height.equalTo(@80);
    }];
    self.ButtonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.ButtonLogin setTitle:@"登录" forState:UIControlStateNormal];
    self.ButtonLogin.backgroundColor = [UIColor colorWithRed:30/255.0 green:215/255.0 blue:96/255.0 alpha:1.0];
    [self.ButtonLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ButtonLogin.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    self.ButtonLogin.layer.borderWidth = 0;
    [self addSubview:self.ButtonLogin];
    [self.ButtonLogin mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.passwordField.mas_bottom).offset(15);
      make.width.equalTo(self.passwordField.mas_width).multipliedBy(0.5);
      make.height.equalTo(self.passwordField.mas_height).multipliedBy(0.6);
      make.centerX.equalTo(self.mas_centerX);
    }];
  }
  return self;
}

@end
