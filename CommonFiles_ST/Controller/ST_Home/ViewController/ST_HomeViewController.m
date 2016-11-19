//
//  ST_HomeViewController.m
//  ST_Travel
//
//  Created by newman on 16/10/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ST_HomeViewController.h"
#import "PoohCommon.h"

#import "ST_TabBarController.h"
#import "LBBPoohVerticalButton.h"

#import "LBBHomeSearchResultViewController.h"
#import "LBBNearbyMainViewController.h"
#import "LBBSigninMainViewController.h"
#import "LBB_ScenicDetailSubjectViewController.h"

#import "LBBPoohBaseTableSectionHeaderView.h"
#import "LBB_HomeTableViewDataSource.h"

#import "LBB_HomeSearchViewController.h"

#import "LBB_PoohMyFavoriteViewController.h"



@interface ST_HomeViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSArray* sectionArray;
@property (nonatomic, retain) UITableView* tableView;

@property(nonatomic, retain)LBB_HomeTableViewDataSource* dataSource;

@property(nonatomic, retain)LBB_HomeViewModel* viewModel;//数据模型

@end

@implementation ST_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];

}

/*
-(BOOL)prefersStatusBarHidden{
    return YES;
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)loadCustomNavigationButton{
    WS(ws);
    LBBPoohVerticalButton *back = [[LBBPoohVerticalButton alloc] init];

    back.titleLabel.font = Font13;
    back.titleLabel.text = @"附近";
    back.frame = CGRectMake(0, 0, 45, 45);
    [back.imageView setImage:IMAGE(@"ST_Home_Nearby")];
    [back bk_whenTapped:^{
        
        NSLog(@"back touch");
        LBBNearbyMainViewController* v = [[LBBNearbyMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
    }];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    LBBPoohVerticalButton *sign = [[LBBPoohVerticalButton alloc] init];
    sign.titleLabel.font = Font13;
    sign.titleLabel.text = @"签到";
    sign.frame = CGRectMake(0, 0, 45, 45);
    [sign.imageView setImage:IMAGE(@"ST_Home_Signin")];
    [sign bk_whenTapped:^{
        
        NSLog(@"signButton touch");
        LBBSigninMainViewController* v = [[LBBSigninMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
        
    }];
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:sign];
    self.navigationItem.rightBarButtonItem = signItem;
    
    
    CGFloat height = IAppNavigationBarHeight - 10;
    CGFloat width = DeviceWidth - 2*45 - 30;

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = [UIColor blackColor].CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.cornerRadius = height/2;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = @"请输入 景点 美食 民宿";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    [titleView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(titleView);
    }];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
}


/*
 *  setup UI
 */
-(void)buildControls{
    self.sectionArray = @[
                          @"",
                          @"热门推荐",
                          @"游记推荐",
                          @"达人推荐",
                          @"广场中心",
                          @"伴手礼推荐",
                          ];
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    self.dataSource = [[LBB_HomeTableViewDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.parentViewController = self;

    [self initViewModel];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-IAppTabBarHeight);
    }];
}


/*
 *  init view Model
 */
