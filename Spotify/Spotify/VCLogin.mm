//
//  VCLogin.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/13.
//

#import "VCLogin.h"
#import "LoginView.h"
@interface VCLogin ()
@property (nonatomic, strong) LoginView* LoginView;
@property (nonatomic) NSMutableDictionary* dict;
@property (nonatomic, strong) NSString* KeyStr;
@end

@implementation VCLogin

- (void) loadView {
  self.LoginView = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.view = self.LoginView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  self.dict =[@ {@"a": @"a"} mutableCopy];
  [self.LoginView.ButtonLogin addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
  self.LoginView.usernameField.delegate = self;
  self.LoginView.passwordField.delegate = self;
}

- (void) pressButton {
  NSString* username = self.LoginView.usernameField.text;
//  NSString* password = self.LoginView.passwordField.text;
//  self.keyStr = [self.dict valueForKey:username];
  self.KeyStr = @"a";
  NSString* password = @"a";
  if ((self.KeyStr != nil) && [password isEqual:self.KeyStr]) {
    NSLog(@"登录成功！通知协调者...");
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginViewControllerDidSucceed:)]) {
                [self.delegate loginViewControllerDidSucceed:self];
    }
  } else {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"输入正确的账号和密码" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
  }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
