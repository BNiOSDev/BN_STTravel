//
//  LBB_PromotionsViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PromotionsViewController.h"
#import "LBB_PromotionsViewCell.h"
#import "LBB_PromotionModel.h"


@interface LBB_PromotionsViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) LBB_PromotionViewModel *viewModel;

@end

@implementation LBB_PromotionsViewController

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
    UINib *nib = [UINib nibWithNibName:@"LBB_PromotionsViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_PromotionsViewCell"];
    [self initDataSource];
}

- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_PromotionViewModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    [self.tableView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getPromotionDataArray:YES];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getPromotionDataArray:NO];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.dataArray];
    
    
    [self.viewModel.dataArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.dataArray];
    
    //刷新数据
    [weakSelf.viewModel getPromotionDataArray:YES];
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
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_PromotionsViewCell"
                                                 configuration:^(LBB_PromotionsViewCell *cell) {
                                                     if (indexPath.section < self.viewModel.dataArray.count) {
                                                         LBB_PromotionModel *cellModel = self.viewModel.dataArray[indexPath.section];
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
        LBB_PromotionModel *cellModel = self.viewModel.dataArray[section];
        timeLabel.text = cellModel.publishTime;
    }
   
    timeLabel.backgroundColor = [UIColor clearColor];

    return timeLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_PromotionsViewCell";
    LBB_PromotionsViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_PromotionsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    if (indexPath.section < self.viewModel.dataArray.count) {
        LBB_PromotionModel *cellModel = self.viewModel.dataArray[indexPath.section];
         [self configCell:cell Model:cellModel];
    }
    
    return cell;
}

- (void)configCell:(LBB_PromotionsViewCell*)cell Model:(LBB_PromotionModel*)cellModel
{
    cell.iconImgView.imageURL = cellModel.imageUrl;
    cell.titleLabel.text = cellModel.title;
    cell.contentLabel.text = cellModel.describe;
    if (cellModel.isEnd) {
        cell.stateLabel.text = @"活 动 结 束";
    }else {
        cell.stateLabel.text = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