-(void)initViewModel{
    
    self.viewModel = [[LBB_HomeViewModel alloc]init];
    
    /**
     3.1.2 广告轮播 1.首页最顶部
     @param clear 是否清空原数据
     */
    [self.viewModel getAdvertisementListArrayClearData:YES];
    
    //1.监听数据，用来刷新数据，数据变化才会调用
    WS(ws);
    [self.viewModel.advertisementArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];
   
    
    /**
     3.1.2 广告轮播 5.首页热门推荐
     @param clear 是否清空原数据
     */
    [self.viewModel getSpotAdvertisementListArrayClearData:YES];
    [self.viewModel.spotAdvertisementArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];
    
    
    /**
     3.1.3 公告轮播
     @param clear 是否清空原数据
     */
    [self.viewModel getNoticesArrayClearData:YES];
    [self.viewModel.noticesArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];

    /**
     3.1.4 热门推荐
     @param clear 是否清空原数据
     */
#pragma 数据获取失败
    [self.viewModel getSpotsArrayClearData:YES];
    [self.viewModel.spotsArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];
    
    /**
     3.1.7 游记推荐
     @param clear 是否清空原数据
     */
    [self.viewModel getTravelNotesArrayClearData:YES];
    [self.viewModel.travelNotesArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];
    
    /**
     3.1.8 达人推荐
     @param Type 1.景点 2.美食 3.民宿
     */
   // [self.viewModel getSpotsArrayWithType:1];

    
    /**
     3.1.9 广场中心
     @param clear 是否清空原数据
     */
  //  [self.viewModel getUgcArrayClearData:YES];

    
#pragma 响应处理
    //2.0响应的view，网络状态变化时的再刷新动作
    //  [self.tableView setTableViewData:self.viewModel.advertisementArray];
    //2.1点击刷新
    /* [ws.tableView setRefreshBlock:^{
     [ws.viewModel getAdvertisementListArrayClearData:NO];
     }];
     */
    //3.0 table view 的数据绑定，刷新，上拉刷新，下拉加载。全部集成在里面
    // [self.tableView setTableViewData:self.viewModel.advertisementArray];
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        [ws.viewModel getAdvertisementListArrayClearData:YES];//取数据     3.1.2 广告轮播 1.首页最顶部
        [ws.viewModel getSpotAdvertisementListArrayClearData:YES];//3.1.2 广告轮播 5.首页热门推荐
        
    } footerRefreshDatablock:^{
        // [ws.viewModel getAdvertisementListArrayClearData:NO];
        // [ws.tableView.mj_footer endRefreshing];
        
    }];
    
    
    //数据赋值为dataSource
    self.dataSource.viewModel = self.viewModel;
    
    
}


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    LBB_HomeSearchViewController* searchVC = [[LBB_HomeSearchViewController alloc]init];
    searchVC.searchType = LBBPoohHomeSearchTypeSquare;
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}



#pragma tableView Delegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* v = [UIView new];
    return v;
};

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == LBBHomeSectionMenuType) {
        return 0.001;
    }
    return DeviceWidth* 86/640;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == LBBHomeSectionMenuType) {
        return [UIView new];
    }
    UIView* v = [UIView new];
    [v setBackgroundColor:[UIColor whiteColor]];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    
    UIImageView* img = [UIImageView new];
    [img setImage:IMAGE([self.sectionArray objectAtIndex:section])];
    [img setContentMode:UIViewContentModeCenter];
    [v addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.height.width.equalTo(v);
       // make.width.equalTo(@184);
    }];
    
    UIButton* btn = [UIButton new];
    [btn setBackgroundImage:IMAGE(@"ST_Home_Arrow") forState:UIControlStateNormal];
    [btn setContentMode:UIViewContentModeCenter];
    [v addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.width.mas_equalTo(15);
        make.height.equalTo(@22);
        make.centerY.equalTo(v);
        make.right.equalTo(v).offset(-16);
    }];
    
    [btn bk_addEventHandler:^(id sender){
    
        NSLog(@"touch section header");
        
        if (section == LBBHomeSectionTravelRecommendType) {//游记推荐，跳转到游记
            [self.tabBarController setSelectedIndex:1];
        }
        else if (section == LBBHomeSectionSquareCenterType) {//广场中心，跳转到广场主页
            [self.tabBarController setSelectedIndex:1];
        }
        else if (section == LBBHomeSectionTravelProductType) {//旅游产品，跳转到商场主页
            [self.tabBarController setSelectedIndex:3];
        }
        
    } forControlEvents:UIControlEventTouchUpInside];

    
    if ((section == LBBHomeSectionHotestType)
        ||(section == LBBHomeSectionVipRecommendType)) {
        btn.hidden = YES;
    }
    
    
    return v;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSource tableView:tableView heightForRowAtIndexPath:indexPath];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}




@end
