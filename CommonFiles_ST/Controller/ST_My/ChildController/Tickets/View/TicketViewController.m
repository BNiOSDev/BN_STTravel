//
//  TicketViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/12.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "TicketViewController.h"
#import "HMSegmentedControl.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TicketDetailViewCell.h"
#import "LBB_TicketFooterView.h"
#import "LBB_TicketHeaderView.h"
#import "LBB_OrderWaitPayViewController.h"
#import "LBB_TicketModel.h"

@interface TicketViewController ()
<UITableViewDataSource,
UITableViewDelegate,
TicketFooterViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (strong,nonatomic) LBB_TicketModel *ticketModel;

@end

@implementation TicketViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadViewControllerWithInfo:) name:@"TicketCommentNotification" object:nil];
}

- (void)buildControls
{
    [self initTableview];
}

#pragma mark - public
- (void)reloadAllData
{
    
}

//初始化数据类型
- (void)initDataSourceWithType:(NSInteger)stateType
{
    if (!self.ticketModel) {
        self.ticketModel = [[LBB_TicketModel alloc] init];
    }
    self.dataSourceArray = [self.ticketModel getDataWithType:stateType];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

- (void)initTableview
{
    self.tableViewTopConstraint.constant = 0.f;
    UINib *nib = [UINib nibWithNibName:@"TicketDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TicketDetailViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initDataSourceWithType:self.baseViewType];
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRows:section];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:@"TicketDetailViewCell" configuration:^(TicketDetailViewCell *cell) {
         LBB_TicketModelDetail *cellDict = [self getCellInfo:indexPath];
         [cell setCellInfo:cellDict];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 85.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TicketDetailViewCell";
    TicketDetailViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TicketDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    
    LBB_TicketModelDetail *cellDict = [self getCellInfo:indexPath];
    if (cellDict) {
       [cell setCellInfo:cellDict];
    }
    
    if (indexPath.row == [self numberOfRows:indexPath.section] - 1 ) {
        cell.lineView.hidden = YES;
    }else {
        cell.lineView.hidden = NO;
    }
    return cell;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UINib *nib = [UINib nibWithNibName:@"LBB_TicketHeaderView" bundle:nil];
    NSArray *viewArray = [nib instantiateWithOwner:nil options:nil];
    LBB_TicketHeaderView *headView = [viewArray firstObject];
    headView.frame = CGRectMake(0, 0, DeviceWidth, 44.f);
    headView.cellInfo = [self.dataSourceArray objectAtIndex:section];
    return headView;
    
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UINib *nib = [UINib nibWithNibName:@"LBB_TicketFooterView" bundle:nil];
    NSArray *viewArray = [nib instantiateWithOwner:nil options:nil];
    LBB_TicketFooterView *footView = [viewArray firstObject];
    footView.frame = CGRectMake(0, 0, DeviceWidth, 85.f);
    if(section == self.dataSourceArray.count - 1){
        footView.bgView.hidden = YES;
    }
    footView.mDelegate = self;
    footView.cellInfo = [self.dataSourceArray objectAtIndex:section];
    return footView;
    
}

#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showTicketDetailView:[self.dataSourceArray objectAtIndex:indexPath.row]];
}

- (void)showTicketDetailView:(LBB_TicketModelData*)ticketInfo
{
    LBB_OrderWaitPayViewController *vc = [[LBB_OrderWaitPayViewController alloc] init];

    NSInteger ticketState = ticketInfo.ticketState;
    switch (ticketState) {
        case eTicket_WaitPay://我的门票_待付款
            vc.ticketStatus = LBBPoohTicketStatusWaitPay;
            break;
        case eTicket_WaitGetTicket://我的门票_待取票
            vc.ticketStatus = LBBPoohTicketStatusWaitCollect;
            break;
        case eTicket_WaitComment://我的门票_待评价
            vc.ticketStatus = LBBPoohTicketStatusCollected;
            break;
        case eTicket_Refund://我的门票_退款
            vc.ticketStatus = LBBPoohTicketStatusRefunded;
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc  animated:YES];
}

#pragma mark - private cell Info

- (LBB_TicketModelDetail*)getCellInfo:(NSIndexPath*)indexPath
{
    if (indexPath.section < self.dataSourceArray.count) {
         LBB_TicketModelData *data = [self.dataSourceArray objectAtIndex:indexPath.section];
        if (indexPath.row < data.detailArray.count) {
            return [data.detailArray objectAtIndex:indexPath.row];
        }
    }
   
    return nil;
}

- (NSInteger)numberOfRows:(NSInteger)section
{
    LBB_TicketModelData *data = [self.dataSourceArray objectAtIndex:section];
    return data.detailArray.count;
}

#pragma mark - 取消订单 立即支付 立即取票 查看详情
- (void)cellBtnClickDelegate:(LBB_TicketModelData*)cellInfo
                   StateType:(MineBaseViewType)type
             TicketClickType:(TicketClickType)clickType
{
    switch (clickType) {
        case eCancelTicket: //取消订单
        {
            
        }
            break;
       case eTicketPay: //立即支付
       case eGetTicket://立即取票
       case eShowDetail://查看详情
        {
            [self showTicketDetailView:cellInfo];
        }
            break;
        case eComment://立即评价
        {
            [self performSegueWithIdentifier:@"LBB_TicketCommentViewController" sender:nil];
        }
            break;
            
        default:
            break;
    }
   
   NSLog(@"%@,%@",@(type),@(clickType));
}

#pragma mark - segmentedControlChangedValue
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentControll
{
    NSInteger selectIndex = segmentControll.selectedSegmentIndex;
    switch (selectIndex) {
        case 0://查看全部-门票
           [self initDataSourceWithType:eTickets];
            break;
        case 1: //我的门票_待付款
            [self initDataSourceWithType:eTicket_WaitPay];
            break;
        case 2: //我的门票_待取票
            [self initDataSourceWithType:eTicket_WaitGetTicket];
            break;
        case 3: //我的门票_待评价
            [self initDataSourceWithType:eTicket_WaitComment];
            break;
        case 4: //我的门票_退款;
            [self initDataSourceWithType:eTicket_Refund];
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

#pragma mark - 被通知所调用的函数
- (void)loadViewControllerWithInfo:(id)info
{
//    NSNotification *notification = info;
    
    [self performSegueWithIdentifier:@"LBB_TicketCommentViewController" sender:nil];
    
}
@end
