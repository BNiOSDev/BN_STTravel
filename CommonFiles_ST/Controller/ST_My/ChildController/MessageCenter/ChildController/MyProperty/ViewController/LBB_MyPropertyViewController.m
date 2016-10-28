//
//  LBB_MyPropertyViewController.m
//  ST_Travel
//  我的资产
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyPropertyViewController.h"
#import "LBB_MyPropertyViewCell.h"

@interface LBB_MyPropertyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation LBB_MyPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buildControls
{
    [self setTableViewNib];
    
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@{@"StateType":@"提现申请",
                                                                     @"StateDate":@"2016-9-1",
                                                                     @"MoneyNum":@"￥1211.1",
                                                                     @"ExtractBank":@"中国建设银行（1234)",
                                                                     @"ExtractBeginDate":@"2016-07-17 21:21:21",
                                                                     @"ExtractEndDate":@"2016-07-18 21:21:21"
                                                                     },
                                                                   @{@"StateType":@"提现申请",
                                                                     @"StateDate":@"2016-9-1",
                                                                     @"MoneyNum":@"￥1211.1",
                                                                     @"ExtractBank":@"中国建设银行（1234)",
                                                                     @"ExtractBeginDate":@"2016-07-17 21:21:21",
                                                                     @"ExtractEndDate":@"2016-07-18 21:21:21"
                                                                     },
                                                                   @{@"StateType":@"提现申请",
                                                                     @"StateDate":@"2016-9-1",
                                                                     @"MoneyNum":@"￥1211.1",
                                                                     @"ExtractBank":@"中国建设银行（1234)",
                                                                     @"ExtractBeginDate":@"2016-07-17 21:21:21",
                                                                     @"ExtractEndDate":@"2016-07-18 21:21:21"
                                                                     },
                                                                   @{@"StateType":@"提现申请",
                                                                     @"StateDate":@"2016-9-1",
                                                                     @"MoneyNum":@"￥1211.1",
                                                                     @"ExtractBank":@"中国建设银行（1234)",
                                                                     @"ExtractBeginDate":@"2016-07-17 21:21:21",
                                                                     @"ExtractEndDate":@"2016-07-18 21:21:21"
                                                                     },
                                                                   @{@"StateType":@"提现申请",
                                                                     @"StateDate":@"2016-9-1",
                                                                     @"MoneyNum":@"￥1211.1",
                                                                     @"ExtractBank":@"中国建设银行（1234)",
                                                                     @"ExtractBeginDate":@"2016-07-17 21:21:21",
                                                                     @"ExtractEndDate":@"2016-07-18 21:21:21"
                                                                     },
                                                                   ]];
}

- (void)setTableViewNib
{
    UINib *nib = [UINib nibWithNibName:@"LBB_MyPropertyViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_MyPropertyViewCell"];
}


#pragma mark - segmentedControlChangedValue


#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_PromotionsViewCell"
                                                 configuration:^(LBB_MyPropertyViewCell *cell) {
                                                     NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [self configCell:cell Model:cellDict];
                                                 }];
    return height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_MyPropertyViewCell";
    LBB_MyPropertyViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_MyPropertyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    [self configCell:cell Model:cellDict];
    
    return cell;
}

- (void)configCell:(LBB_MyPropertyViewCell*)cell Model:(NSDictionary*)cellDict
{
    cell.stateLabel.text  = [cellDict objectForKey:@"StateType"];
    cell.stateDateLabel.text = [cellDict objectForKey:@"StateDate"];
    cell.monyeNumLabel.text = [cellDict objectForKey:@"MoneyNum"];
    cell.extractBankLabel.text = [cellDict objectForKey:@"ExtractBank"];
    cell.extractBeginDateLabel.text = [cellDict objectForKey:@"ExtractEndDate"];
    cell.extractEndDateLabel.text = [cellDict objectForKey:@"ExtractEndDate"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
