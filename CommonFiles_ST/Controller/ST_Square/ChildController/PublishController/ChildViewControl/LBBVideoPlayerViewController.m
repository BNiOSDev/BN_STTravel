//
//  LBBVideoPlayerViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBVideoPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LBBVideoPlayerViewController ()
@property (nonatomic,strong)AVPlayer *player;//播放器对象
@property (nonatomic,strong)UIImageView     *videoBack;
@property (nonatomic,strong)UIButton            *selectBtn;
@end

@implementation LBBVideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _videoBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
    [self.view addSubview:_videoBack];
    
    //创建播放器层
    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame=self.videoBack.frame;
    [self.videoBack.layer addSublayer:playerLayer];
    
    [self.player play];
}

/**
 *  初始化播放器
 *
 *  @return 播放器对象
 */
-(AVPlayer *)player{
    if (!_player) {
//        NSString *urlStr=@"http://vr.tudou.com/v2proxy/v2.m3u8?it=170010302&st=2";
//        NSURL *url=[NSURL URLWithString:urlStr];
        //创建播放对象
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:_videoUrl];
        
        // AVPlayerItem *playerItem=[self getPlayItem:0];
        //播放器执行播放对象
        _player=[AVPlayer playerWithPlayerItem:playerItem];
//        [self addProgressObserver];//进度条
//        [self addObserverToPlayerItem:playerItem];//AVPlayerItem添加监控
    }
    return _player;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.player pause];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
