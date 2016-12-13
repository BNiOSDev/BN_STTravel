//
//  LBB_PublishTravel_Controller.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PublishTravel_Controller.h"
#import "LGSegment.h"
#import "Header.h"
#import "HMSegmentedControl.h"
#import "LBB_SelectImages_ViewController.h"
#import "LBB_ImagePick_ViewController.h"
#import <Photos/Photos.h>
#import "CTAssetsPickerController.h"
#import "LBB_ImagePick_ViewController.h"
#import "LBB_ZJMPhotoList.h"
#import "LBB_TravelNote_BaseViewController.h"
//ScrollView高度
#define LG_scrollViewH 220
//Segment高度
#define LG_segmentH 44
#define LG_segmentW AUTO(190)
@interface LBB_PublishTravel_Controller ()<UIScrollViewDelegate,SegmentDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    
}
@property(nonatomic)NSInteger      currentIndex;
@property(nonatomic,  strong) NSMutableArray *buttonList;
@property (nonatomic, weak)   LGSegment *segment;
@property(nonatomic,  weak)   CALayer *LGLayer;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,  strong) HMSegmentedControl *segmentedControl;
@property(nonatomic,  strong)  UIView     * imagePickGroundView;
@property(nonatomic,  strong)LBB_SelectImages_ViewController   *vc1;
@property(nonatomic,  strong)LBB_ImagePick_ViewController        *viewVC;
@end

@implementation LBB_PublishTravel_Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    //注册监听者。
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back:) name:@"goBack" object:nil];
    
    self.view.backgroundColor = BACKVIEWCOLOR;
    self.navigationController.navigationBar.hidden = YES;
    //加载Segment
    [self setSegment];
    //加载ViewController
    [self addChildViewController];
    //加载ScrollView
    [self setContentScrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)dealloc
{
    //移除本控制器的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:_segmentedControl];
}

- (void)back:(NSNotification *)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setSegment {
    _segmentedControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, DeviceHeight  -LG_segmentH, DeviceWidth, LG_segmentH)];
    _segmentedControl.backgroundColor = ColorWhite;
    _segmentedControl.sectionTitles = @[@"照片",@"视频",@"游记"];
    _segmentedControl.selectionIndicatorColor = ColorBtnYellow;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : ColorBlack};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : ColorBtnYellow};
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"index = %ld",index);
        [weakSelf.contentScrollView setContentOffset:CGPointMake(DeviceWidth * index, 0) animated:YES];
        if(index == 0)
        {
            [weakSelf.viewVC unregisterChangeObserver];
            
        }else if(index == 1)
        {
            [weakSelf.vc1 unregisterChangeObserver];
        }
            
    }];
    [self.view addSubview:_segmentedControl];
    
    __weak typeof (self) weckSelf = self;
    //处理点击滑动处理
    [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
        if(index == 2)
        {
            LBB_TravelNote_BaseViewController * vc3 = [[LBB_TravelNote_BaseViewController alloc]init];
            UINavigationController  *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
            [weckSelf.segmentedControl setSelectedSegmentIndex:weckSelf.currentIndex animated:YES];
            [weckSelf presentViewController:nav3 animated:YES completion:nil];
            
        }else if(index == 0)
        {
            _currentIndex = index;
            [weckSelf.contentScrollView setContentOffset:CGPointMake(0, weckSelf.contentScrollView.top)];
        }else{
            _currentIndex = index;
            [weckSelf.contentScrollView setContentOffset:CGPointMake(weckSelf.contentScrollView.width, weckSelf.contentScrollView.top)];
        }
    }];
}
//加载ScrollView
-(void)setContentScrollView {
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, DeviceHeight  - LG_segmentH)];
    [self.view addSubview:sv];
    sv.bounces = NO;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = YES;
    sv.scrollEnabled = YES;
    sv.userInteractionEnabled = YES;
    sv.delegate = self;
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * DeviceWidth, 0, DeviceWidth,DeviceHeight  - LG_segmentH);
        [sv addSubview:vc.view];
        
    }
    
    sv.contentSize = CGSizeMake(3 * DeviceWidth, 0);
    self.contentScrollView = sv;
}
//加载3个ViewController
-(void)addChildViewController{
    
    _vc1 = [[LBB_SelectImages_ViewController alloc]init];
    _vc1.view.backgroundColor = [UIColor whiteColor];
    UINavigationController  *nav1 = [[UINavigationController alloc]initWithRootViewController:_vc1];
    __weak typeof (self) _weakSelf = self;
    _vc1.addNum = 9;
    _vc1._blockHideControl = ^(id obj){
        [_weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    _vc1._blockJumpControl = ^(UIViewController *obj){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:obj];
        [_weakSelf presentViewController:nav animated:YES completion:nil];
    };
    [self addChildViewController:nav1];
    
    _viewVC = [[LBB_ImagePick_ViewController alloc]init];
    _viewVC.view.backgroundColor = WHITECOLOR;
    UINavigationController  *nav2 = [[UINavigationController alloc]initWithRootViewController:_viewVC];
    _viewVC._blockJumpControl = ^(UIViewController *obj){
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:obj];
        [_weakSelf presentViewController:nav animated:YES completion:nil];
    };
    [self addChildViewController:nav2];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    if(page == 0)
    {
        [self.viewVC unregisterChangeObserver];
        
    }else if(page == 1)
    {
        [self.vc1 unregisterChangeObserver];
    }
    if(page == 2)
    {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x - scrollView.frame.size.width, scrollView.top)];
        LBB_TravelNote_BaseViewController * vc3 = [[LBB_TravelNote_BaseViewController alloc]init];
        UINavigationController  *nav3 = [[UINavigationController alloc]initWithRootViewController:vc3];
        [self presentViewController:nav3 animated:YES completion:nil];
    }else{
        _currentIndex = page;
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
}


#pragma mark --  判断对相册和相机的使用权限
/**
 *  相册的使用权限
 *
 *  @return 是否
 */
-(BOOL)FZJhaveAlbumAuthority{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
    
}
/**
 *  相机的使用权限
 *
 *  @return 是否
 */
-(BOOL)FZJhaveCameraAuthority{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
@end
