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

@interface TicketViewController ()
<UITableViewDataSource,
UITableViewDelegate,
TicketFooterViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UIView *segmentBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;

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
    [self initSegmentControll];
    [self initTableview];
}

- (void)initSegmentControll
{
    self.tableViewTopConstraint.constant = self.segmentBgViewHeightConstraint.constant;
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[NSLocalizedString(@"全部", nil),
                                                                                               NSLocalizedString(@"待付款", nil),
                                                                                               NSLocalizedString(@"待取票", nil),
                                                                                               NSLocalizedString(@"待评价", nil),
                                                                                               NSLocalizedString(@"退款", nil)]];
    segmentedControl.selectionIndicatorHeight = 3.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:15.0],
                                             NSForegroundColorAttributeName:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]};
   
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [segmentedControl setFrame:CGRectMake(0, 0, DeviceWidth, self.segmentBgViewHeightConstraint.constant)];
    
    [segmentedControl addTarget:self
                         action:@selector(segmentedControlChangedValue:)
                        forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    [self.view bringSubviewToFront:self.lineView];
    
    switch (self.baseViewType) {
        case eTickets://查看全部-门票
            [segmentedControl setSelectedSegmentIndex:0];
            break;
        case eTicket_WaitPay: //我的门票_待付款
            [segmentedControl setSelectedSegmentIndex:1];
             break;
        case eTicket_WaitGetTicket: //我的门票_待取票
            [segmentedControl setSelectedSegmentIndex:2];
             break;
        case eTicket_WaitComment: //我的门票_待评价
            [segmentedControl setSelectedSegmentIndex:3];
             break;
        case eTicket_Refund: //我的门票_退款;
            [segmentedControl setSelectedSegmentIndex:4];
             break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

- (void)initTableview
{
    UINib *nib = [UINib nibWithNibName:@"TicketDetailViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TicketDetailViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initDataSourceWithType:self.baseViewType];
}

- (void)initDataSourceWithType:(NSInteger)stateType
{
    if (stateType == eTickets) {
        self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共1件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:eTicket_WaitPay],
                                                                         @"GoodList" : [self goodList:1]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:eTicket_WaitGetTicket],
                                                                         @"GoodList" : [self goodList:2]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共6件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:eTicket_WaitComment],
                                                                         @"GoodList" : [self goodList:3]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:eTicket_Refund],
                                                                         @"GoodList" : [self goodList:2]}
                                                                       ]];
    }else {
        self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共1件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:stateType],
                                                                         @"GoodList" : [self goodList:1]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:stateType],
                                                                         @"GoodList" : [self goodList:2]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共6件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:stateType],
                                                                         @"GoodList" : [self goodList:3]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInteger:stateType],
                                                                         @"GoodList" : [self goodList:2]}
                                                                       ]];
    }
}

- (NSArray*)goodList:(int)count
{
    NSMutableArray *goodArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        if (i%2 == 0) {
            [goodArray addObject:@{@"Title": NSLocalizedString(@"鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿",nil),
                                   @"Image" : @"19.pic.jpg",
                                   @"Type":@"成人票",
                                   @"Money" : @"￥58",
                                   @"Num":[NSString stringWithFormat:@"x%@",@(i+1)]}];
        }else {
           [goodArray addObject:@{@"Title": NSLocalizedString(@"中山街",nil),
                                  @"Image" : @"19.pic.jpg",
                                  @"Type":@"儿童票",
                                  @"Money" : @"￥29",
                                  @"Num":[NSString stringWithFormat:@"x%@",@(i+1)]}];
        }
    }
    return goodArray;
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
         NSDictionary *cellDict = [self getCellInfo:indexPath];
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
    
    NSDictionary *cellDict = [self getCellInfo:indexPath];
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

- (void)showTicketDetailView:(NSDictionary*)ticketInfo
{
    LBB_OrderWaitPayViewController *vc = [[LBB_OrderWaitPayViewController alloc] init];

    NSInteger ticketState = [[ticketInfo objectForKey:@"TicketState"] integerValue];
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

- (NSDictionary*)getCellInfo:(NSIndexPath*)indexPath
{
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
    NSArray *goodList = [cellDict objectForKey:@"GoodList"];
    if (goodList.count > indexPath.row) {
        NSDictionary *cellDict =  [goodList objectAtIndex:indexPath.row];
        return  cellDict;
    }
    return nil;
}

- (NSInteger)numberOfRows:(NSInteger)section
{
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:section];
    NSArray *goodList = [cellDict objectForKey:@"GoodList"];
    return goodList.count;
}

#pragma mark - 取消订单 立即支付 立即取票 查看详情
- (void)cellBtnClickDelegate:(NSDictionary*)cellInfo
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
