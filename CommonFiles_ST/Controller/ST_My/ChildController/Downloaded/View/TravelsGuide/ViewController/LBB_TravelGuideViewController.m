//
//  LBB_TravelGuideViewController.m
//  ST_Travel
//  我的-下载-攻略
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelGuideViewController.h"
#import "SDAutoLayout.h"
#import "ZJMTravelCell.h"
#import "ZJMTravelModel.h"
#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"

#define MyTravelNormal  @"LBB_MyTravelTableViewCell"

@interface LBB_TravelGuideViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong)NSMutableArray   *dataArray;
@end

@implementation LBB_TravelGuideViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++) {
        ZJMTravelModel  *model = [[ZJMTravelModel alloc]init];
        model.iconName = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.imageUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.name = @"钟爱SD的男人";
        model.msgContent = @"开启说走就走的旅行吧";
        model.timeStr = @"2016-09-09";
        model.daysStr = @"5 days";
        model.vistNum = @"1080";
        model.praiseNum = @"999";
        model.commentNum = @"999";
        model.collectNum = @"9999";
        [_dataArray addObject:model];
    }
    [self createTable];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:YES animated:YES];
}

- (void)createTable
{
    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:0];
    _mTableView.height = _mTableView.height - AUTO(40) - 64;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = [UIColor whiteColor];
    
    [self.mTableView registerClass:[LBB_MyTravelTableViewCell class] forCellReuseIdentifier:MyTravelNormal];
    
    [self.view  addSubview:_mTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"wyl = 22222222");
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_MyTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTravelNormal];
    cell.cellBlock = ^(id view,UITableViewCellViewSignal signal){
        [self dealCellSignal:signal withIndex:indexPath];
    };
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    cell.viewType = _viewType;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
            
        }
            break;
        case UITableViewCellPraise:
        {
            
        }
            break;
        case UITableViewCellDelete://删除
        {
            
        }
            break;
        default:
            break;
    }
}

@end
