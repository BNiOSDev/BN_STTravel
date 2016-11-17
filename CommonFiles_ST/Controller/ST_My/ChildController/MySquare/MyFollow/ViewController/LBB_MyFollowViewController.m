//
//  LBB_MyFollowViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyFollowViewController.h"
#import "ST_TabBarController.h"
#import "Header.h"
#import "LBB_FollowViewController.h"
#import "LBB_MyChatViewController.h"
#import "HMSegmentedControl.h"

#define ViewNum   3


@interface LBB_MyFollowViewController ()
<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic,strong) LBB_MyChatViewController *chatVC;
@property(nonatomic,strong) LBB_FollowViewController *followVC;
@property(nonatomic,strong) LBB_FollowViewController *fansVC;
@property(nonatomic,strong) HMSegmentedControl *segmentedControl;


@end

@implementation LBB_MyFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"关注", nil);
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
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"聊天",@"粉丝",@"关注"]];
    _segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                             NSForegroundColorAttributeName:ColorLightGray};
    _segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:Font15,
                                                     NSForegroundColorAttributeName:ColorBtnYellow};
    _segmentedControl.selectionIndicatorColor = ColorBtnYellow;
    _segmentedControl.verticalDividerWidth = 1.0;
    _segmentedControl.verticalDividerColor = ColorLightGray;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.layer.borderColor = [ColorLine CGColor];
    _segmentedControl.layer.borderWidth = 1.0;
    _segmentedControl.frame = CGRectMake(0, 0, DeviceWidth, TopSegmmentControlHeight);

    
    [_segmentedControl addTarget:self
                         action:@selector(segmentedControlChangedValue:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentedControl];
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
    
    sv.contentSize = CGSizeMake(ViewNum * DeviceWidth, 0);
    self.contentScrollView = sv;
}

//加载3个ViewController
-(void)addChildViewController{
    
    self.chatVC = [[LBB_MyChatViewController alloc] init];
    [self addChildViewController:self.chatVC];
    
    self.fansVC = [[LBB_FollowViewController alloc]init];
    [self addChildViewController:self.fansVC];

    self.followVC = [[LBB_FollowViewController alloc]init];
    [self addChildViewController:self.followVC];
}

#pragma mark - UIScrollViewDelegate

- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentControll
{
    int selectIndex = (int)segmentControll.selectedSegmentIndex;
    [self scrollToPage:selectIndex];
}
 
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前index
    int  pageIndex = (int)(scrollView.contentOffset.x / DeviceWidth);
    NSLog(@"%d",(int)(scrollView.contentOffset.x / DeviceWidth));
    [self scrollToPage:pageIndex];//修复页面自动滚动偏差
}

//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
    NSLog(@"Page = %d",Page);
}

@end
