//
//  ST_HomeViewController.m
//  ST_Travel
//
//  Created by newman on 16/10/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ST_SquareViewController.h"
#import "ST_TabBarController.h"
#import "ZJMSearchBar.h"
#import "ZJScrollPageView.h"

@interface ST_SquareViewController ()<UISearchBarDelegate>
@property(nonatomic, weak)UISearchBar       *JMSearchBar;
@end

@implementation ST_SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  initNaviStyle];
    [self  initToolsBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
    
}
/**
 *  初始化nav
 */
- (void)initNaviStyle
{
    //将搜索条放在一个UIView上
    ZJMSearchBar *searchBar = [[ZJMSearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.placeholder = @"请搜索 标签 用户";
    searchBar.delegate = self;
    searchBar.layer.borderWidth = AUTO(0.5);
    searchBar.layer.borderColor = [UIConstants getSeperatorLineColor].CGColor;
    searchBar.layer.cornerRadius = 20.0;
    _JMSearchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    
    //ios7以后设置UISearchBar内部编辑框的背景颜色
    UIView *searchTextField = nil;
    _JMSearchBar.barTintColor = [UIColor clearColor];//必须先设置barTintColor才能获取得到searchTextField
    searchTextField = [[[_JMSearchBar.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor = [UIColor whiteColor];
}

- (void)initToolsBar
{
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = NO;
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 显示附加的按钮
    style.showExtraButton = NO;
    //style.normalTitleColor =  [UIColor blackColor];
    style.segmentHeight = AUTO(30);
    // 设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
    NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style childVcs:childVcs parentViewController:self];
    // 额外的按钮响应的block
    //    __weak typeof(self) weakSelf = self;
    //    scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
    //        weakSelf.title = @"点击了extraBtn";
    //        NSLog(@"点击了extraBtn");
    //    };
    [self.view addSubview:scrollPageView];
    
}

- (NSArray *)setupChildVcAndTitle {
    
    UIViewController *vc1 =  [UIViewController new];
    vc1.title = @"主页";//
    
    UIViewController *vc2 = [UIViewController new];
    vc2.title = @"游记"; //
    
    UIViewController *vc3 = [UIViewController new];
    vc3.title = @"视频"; //
    

    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    return childVcs;
}


@end
