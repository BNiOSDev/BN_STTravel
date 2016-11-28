//
//  LBB_FollowViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FollowViewController.h"
#import "LBB_FollowModel.h"
#import "LBB_FollowViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Header.h"

#define FllowTableViewCell @"FllowTableViewCell"


@interface LBB_FollowViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong)LBB_FollowViewModel *viewModel;

@end

@implementation LBB_FollowViewController

- (void)dealloc
{
    self.viewModel = nil;
}

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
    _mTableView.height = _mTableView.height - 40 - 64;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = ColorBackground;
    
    UINib *nib = [UINib nibWithNibName:@"LBB_FollowViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:FllowTableViewCell];
    
    [self.view  addSubview:_mTableView];
    
}
- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_FollowViewModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    [self.mTableView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getDataList:weakSelf.followType IsClear:YES];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getDataList:weakSelf.followType IsClear:YES];
    }];
    
    //设置绑定数组
    [self.mTableView setTableViewData:self.viewModel.dataArray];
    
    
    [self.viewModel.dataArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.mTableView loadData:self.viewModel.dataArray];
    
    //刷新数据
    [weakSelf.viewModel getDataList:weakSelf.followType IsClear:YES];
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:FllowTableViewCell configuration:^(LBB_FollowViewCell *cell) {
        if (indexPath.row < self.viewModel.dataArray.count) {
            cell.model = self.viewModel.dataArray[indexPath.row];
        } 
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_FollowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FllowTableViewCell];
   
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    if (indexPath.row < self.viewModel.dataArray.count) {
        cell.model = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
