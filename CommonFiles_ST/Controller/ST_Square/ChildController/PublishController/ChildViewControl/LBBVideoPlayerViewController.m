//
//  LBBVideoPlayerViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBVideoPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>

@interface LBBVideoPlayerViewController ()
@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)UIImageView     *videoBack;
@property (nonatomic,strong)UIButton            *selectBtn;
@property (strong, nonatomic) MPMoviePlayerViewController *moviePlayerView;
@end

@implementation LBBVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"播放准备中");
//    _videoBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
//    [self.view addSubview:_videoBack];
//    
//    //创建播放器层
//    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
//    NSLog(@"播放准备2");
//    playerLayer.frame=self.videoBack.frame;
//    [self.videoBack.layer addSublayer:playerLayer];
//    NSLog(@"播放准备中3");
    
    //创建MP播放器
//    MPMoviePlayerController *movie = [[MPMoviePlayerController alloc]initWithContentURL:_videoUrl];
//    movie.controlStyle = MPMovieControlStyleFullscreen;
//    [movie.view  setFrame:_videoBack.frame];
//    movie.initialPlaybackTime = -1;
//    [_videoBack addSubview:movie.view];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:movie];
//    [movie play];
}

- (void)toPlay
{
    NSURL *movieURL = _videoUrl;
    [_moviePlayerView.view removeFromSuperview];
    _moviePlayerView = nil;
    _moviePlayerView =[[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    [_moviePlayerView.moviePlayer prepareToPlay];
    [self.view addSubview:_moviePlayerView.view];
    
    _moviePlayerView.moviePlayer.shouldAutoplay=YES;
    [_moviePlayerView.moviePlayer setControlStyle:MPMovieControlStyleDefault];
    [_moviePlayerView.moviePlayer setFullscreen:YES];
    [_moviePlayerView.view setFrame:self.view.bounds];
    
    //播放完后的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(movieFinishedCallback:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification                                                      object:nil];
    //离开全屏时通知，因为默认点击Done是是退出全屏，要离开播放器就有覆盖掉这个事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen:) name: MPMoviePlayerDidExitFullscreenNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self toPlay];
    NSLog(@"yuanyin :%@",self.player.reasonForWaitingToPlay);
    NSLog(@"zhuangtai:%ld",(long)self.player.timeControlStatus);
}

- (void)myMovieFinishedCallBack:(NSNotification *)notify
{
    MPMoviePlayerController  *theMovie  = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    [self dismissViewControllerAnimated:NO completion:nil];
}

/**
 *  初始化播放器
 *
 *  @return 播放器对象
 */
-(AVPlayer *)player{
    if (!_player) {

        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:_videoUrl];
    
        _player=[AVPlayer playerWithPlayerItem:playerItem];
        if([[UIDevice currentDevice] systemVersion].intValue>=10){
            //      增加下面这行可以解决ios10兼容性问题了
            NSLog(@"这是iOS10以上");
            self.player.automaticallyWaitsToMinimizeStalling = NO;
        }
    }
    return _player;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.player pause];
    self.player = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
