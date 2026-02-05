//
//  VCMusicPlayer.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/12/8.
//

#import "VCMusicPlayer.h"
#import "MusicPlayerManager.h"
@interface VCMusicPlayer ()

@end

@implementation VCMusicPlayer
- (void)loadView {
  self.mainView = [[MusicPlayerDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.mainView.delegate = self;
  self.view = self.mainView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  [self addNotifications];
  [self updateData];
}
- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) updateData {
  MusicPlayerManager *manager = [MusicPlayerManager shared];
  [self.mainView updatePlayState:manager.isPlaying];
  if (manager.currentModel) {
    [self.mainView updateWithModel:manager.currentModel];
  }
}
- (void)addNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSongChange) name:@"MusicPlayerDidChangeSongNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayStateChange) name:@"MusicPlayerStateDidChangeNotification" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleProgressUpdate) name:@"MusicPlayerProgressDidUpdateNotification" object:nil];
}
- (void) handleSongChange {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self updateData];
  });
}
- (void) handlePlayStateChange {
  [self.mainView updatePlayState:[MusicPlayerManager shared].isPlaying];
}
- (void) handleProgressUpdate {
  MusicPlayerManager *manager = [MusicPlayerManager shared];
  [self.mainView updateProgress:manager.currentTime total:manager.totalDuration];
}
- (void)playerViewDidTapPlayPause {
    [[MusicPlayerManager shared] togglePlayPause];
}
- (void)playerViewDidTapPreivous {
  [[MusicPlayerManager shared] playPrevious];
}
- (void)playerViewDidTapNext {
  [[MusicPlayerManager shared] playNext];
}
- (void)playerViewDidSeekToTime:(NSTimeInterval)time {
  [[MusicPlayerManager shared] seekToTime:time];
}
@end
