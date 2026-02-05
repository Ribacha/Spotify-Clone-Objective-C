//
//  MiniPlayerFloat.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/8.
//

#import "MiniPlayerFloat.h"
#import "VCMusicPlayer.h"//实验用的
#import "Masonry/Masonry.h"
@implementation MiniPlayerFloat
//+ (instancetype) sharedWindow {
//  static MiniPlayerFloat *window = nil;
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    window = [[super alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    window.windowLevel = UIWindowLevelNormal + 1;
//    window.backgroundColor = [UIColor clearColor];
//    window.rootViewController = [[UIViewController alloc] init];
//    window.rootViewController.view.backgroundColor = [UIColor clearColor];
//    [window setupMinPlayer];
//  });
//  return window;
//}
//- (void) setupMinPlayer {
//  self.miniPlayer = [[MiniPlayerView alloc] init];
//  [self.rootViewController.view addSubview:self.miniPlayer];
//  [self.miniPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.left.right.equalTo(self.rootViewController.view);
//    make.bottom.equalTo(self.rootViewController.view.mas_safeAreaLayoutGuideBottom).offset(-50);
//    make.height.mas_equalTo(60);
//  }];
//  __weak typeof (self) weakself = self;
//  self.miniPlayer.tapAction = ^{
//    [weakself handleTap];
//  };
//}
////不了解
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//  CGPoint pointInMinPlayer = [self convertPoint:point toView:self.miniPlayer];
//  if ([self.miniPlayer pointInside:pointInMinPlayer withEvent:event]) {
//    return [super hitTest:point withEvent:event];
//  }
//  return nil;
//}
//// 不了解
//- (void) handleTap {
//  NSLog(@"点击了悬浮条");
//  UIWindow *keyWindow = nil;
//  for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
//    if (scene.activationState == UISceneActivationStateForegroundActive) {
//      for (UIWindow *w in scene.windows) {
//        if (w.isKeyWindow) {
//          keyWindow = w;
//          break;
//        }
//      }
//    }
//  }
//  if (keyWindow) {
//    UIViewController *rootVC = keyWindow.rootViewController;
//    while (rootVC.presentedViewController) {
//      rootVC = rootVC.presentedViewController;
//    }
//    VCMusicPlayer *detailVC = [[VCMusicPlayer alloc] init];
//    detailVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [rootVC presentViewController:detailVC animated:YES completion:nil];
//  }
//}
//
//- (void)show {
//  self.hidden = NO;
//  [self makeKeyAndVisible];
//}
//- (void)hide {
//  self.hidden = YES;
//}
@end
