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
@property (nonatomic,strong) LBB_BalanceViewModel *viewModel;

@end

@implementation BalanceDetailViewController

- (void)dealloc
{
    self.viewModel = nil;
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
    self.viewModel = [[LBB_BalanceViewModel alloc] init];
    
    __weak typeof(self) temp = self;
    
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.viewModel getMyCreditDetail:YES];
    } footerRefreshDatablock:^{
        [temp.viewModel getMyCreditDetail:NO];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.banlanceArray];
    
    //刷新数据
    [self.viewModel getMyCreditDetail:YES];
    
    [self.viewModel.banlanceArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.banlanceArray];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.banlanceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"BalanceDetailViewCell" configuration:^(BalanceDetailViewCell *cell) {
        if ([indexPath row] < self.viewModel.banlanceArray.count) {
            LBB_BalanceDetailModel *detailModel = [self.viewModel.banlanceArray objectAtIndex:[indexPath row]];
            [self configCell:cell Model:detailModel];
        }
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
    if ([indexPath row] < self.viewModel.banlanceArray.count) {
        LBB_BalanceDetailModel *detailModel = [self.viewModel.banlanceArray objectAtIndex:[indexPath row]];
        [self configCell:cell Model:detailModel];
    }
  
    return cell;
}

- (void)configCell:(BalanceDetailViewCell*)cell Model:(LBB_BalanceDetailModel*)detailModel
{
    cell.describeLabel.text = detailModel.remark;
    cell.timeLabel.text = detailModel.createTime;
    cell.numLabel.text = detailModel.amount;
}

@end
