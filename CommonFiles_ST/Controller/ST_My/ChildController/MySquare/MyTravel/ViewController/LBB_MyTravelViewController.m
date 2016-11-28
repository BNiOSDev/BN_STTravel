//
//  LBB_MyTravelViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyTravelViewController.h"
#import "SDAutoLayout.h"
#import "ZJMTravelCell.h"
#import "LBB_TravelModel.h"
#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"

#define MyTravelNormal  @"LBB_MyTravelTableViewCell"

#import "SDAutoLayout.h"
#import "ZJMTravelModel.h"
#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"

#define MyTravelNormal  @"LBB_MyTravelTableViewCell"

@interface LBB_MyTravelViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong) LBB_TravelViewModel *viewModel;

@end

@implementation LBB_MyTravelViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTable];
    [self initDataSource];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)createTable
{
    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:UITableViewStyleGrouped];
    _mTableView.height = _mTableView.height - TopSegmmentControlHeight - 64;
    if(self.travelviewType == MyTravelsViewFravorite) {
        _mTableView.height = DeviceHeight - 64;
        self.navigationItem.title = NSLocalizedString(@"游记", nil);
    }
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = [UIColor whiteColor];
    
    [self.mTableView registerClass:[LBB_MyTravelTableViewCell class] forCellReuseIdentifier:MyTravelNormal];
     [self.view  addSubview:_mTableView];
}

- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_TravelViewModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    [self.mTableView setHeaderRefreshDatablock:^{
         [weakSelf.viewModel getMyTravelList:YES VidewType:weakSelf.squareType];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getMyTravelList:NO VidewType:weakSelf.squareType];
    }];
    
    //设置绑定数组
    [self.mTableView setTableViewData:self.viewModel.travelArray];
    
    
    [self.viewModel.travelArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.mTableView loadData:self.viewModel.travelArray];

    //刷新数据
    
    [self.viewModel getMyTravelList:YES VidewType:self.squareType];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"wyl = 22222222");
    return self.viewModel.travelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_MyTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTravelNormal];
    cell.cellBlock = ^(id info,UICollectionViewCellSignal signal){
        [self dealCellSignal:signal withIndex:indexPath Object:info];
    };
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    cell.viewType = _travelviewType;
    cell.squareType = _squareType;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    if (self.viewModel.travelArray.count > indexPath.row) {
         cell.model = self.viewModel.travelArray[indexPath.row];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    return AUTO(215);
}

#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UICollectionViewCellSignal)signel  withIndex:(NSIndexPath *)indexPath Object:(id)infoObject
{
    LBB_TravelModel *travelModel = (LBB_TravelModel*)infoObject;
    __weak typeof (self) weakSelf = self;
    __weak typeof (LBB_TravelModel *) weakTravelModel = travelModel;
    
    [travelModel.loadSupport setDataRefreshblock:^{
        [weakSelf.mTableView reloadData];
    }];
    
    [travelModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        if (remak && [remak length]) {
            [weakSelf showHudPrompt:remak];
        }
    }];
    
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    switch (signel) {
        case UICollectionViewCellPraise://赞
        {
            [travelModel like];
        }
            break;
        case UICollectionViewCellComment://评论
        {
            LBB_TravelCommentController *vc = [[LBB_TravelCommentController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UICollectionViewCellHeart://爱心
        {
            
            [travelModel collect];
        }
            break;
        case UICollectionViewCellDelete://删除
        {
            [travelModel.loadSupport setDataRefreshblock:^{
                for (int i = 0; i < weakSelf.viewModel.travelArray.count; i++) {
                    LBB_TravelModel *tmpModel = weakSelf.viewModel.travelArray[i];
                    if (tmpModel.travelNoteId == weakTravelModel.travelNoteId) {
                        [weakSelf.viewModel.travelArray removeObject:tmpModel];
                        break;
                    }
                }
                [weakSelf.mTableView reloadData];
            }];
            
            [travelModel deleteTravel];
        }
            break;
        case UICollectionViewCellCollection://收藏
        {
            [travelModel collect];
        }
            break;
        default:
            break;
    }
}

@end
