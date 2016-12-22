//
//  ST_HomeViewController.m
//  ST_Travel
//
//  Created by newman on 16/10/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//
//ScrollView高度
#define LG_scrollViewH 220
//Segment高度
#define LG_segmentH 30
#define LG_segmentW AUTO(190)
#import "ST_SquareViewController.h"
#import "ST_TabBarController.h"
#import "ZJMSearchBar.h"
#import "ZJScrollPageView.h"
#import "Header.h"
#import "ZJMTravelsViewController.h"
#import "LBBVideoViewController.h"
#import "LBB_ZJMHostViewController.h"
#import "CoreData+MagicalRecord.h"
#import "LBB_TravelDetailViewController.h"
#import "LBB_HomeSearchViewController.h"

@interface ST_SquareViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UINavigationControllerDelegate>
{
    NSInteger  currentPage;
}
@property(nonatomic, weak)UISearchBar         *JMSearchBar;
@property (nonatomic, strong) UIScrollView      *scrollView;
@property(nonatomic, strong)ZJMTravelsViewController    *travelContrller;
@end

@implementation ST_SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    self.navigationController.delegate = self;
    self.navigationItem.leftBarButtonItem = nil;
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"history"];
    [self  initNaviStyle];
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
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
//    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];

}

/**
 *  初始化nav
 */
- (void)initNaviStyle
{
    //将搜索条放在一个UIView上
    ZJMSearchBar *searchBar = [[ZJMSearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 25)];
    searchBar.placeholder = @"请搜索 标签 用户";
    searchBar.delegate = self;
    searchBar.layer.borderWidth = 1.0;
    searchBar.layer.borderColor = ColorBlack.CGColor;
    _JMSearchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    //ios7以后设置UISearchBar内部编辑框的背景颜色
    UIView *searchTextField = nil;
    _JMSearchBar.barTintColor = [UIColor clearColor];//必须先设置barTintColor才能获取得到searchTextField
    searchTextField = [[[_JMSearchBar.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor = [UIColor whiteColor];
}

-(void)setSegment {
    
    _buttonList = [[NSMutableArray alloc]init];
    //初始化
    LGSegment *segment = [[LGSegment alloc]initWithFrame:CGRectMake((DeviceWidth - LG_segmentW)/ 2 , 5, LG_segmentW , LG_segmentH)];
    segment.backgroundColor = [UIColor whiteColor];
    segment.delegate = self;
    self.segment = segment;
    [_buttonList addObject:@"主页"];
    [_buttonList addObject:@"游记"];
    [_buttonList addObject:@"视频"];
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
//加载3个ViewController
-(void)addChildViewController{
    //LBB_ZJMHostViewController
//    ZJMHostViewController * vc1 = [[ZJMHostViewController alloc]init];
//    vc1.jumpBlock = ^(id obj,id pargram){
//        [self.navigationController pushViewController:obj animated:YES];
//    };
//    [self addChildViewController:vc1];
    
    LBB_ZJMHostViewController *vc1 = [[LBB_ZJMHostViewController alloc]init];
    [self addChildViewController:vc1];
    
    ZJMTravelsViewController *viewVC = [[ZJMTravelsViewController alloc]init];
    [self addChildViewController:viewVC];
    
    LBBVideoViewController * vc3 = [[LBBVideoViewController alloc]init];
    [self addChildViewController:vc3];
    
}

-(void)scrollToIndex:(int)Page
{
    NSLog(@"已有滚动");
    [self.segment moveToButtonIndex:Page];
}

#pragma mark - UIScrollViewDelegate
//实现LGSegment代理方法
-(void)scrollToPage:(int)Page {
    CGPoint offset = self.contentScrollView.contentOffset;
    currentPage = Page;
    offset.x = self.view.frame.size.width * Page;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentScrollView.contentOffset = offset;
    }];
    NSLog(@"Page = %d",Page);
}
// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    int  pageIndex = (int)(scrollView.contentOffset.x / DeviceWidth);
    NSLog(@"%d",(int)(scrollView.contentOffset.x / DeviceWidth));

    [self scrollToPage:(int)currentPage];//修复页面自动滚动偏差
}

//可以归类处理，UINavigationController在各个控制器的显示和不显示
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController == [self class])
    {
         [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    }
    if([viewController isKindOfClass:[LBB_TravelDetailViewController class]])
    {
        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0.0;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([viewController isKindOfClass:[LBB_TravelDetailViewController class]])
    {
        self.navigationController.navigationBar.hidden = NO;
    }
}

#pragma mark searchBarShouldBeginEditing
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"zzzzz");
    LBB_HomeSearchViewController* searchVC = [[LBB_HomeSearchViewController alloc]init];
    searchVC.searchType = LBBPoohHomeSearchTypeUser;
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}


@end
