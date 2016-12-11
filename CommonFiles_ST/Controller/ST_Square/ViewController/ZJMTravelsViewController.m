//
//  ZJMTravelsViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ZJMTravelsViewController.h"
#import "SDAutoLayout.h"
#import "ZJMTravelCell.h"
#import "ZJMTravelModel.h"
#import "LBBTravelTableViewCell.h"
#import "Header.h"
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"
#import "LBB_SquareTravelListViewModel.h"

#define ZJMTravelNormal  @"ZJMTravelCell"

@interface ZJMTravelsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView         *mTableView;
@property(nonatomic, strong)LBB_SquareTravelListViewModel   *viewModel;

@end

@implementation ZJMTravelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTable];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}

-(void)initViewModel{

    self.viewModel = [[LBB_SquareTravelListViewModel alloc] init];
    
    /**
     3.4.16 主页-游记列表（已测）
     */
    __weak typeof(self) temp = self;
    
    [self.viewModel getSquareTravelList:YES];
    [self.viewModel.squareTravelArray.loadSupport setDataRefreshblock:^{
        [temp.mTableView reloadData];
    }];
    
    [self.mTableView setTableViewData:self.viewModel.squareTravelArray];
    
    //3.1上拉和下拉的动作
    [self.mTableView setHeaderRefreshDatablock:^{
        [temp.viewModel getSquareTravelList:YES];
        
        [temp.mTableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        [temp.viewModel getSquareTravelList:NO];
        [temp.mTableView.mj_footer endRefreshing];
    }];
}


- (void)createTable
{
    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:0];
    _mTableView.height = _mTableView.height - AUTO(40) - 64 -50;
    [self initViewModel];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = [UIColor whiteColor];
    
    [self.mTableView registerClass:[LBBTravelTableViewCell class] forCellReuseIdentifier:ZJMTravelNormal];
    
    [self.view  addSubview:_mTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"wyl = 22222222");
    return self.viewModel.squareTravelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBBTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJMTravelNormal];
    cell.cellBlock = ^(id view,UITableViewCellViewSignal signal){
        [self dealCellSignal:signal withIndex:indexPath];
    };
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
   
    cell.model = self.viewModel.squareTravelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
    vc.model = _viewModel.squareTravelArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    return AUTO(215);
}


#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UITableViewCellViewSignal)signel  withIndex:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    switch (signel) {
        case UITableViewCellCollect:
        {
            
        }
            break;
        case UITableViewCellConment:
        {
            LBB_TravelCommentController *vc = [[LBB_TravelCommentController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UITableViewCellPraise:
        {
            
        }
            break;
        
        default:
            break;
    }
}




@end
