//
//  LBB_Travel_Bill_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Travel_Bill_ViewController.h"
#import "ST_TabBarController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"
#import "LBB_Travel_Bill_Cell.h"
#import "LBB_Tarvel_Bill_Free_Cell.h"
#import "LBB_Travel_Bill_Account_TableViewCell.h"
#import "ZJMHostModel.h"
#import "LBB_ShopRecoder_Controller.h"
#import "LBB_EditShopRecoder_Controller.h"

@interface LBB_Travel_Bill_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, weak)UIView *tabelFoot;
@property(nonatomic, strong)BN_SquareTravelNotesModel  *viewModel;
@end

@implementation LBB_Travel_Bill_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"游记账单";
    self.view.backgroundColor = BACKVIEWCOLOR;
    _viewModel = [[BN_SquareTravelNotesModel alloc]init];
    _viewModel.travelNotesId = _travelNotesId;
    [self initData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - AUTO(15))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = 0;
    [self.tableView registerClass:[LBB_Travel_Bill_Cell class] forCellReuseIdentifier:@"LBB_Travel_Bill_Cell"];
    [self.tableView registerClass:[LBB_Tarvel_Bill_Free_Cell class] forCellReuseIdentifier:@"LBB_Tarvel_Bill_Free_Cell"];
    [self.tableView registerClass:[LBB_Travel_Bill_Account_TableViewCell class] forCellReuseIdentifier:@"LBB_Travel_Bill_Account_TableViewCell"];
    [self.tableView setTableFooterView:self.tabelFoot];
    
}

- (void)initData
{
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++) {
        ZJMHostModel *model = [[ZJMHostModel alloc]init];
        [_dataArray addObject:model];
    }
    [_viewModel getTravelBilllModel];
    __weak typeof(self) weakSelf = self;
    [_viewModel.travelBillModel.loadSupport setDataRefreshblock:^{
        NSLog(@"%@",weakSelf.viewModel.travelBillModel);
        [weakSelf.tableView reloadData];
    }];
}

- (UIView *)tabelFoot
{
    if(!_tabelFoot)
    {
        UIView *tableFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(30))];
        tableFoot.backgroundColor = WHITECOLOR;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30, 0, 1.0, tableFoot.height)];
        line.backgroundColor = BLACKCOLOR;
        [tableFoot addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(line.right + 15, 5, DeviceWidth - 56, AUTO(20))];
        label.text = @"到此结束哦！";
        label.textColor = MORELESSBLACKCOLOR;
        label.font = FONT(AUTO(15.0));
        [tableFoot addSubview:label];
        return tableFoot;
    }
    return _tabelFoot;
}

#pragma mark -- TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0 || section == 1)
    {
        return 1;
    }
    return _viewModel.travelBillModel.consumeDetails.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0 || section == 1)
    {
        return AUTO(0);
    }else{
        return AUTO(25);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
        return 10;
    else if(section == 1)
        return 50;
        return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 1)
    {
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
        footView.backgroundColor = WHITECOLOR;

        UIButton  *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, footView.width, footView.height)];
        btn.titleLabel.font = FONT(AUTO(14.0));
        [btn setImage:IMAGE(@"zjmxiaofei") forState:0];
        [btn setTitle:@"消费明细" forState:0];
        [btn setTitleColor:BLACKCOLOR forState:0];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [footView addSubview:btn];

        return footView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0 || section == 1)
    {
        return nil;
    }
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(25))];
        headView.backgroundColor = WHITECOLOR;
        
        UIView *ballView = [[UIView alloc]initWithFrame:CGRectMake(24, 0, AUTO(12.0), AUTO(12.0))];
        LRViewBorderRadius(ballView, ballView.height / 2.0, 0, [UIColor clearColor]);
        ballView.backgroundColor = BLACKCOLOR;
        [headView addSubview:ballView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30, ballView.bottom, 1.0, AUTO(13.0))];
        line.backgroundColor = BLACKCOLOR;
        [headView addSubview:line];
        
        ballView.centerX = line.centerX;
        
        UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(ballView.right + 5, 0, DeviceWidth - (ballView.right + 5), AUTO(15))];
        sectionLabel.font = FONT(AUTO(13.0));
        sectionLabel.text = @"第一天 2016-09-10";
        sectionLabel.centerY = ballView.centerY;
        [headView addSubview:sectionLabel];
        return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        LBB_Tarvel_Bill_Free_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_Tarvel_Bill_Free_Cell"];
        cell.textLabel.text = @"消费总额";
        cell.freeMoney = _viewModel.travelBillModel.totalAmount;
        return cell;
    }else if(indexPath.section == 1){
        
            LBB_Travel_Bill_Account_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_Travel_Bill_Account_TableViewCell"];
            return cell;
    }else{
            LBB_Travel_Bill_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_Travel_Bill_Cell"];
            ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
            cell.selectionStyle = 0;
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            cell.model = _viewModel.travelBillModel.consumeDetails[indexPath.row];
            return cell;
        }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xuanzhong");
    if(indexPath.section == 1)
    {
        LBB_ShopRecoder_Controller *vc = [[LBB_ShopRecoder_Controller alloc]init];
        vc.dataModel = _viewModel.travelBillModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.section == 2)
    {
        if(_edit)
        {
            NSLog(@"");
            LBB_EditShopRecoder_Controller *vc = [[LBB_EditShopRecoder_Controller alloc]init];
            vc.model = _viewModel.travelBillModel.consumeDetails[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model;
    if (_viewModel.travelBillModel.consumeDetails.count) {
        model = _viewModel.travelBillModel.consumeDetails[indexPath.row];
    }
    if(indexPath.section == 0)
    {
        return 50;
    }
    if(indexPath.section == 1)
    {
        return 50;
    }
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_Travel_Bill_Cell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}



@end
