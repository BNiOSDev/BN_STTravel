//
//  LBB_DownloadedViewController.m
//  ST_Travel
//  我的-下载
//  Created by 晨曦 on 16/11/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DownloadedViewController.h"
#import "ST_SquareViewController.h"
#import "ST_TabBarController.h"
#import "ZJMSearchBar.h"
#import "ZJScrollPageView.h"
#import "Header.h"
#import "LBB_DownloadTravelsViewController.h"
#import "LBB_TravelGuideViewController.h"

#define LG_scrollViewH 220
#define LG_segmentH 30
#define LG_segmentW AUTO(190)

@interface LBB_DownloadedViewController ()<UIScrollViewDelegate>
@property(nonatomic, weak)UISearchBar         *JMSearchBar;
@property (nonatomic, strong) UIScrollView      *scrollView;
@property(nonatomic, strong)LBB_DownloadTravelsViewController  *travelContrller;//游记
@property(nonatomic,strong) LBB_TravelGuideViewController *travelGuideController;//攻略

@end

@implementation LBB_DownloadedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"我的下载", nil);
    self.view.backgroundColor = ColorBackground;
    
    //加载Segment
    [self setSegment];
    //加载ViewController
    [self addChildViewController];
    //加载ScrollView
    [self setContentScrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSegment {
    
    _buttonList = [[NSMutableArray alloc] init];
    //初始化
    LGSegment *segment = [[LGSegment alloc] initWithFrame:CGRectMake((DeviceWidth - LG_segmentW)/ 2 , 5, LG_segmentW , LG_segmentH)];
    segment.backgroundColor = [UIColor whiteColor];
    segment.delegate = self;
    self.segment = segment;
    segment.backgroundColor = ColorBackground;
    [_buttonList addObject:@"游记"];
    [_buttonList addObject:@"攻略"];
    self.segment.buttonList = self.buttonList;
    [self.segment commonInit];
    [self.view addSubview:segment];
    self.LGLayer = segment.LGLayer;
    
}
//加载ScrollView
-(void)setContentScrollView {
    
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:sv];
    sv.bounces = NO;
    sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    sv.contentOffset = CGPointMake(0, 0);
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.scrollEnabled = NO;
    sv.userInteractionEnabled = YES;
    sv.delegate = self;
    
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i * DeviceWidth, 0, DeviceWidth, self.view.frame.size.height);
        [sv addSubview:vc.view];
    }
    
    sv.contentSize = CGSizeMake(_buttonList.count * DeviceWidth, 0);
    self.contentScrollView = sv;
}

//加载2个ViewController
-(void)addChildViewController{
    
    LBB_DownloadTravelsViewController *travelVC = [[LBB_DownloadTravelsViewController alloc]init];
    travelVC.viewType = TravelsViewDownloaed;
    [self addChildViewController:travelVC];
    
    LBB_TravelGuideViewController *travelGuideVC = [[LBB_TravelGuideViewController alloc]init];
    travelGuideVC.viewType = TravelsViewGuide;
    [self addChildViewController:travelGuideVC];
}

#pragma mark - UIScrollViewDelegate
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
    NSLog(@"Page = %d",Page);
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前index
    int  pageIndex = (int)(scrollView.contentOffset.x / DeviceWidth);
    NSLog(@"%d",(int)(scrollView.contentOffset.x / DeviceWidth));
    [self scrollToPage:pageIndex];//修复页面自动滚动偏差
}


@end
