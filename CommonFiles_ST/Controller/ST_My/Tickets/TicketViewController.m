//
//  TicketViewController.m
//  LUBABA
//
//  Created by Diana on 16/10/12.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "TicketViewController.h"
#import "TicketViewCell.h"

@interface TicketViewController ()
<UITableViewDataSource,
UITableViewDelegate,
TicketViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation TicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
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
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                     @"State" : @"待支付",
                                                                     @"GoogNum":@"共1件商品",
                                                                     @"TotalMonney":@"￥200",
                                                                     @"State":[NSNumber numberWithInt:0],
                                                                     @"GoodList" : [self goodList:1]},
                                                                    @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                      @"State" : @"待取票",
                                                                      @"GoogNum":@"共3件商品",
                                                                      @"TotalMonney":@"￥200",
                                                                      @"State":[NSNumber numberWithInt:1],
                                                                      @"GoodList" : [self goodList:2]},
                                                                   @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                     @"State" : @"待收货",
                                                                     @"GoogNum":@"共6件商品",
                                                                     @"TotalMonney":@"￥200",
                                                                     @"State":[NSNumber numberWithInt:2],
                                                                     @"GoodList" : [self goodList:3]},
                                                                   @{@"TicketNum": NSLocalizedString(@"123456",nil),
                                                                     @"State" : @"待评价",
                                                                     @"GoogNum":@"共3件商品",
                                                                     @"TotalMonney":@"￥200",
                                                                     @"State":[NSNumber numberWithInt:3],
                                                                     @"GoodList" : [self goodList:2]}
                                                                   ]];
    
    
}

- (NSArray*)goodList:(int)count
{
    NSMutableArray *goodArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < count; i++) {
        if (i%2 == 0) {
            [goodArray addObject:@{@"Title": NSLocalizedString(@"鼓浪屿",nil),
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
    return 120.f + goodList.count * 60.f;
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

#pragma mark - cell delegate
- (void)cellBtnClickDelegate:(NSDictionary*)cellInfo StateType:(StateType)type
{
    LBBLOG(@"\n 点击按钮");
}

@end
