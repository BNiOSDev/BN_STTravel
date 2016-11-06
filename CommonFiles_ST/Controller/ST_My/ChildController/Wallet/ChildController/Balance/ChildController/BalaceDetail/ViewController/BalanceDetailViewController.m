//
//  BalanceDetailViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "BalanceDetailViewController.h"
#import "BalanceDetailViewCell.h"

@interface BalanceDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation BalanceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  eBalanceDetail;
    [self initData];
}

#pragma mark - private
- (void)initData
{
    UINib *nib = [UINib nibWithNibName:@"BalanceDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BalanceDetailViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //测试数据
    if (self.showType == BalanceDetailType) {
         self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                               @{@"Describe": NSLocalizedString(@"余额提现",nil),
                                                                 @"Time" : @"2016-09-08 11:11:11",
                                                                 @"Num":@"+1000"},
                                                               @{@"Describe": NSLocalizedString(@"余额提现",nil),
                                                                 @"Time" : @"2016-09-08 12:11:11",
                                                                 @"Num":@"-1000"},
                                                               @{@"Describe": NSLocalizedString(@"余额提现",nil),
                                                                 @"Time" : @"2016-09-08 13:11:11",@"Num":@"-1000"},
                                                               @{@"Describe": NSLocalizedString(@"余额提现",nil),
                                                                 @"Time" : @"2016-09-08 14:11:11",
                                                                 @"Num":@"+1000"},
                                                               @{@"Describe": NSLocalizedString(@"余额提现",nil),
                                                                 @"Time" : @"2016-09-08 15:11:11",
                                                                 @"Num":@"+1000"}
                                                               ]];
        

    }else if(self.showType == PointsDetailType) {
        self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                       @{@"Describe": NSLocalizedString(@"兑换积分100积分",nil),
                                                                         @"Time" : @"2016-09-08 11:11:11",
                                                                         @"Num":@"-100"},
                                                                       @{@"Describe": NSLocalizedString(@"收到一个赞，收入100积分",nil),
                                                                         @"Time" : @"2016-09-08 12:11:11",
                                                                         @"Num":@"+100"},
                                                                       @{@"Describe": NSLocalizedString(@"兑换积分100积分",nil),
                                                                          @"Time" : @"2016-09-08 13:11:11",
                                                                          @"Num":@"-100"},
                                                                       @{@"Describe": NSLocalizedString(@"兑换积分100积分",nil),
                                                                         @"Time" : @"2016-09-08 13:11:11",
                                                                         @"Num":@"-100"},
                                                                        @{@"Describe": NSLocalizedString(@"兑换积分100积分",nil),
                                                                          @"Time" : @"2016-09-08 13:11:11",
                                                                          @"Num":@"-100"},
                                                                        @{@"Describe": NSLocalizedString(@"兑换积分100积分",nil),
                                                                          @"Time" : @"2016-09-08 13:11:11",
                                                                          @"Num":@"-100"},
                                                                        @{@"Describe": NSLocalizedString(@"兑换积分100积分",nil),
                                                                          @"Time" : @"2016-09-08 13:11:11",
                                                                          @"Num":@"-100"}
                                                                       ]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
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
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[BalanceDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.describeLabel.text = [cellDict objectForKey:@"Describe"];
    cell.timeLabel.text = [cellDict objectForKey:@"Time"];
    cell.numLabel.text = [cellDict objectForKey:@"Num"];
    cell.accessoryView =  nil;
    
    return cell;
}

@end
