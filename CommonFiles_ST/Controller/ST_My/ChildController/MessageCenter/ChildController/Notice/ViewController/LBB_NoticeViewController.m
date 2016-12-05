//
//  LBB_NoticeViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NoticeViewController.h"
#import "LBB_NoticeViewCell.h"
#import "LBB_NoticeModel.h"
#import "LBB_WebViewController.h"
#import "LBB_NoticeDetailViewController.h"

@interface LBB_NoticeViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) LBB_NoticeViewModel *viewModel;

@end

@implementation LBB_NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorBackground;
    self.tableView.backgroundColor = ColorBackground;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_NoticeViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_NoticeViewCell"];
    [self initDataSource];
}

- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_NoticeViewModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    [self.tableView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getNoticeDataArray:YES];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getNoticeDataArray:NO];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.dataArray];
    
    
    [self.viewModel.dataArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.dataArray];
    
    //刷新数据
    [weakSelf.viewModel getNoticeDataArray:YES];
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_NoticeViewCell"
                                                 configuration:^(LBB_NoticeViewCell *cell) {
                                                     if (indexPath.section < self.viewModel.dataArray.count) {
                                                         LBB_NoticeModel *cellModel = self.viewModel.dataArray[indexPath.section];
                                                         [self configCell:cell Model:cellModel];
                                                     }
                                                 }];
    return height;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,DeviceWidth, 30.f)];
    timeLabel.textColor = ColorLightGray;
    timeLabel.font = Font12;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    if (section < self.viewModel.dataArray.count) {
         LBB_NoticeModel *cellModel = self.viewModel.dataArray[section];
         timeLabel.text = cellModel.createTime;
    }
   
    timeLabel.backgroundColor = [UIColor clearColor];
    
    return timeLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_NoticeViewCell";
    LBB_NoticeViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_NoticeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    if (indexPath.section < self.viewModel.dataArray.count) {
        LBB_NoticeModel *cellModel = self.viewModel.dataArray[indexPath.section];
        [self configCell:cell Model:cellModel];
    }
    
    
    return cell;
}

- (void)configCell:(LBB_NoticeViewCell*)cell Model:(LBB_NoticeModel*)cellModel
{
    cell.titleLabel.text = cellModel.title;
    cell.dateLabel.text = cellModel.createTime;
    cell.contentLabel.text = cellModel.content;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.viewModel.dataArray.count) {
        LBB_NoticeModel *cellModel = self.viewModel.dataArray[indexPath.section];
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
        LBB_NoticeDetailViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_NoticeDetailViewController"];
        vc.baseViewType = eNoticeDetail;
        vc.viewModel = cellModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
