//
//  LBB_PublishVideo_Contain_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PublishVideo_Contain_ViewController.h"
#import "Header.h"
#import <AVFoundation/AVFoundation.h>
#import "LBB_EditPublishVideo_ViewController.h"
#import "LBB_TipImage_Pulish_ImageView.h"
#import "FZJPhotoModel.h"

@interface LBB_PublishVideo_Contain_ViewController ()
@property(nonatomic,strong)LBB_TipImage_Pulish_ImageView    *imageContainView;
@property(nonatomic,strong)UIImageView    *pauseImage;
@property(nonatomic,strong)AVPlayer           *player;
@end

@implementation LBB_PublishVideo_Contain_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    self.navigationItem.title = @"发布内容";
    self.view.backgroundColor = ColorWhite;
    
    UIBarButtonItem  *backItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:0 target:self action:@selector(backToController)];
    backItem.tintColor = [UIColor blueColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)backToController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initView
{
    UILabel  *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, AUTO(10.0), DeviceWidth, AUTO(20))];
    tipLabel.font = FONT(AUTO(12.0));
    tipLabel.textColor = MORELESSBLACKCOLOR;
    tipLabel.text = @"点击视频添加标签，至少添加一个标签";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    _imageContainView = [[LBB_TipImage_Pulish_ImageView alloc]initWithFrame:CGRectMake(AUTO(5), tipLabel.bottom + AUTO(10), DeviceWidth - AUTO(10), DeviceWidth - AUTO(20))];
    [self.view addSubview:_imageContainView];
    
    _pauseImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,AUTO(43), AUTO(43))];
    _pauseImage.image = [UIImage imageNamed:@"zjmbofang"];
    _pauseImage.center = _imageContainView.center;
    [self.view addSubview:_pauseImage];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(AUTO(30), _imageContainView.bottom + AUTO(20), DeviceWidth - AUTO(60), AUTO(45))
                         ];
    nextBtn.backgroundColor = UIColorFromRGB(0xAB783A);
    [nextBtn setTitle:@"下一步" forState:0];
    [nextBtn setTitleColor:WHITECOLOR forState:0];
    nextBtn.titleLabel.font = FONT(AUTO(15));
    [nextBtn addTarget:self action:@selector(editPulish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}


- (void)editPulish
{
    LBB_EditPublishVideo_ViewController *Vc = [[LBB_EditPublishVideo_ViewController alloc]init];
    FZJPhotoModel *model = [[FZJPhotoModel alloc]init];
    model.asset = _videoAsset;
    Vc.imageArray = @[model];
    [self.navigationController pushViewController:Vc animated:YES];
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

- (void)setVideoAsset:(PHAsset *)videoAsset
{
    [self initView];
    _videoAsset = videoAsset;
    CGSize size = CGSizeMake(_imageContainView.size.width, _imageContainView.size.height);
    size.height *= [UIScreen mainScreen].scale;
    size.width *= [UIScreen mainScreen].scale;
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = NO;//YES 一定是同步    NO不一定是异步
    imageOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    imageOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;//imageOptions.synchronous = NO的情况下最终决定是否是异步
    [[PHImageManager defaultManager] requestImageForAsset:videoAsset targetSize:size contentMode:PHImageContentModeAspectFit options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        _imageContainView.image = result;
    }];

    
    //
//    PHAsset *phAsset = videoAsset;
//    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
//    options.version = PHImageRequestOptionsVersionCurrent;
//    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
//    
//    PHImageManager *manager = [PHImageManager defaultManager];
//    [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
//        AVURLAsset *urlAsset = (AVURLAsset *)asset;
//        
//        NSURL *url = urlAsset.URL;
//        self.videoUrl = url;
//    
//    }];

}


@end
