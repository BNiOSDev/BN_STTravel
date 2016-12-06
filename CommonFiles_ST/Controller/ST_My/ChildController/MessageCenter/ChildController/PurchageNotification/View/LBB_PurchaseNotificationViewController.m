//
//  LBB_PurchaseNotificationViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PurchaseNotificationViewController.h"
#import "UIImageView+WebCache.h"
#import "LBB_SquareNotificationViewCell.h"
#import "HMSegmentedControl.h"
#import "CommonFunc.h"
#import "LBB_PurchaseModel.h"

@interface LBB_PurchaseNotificationViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (nonatomic,strong) LBB_PurchaseViewModel *viewModel;

@end

@implementation LBB_PurchaseNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorBackground;
    self.tableView.backgroundColor = ColorBackground;
    self.tableViewTopConstraint.constant = 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  private 

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_SquareNotificationViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_SquareNotificationViewCell"];
    [self initDataSource];
}
- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_PurchaseViewModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    [self.tableView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getPurchaseDataArray:YES];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getPurchaseDataArray:NO];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.dataArray];
    
    [self.viewModel.dataArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.dataArray];
    
    //刷新数据
    [weakSelf.viewModel getPurchaseDataArray:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_SquareNotificationViewCell"
                                                 configuration:^(LBB_SquareNotificationViewCell *cell) {
                                                     if (indexPath.section < self.viewModel.dataArray.count) {
                                                         LBB_PurchaseModel *cellModel = self.viewModel.dataArray[indexPath.section];
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
        LBB_PurchaseModel *cellModel = self.viewModel.dataArray[section];
         timeLabel.text = cellModel.createtime;
    }
    timeLabel.backgroundColor = [UIColor clearColor];
    
    return timeLabel;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_SquareNotificationViewCell";
    LBB_SquareNotificationViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_SquareNotificationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    if (indexPath.section < self.viewModel.dataArray.count) {
        LBB_PurchaseModel *cellModel = self.viewModel.dataArray[indexPath.section];
        [self configCell:cell Model:cellModel];
    }
    
    return cell;
}

- (void)configCell:(LBB_SquareNotificationViewCell*)cell Model:(LBB_PurchaseModel*)cellModel
{
    cell.iconImgView.imageURL = cellModel.msg_image;
    cell.titleLabel.text = cellModel.title;
    cell.contentLabel.text = cellModel.msg_abstract;
    cell.dateLabel.text = cellModel.createtime;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
