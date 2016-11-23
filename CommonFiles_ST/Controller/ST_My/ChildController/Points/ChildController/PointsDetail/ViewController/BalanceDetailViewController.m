//
//  BalanceDetailViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "BalanceDetailViewController.h"
#import "BalanceDetailViewCell.h"
#import "LBB_BalanceDetailModel.h"

@interface BalanceDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *dataSourceArray;
@property (nonatomic,strong) LBB_BalanceDataModel *balanceModel;

@end

@implementation BalanceDetailViewController

- (void)dealloc
{
    self.balanceModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  ePointDetail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"BalanceDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BalanceDetailViewCell"];
    self.balanceModel = [[LBB_BalanceDataModel alloc] init];
    self.dataSourceArray = [self.balanceModel getData];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"BalanceDetailViewCell" configuration:^(BalanceDetailViewCell *cell) {
        LBB_BalanceDetailModel *detailModel = [self.dataSourceArray objectAtIndex:[indexPath row]];
        [self configCell:cell Model:detailModel];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BalanceDetailViewCell";
    BalanceDetailViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[BalanceDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView =  nil;
    LBB_BalanceDetailModel *detailModel = [self.dataSourceArray objectAtIndex:[indexPath row]];
    [self configCell:cell Model:detailModel];
    return cell;
}

- (void)configCell:(BalanceDetailViewCell*)cell Model:(LBB_BalanceDetailModel*)detailModel
{
    cell.describeLabel.text = detailModel.content;
    cell.timeLabel.text = detailModel.dateStr;
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",detailModel.num];
}

@end
