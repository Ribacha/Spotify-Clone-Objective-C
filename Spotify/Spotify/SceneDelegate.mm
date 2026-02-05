//
//  SceneDelegate.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/11.
//

#import "SceneDelegate.h"
#import "VCLogin.h" // 导入登录页
#import "MainTabBarController.h"
#import "MiniPlayerFloat.h"
//#import "MainTabBarController.h" // 导入新的主界面 TabBar

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    VCLogin *loginVC = [[VCLogin alloc] init];
    loginVC.delegate = self;
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
//  if ([scene isKindOfClass:[UIWindowScene class]]) {
//    MiniPlayerFloat *musicWindow = [MiniPlayerFloat sharedWindow];
//    musicWindow.windowScene = (UIWindowScene *)scene;
//    musicWindow.hidden = NO;
//  }
}
- (void)loginViewControllerDidSucceed:(VCLogin *)controller {
    NSLog(@"SceneDelegate 收到登录成功通知，准备创建主界面...");
    MainTabBarController *mainTabBar = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTabBar;
    [UIView transitionWithView:self.window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}


@end
