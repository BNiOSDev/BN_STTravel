//
//  LBB_MessageSquareViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MessageSquareViewController.h"
#import "LBB_SquareTravelViewController.h"
#import "HMSegmentedControl.h"


#define ViewNum 4

@interface LBB_MessageSquareViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property(nonatomic, strong) LBB_SquareTravelViewController  *followVC;//关注
@property(nonatomic,strong) LBB_SquareTravelViewController *zanVC;//点赞
@property(nonatomic, strong) LBB_SquareTravelViewController  *commentVC;//评论
@property(nonatomic,strong) LBB_SquareTravelViewController *collectVC;//收藏

@property(nonatomic,strong) HMSegmentedControl *segmentedControl;

@end

@implementation LBB_MessageSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"广场游记", nil);
    self.view.backgroundColor = ColorBackground;
    self.baseViewType = eSquareTravel;
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSegment {
    
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"关注",@"点赞",@"评论",@"收藏"]];
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

//加载4个ViewController
-(void)addChildViewController{
    
    self.followVC = [self getChildVC];
    self.followVC.messgeType = eMessageFollow;
    [self addChildViewController:self.followVC];
    
    self.zanVC = [self getChildVC];
    self.zanVC.messgeType = eMessageLike;
    [self addChildViewController:self.zanVC];
    
    self.commentVC = [self getChildVC];
    self.commentVC.messgeType = eMessageComment;
    [self addChildViewController:self.commentVC];
    
    self.commentVC = [self getChildVC];
    self.commentVC.messgeType = eMessageCollection;
    [self addChildViewController:self.commentVC];
}


- (LBB_SquareTravelViewController *)getChildVC
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    LBB_SquareTravelViewController  *vc  = [main instantiateViewControllerWithIdentifier:@"LBB_SquareTravelViewController"];
    
    return vc ;
}


#pragma mark - UIScrollViewDelegate

- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentControl
{
    NSInteger selectIndex = segmentControl.selectedSegmentIndex;
    [self scrollToPage:(int)selectIndex];
}

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
