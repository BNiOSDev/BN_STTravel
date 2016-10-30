//
//  TicketViewController.m
//  LUBABA
//
//  Created by Diana on 16/10/12.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "TicketViewController.h"
#import "TicketViewCell.h"
#import "HMSegmentedControl.h"
#import "UITableView+FDTemplateLayoutCell.h"


@interface TicketViewController ()
<UITableViewDataSource,
UITableViewDelegate,
TicketViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UIView *segmentBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSegmentControll];
    [self initData];
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
            [segmentedControl setSelectedSegmentIndex:3];
             break;
        case eTicket_WaitComment: //我的门票_待评价
            [segmentedControl setSelectedSegmentIndex:4];
             break;
        case eTicket_Refund: //我的门票_退款;
            [segmentedControl setSelectedSegmentIndex:5];
             break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

- (void)initData
{
    UINib *nib = [UINib nibWithNibName:@"TicketViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TicketViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initDataSourceWithType:eTickets];
}

- (void)initDataSourceWithType:(NSInteger)stateType
{
    if (stateType == eTickets) {
        self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共1件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:eTicket_WaitPay],
                                                                         @"GoodList" : [self goodList:1]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:eTicket_WaitGetTicket],
                                                                         @"GoodList" : [self goodList:2]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共6件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:eTicket_WaitComment],
                                                                         @"GoodList" : [self goodList:3]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:eTicket_Refund],
                                                                         @"GoodList" : [self goodList:2]}
                                                                       ]];
    }else {
        self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共1件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:stateType],
                                                                         @"GoodList" : [self goodList:1]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:stateType],
                                                                         @"GoodList" : [self goodList:2]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共6件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:stateType],
                                                                         @"GoodList" : [self goodList:3]},
                                                                       @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                         @"GoogNum":@"共3件商品",
                                                                         @"TotalMonney":@"￥200",
                                                                         @"TicketState":[NSNumber numberWithInt:stateType],
                                                                         @"GoodList" : [self goodList:2]}
                                                                       ]];
    }
}

- (NSArray*)goodList:(int)count
{
    NSMutableArray *goodArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        if (i%2 == 0) {
            [goodArray addObject:@{@"Title": NSLocalizedString(@"鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿鼓浪屿",nil),
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
    return 1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellDict = (NSDictionary*)[self.dataSourceArray objectAtIndex:indexPath.section];
    NSArray *goodList = [cellDict objectForKey:@"GoodList"];
    CGFloat detailHeight = 0.f;
    for (NSDictionary *detailDict in goodList) {
        detailHeight +=  ticketDetailCellHeight([detailDict objectForKey:@"Title"], [detailDict objectForKey:@"Type"]);
    }
    return 120.f + detailHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.001f;
    }
    
    return 25.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TicketViewCell";
    TicketViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TicketViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    cell.mDelegate = self;
    [cell setCellInfo:cellDict];
    if ([indexPath section] == 0) {
        cell.topLine.hidden = YES;
    }else {
       cell.topLine.hidden = NO;
    }
    return cell;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    aaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaTableViewCell" forIndexPath:indexPath];
//    
//    if (!cell) {
//        cell =  [[aaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaTableViewCell"];
//        
//    }
//    [cell.label setText:@"上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑"];
//    // Configure the cell...
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return [tableView fd_heightForCellWithIdentifier:@"aaTableViewCell" configuration:^(aaTableViewCell *cell) {
//        
//        [cell.label setText:@"上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑上电视汳䝷䀑汳䝷䀑"];
//        
//    }];
//}


#pragma mark - cell delegate
- (void)cellBtnClickDelegate:(NSDictionary*)cellInfo
                   StateType:(MineBaseViewType)type
             TicketClickType:(TicketClickType)clickType
{
    NSLog(@"type = %d,clickType = %d",type,clickType);
}

- (void)ticketDetailDelegate:(NSDictionary*)cellInfo
                   StateType:(MineBaseViewType)type
             TicketClickType:(TicketClickType)clickType
{
    NSLog(@"type = %d,clickType = %d",type,clickType);
}

#pragma mark - segmentedControlChangedValue
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentControll
{
    NSInteger selectIndex = segmentControll.selectedSegmentIndex;
    switch (self.baseViewType) {
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

@end
