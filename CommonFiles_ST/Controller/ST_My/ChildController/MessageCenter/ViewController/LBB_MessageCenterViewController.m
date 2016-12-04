//
//  LBB_MessageCenterViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MessageCenterViewController.h"
#import "LBB_MessageCenterViewCell.h"
#import "LBB_PromotionsViewController.h"
#import "LBB_CustomerViewController.h"
#import "LBB_PurchaseModuleViewController.h"
#import "LBB_MyPropertyViewController.h"
#import "LBB_MessageSquareViewController.h"
#import "LBB_MessageCenterModel.h"

@interface LBB_MessageCenterViewController ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@property (nonatomic,strong) LBB_MessageCenterModel *viewModel;

@end

@implementation LBB_MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eMessageCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_MessageCenterViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_MessageCenterViewCell"];
    
    if (!self.viewModel) {
        self.viewModel = [[LBB_MessageCenterModel alloc] init];
    }
    __weak typeof (self) weakSelf = self;
    [self.viewModel.loadSupport setDataRefreshblock:^{
        [weakSelf initDataSource];
    }];
    [self.viewModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        
    }];
    [self.viewModel getMessage];
   
}
- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)initDataSource
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if ([self.viewModel.onsaleTitle length]) {
        [array addObject:@{@"InfoType":[NSNumber numberWithInt:ePromotions],
                          @"Content":self.viewModel.onsaleTitle,
                          @"Date":self.viewModel.onsaleTime
                           }];
    }
    NSDate *date = [NSDate date];
    
    [array addObject:@{@"InfoType":[NSNumber numberWithInt:eCustomer],
                       @"Content":@"点击查看您的最新客服会话记录",
                       @"Date":[self stringFromDate:date]
                       }];
    
    if ([self.viewModel.buyTitle length]) {
        [array addObject:@{@"InfoType":[NSNumber numberWithInt:ePromotions],
                           @"Content":self.viewModel.buyTitle,
                           @"Date":self.viewModel.buyTime
                           }];
    }
    
    if ([self.viewModel.onsaleTitle length]) {
        [array addObject:@{@"InfoType":[NSNumber numberWithInt:ePromotions],
                           @"Content":self.viewModel.onsaleTitle,
                           @"Date":self.viewModel.onsaleTime
                           }];
    }
    
    if ([self.viewModel.noticeTitle length]) {
        [array addObject:@{@"InfoType":[NSNumber numberWithInt:ePromotions],
                           @"Content":self.viewModel.noticeTitle,
                           @"Date":self.viewModel.noticeTime
                           }];
    }
    
    if ([self.viewModel.squareName length]) {
        [array addObject:@{@"InfoType":[NSNumber numberWithInt:ePromotions],
                           @"Content":self.viewModel.squareName,
                           @"Date":self.viewModel.squareTime
                           }];
    }
  
    if (!self.dataSourceArray) {
        self.dataSourceArray = [[NSMutableArray alloc] initWithCapacity:0];
     }
    [self.dataSourceArray removeAllObjects];
    [self.dataSourceArray addObjectsFromArray:array];
    [self.tableView reloadData];
    
//    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@{@"InfoType":[NSNumber numberWithInt:ePromotions],
//                                                                     @"Content":@"喜迎国庆,全场8折优惠（最新活动）",
//                                                                     @"Date":@"07-17"
//                                                                     },
//                                                                   @{@"InfoType":[NSNumber numberWithInt:eCustomer],
//                                                                     @"Content":@"点击查看您的最新客服会话记录",
//                                                                     @"Date":@"07-17"
//                                                                     },
//                                                                   @{@"InfoType":[NSNumber numberWithInt:ePurchageNotifion],
//                                                                     @"Content":@"已发货，您2016-07-16购买黑蒜...",
//                                                                     @"Date":@"07-17",
//                                                                     @"Image":@""
//                                                                     },
//                                                                   @{@"InfoType":[NSNumber numberWithInt:eNotice],
//                                                                     @"Content":@"提现成功，您2016-07-12申请100...",
//                                                                     @"Date":@"07-17"
//                                                                     },
//                                                                   @{@"InfoType":[NSNumber numberWithInt:eSquareTravel],
//                                                                     @"Content":@"您发布的游记XX被点赞了，快去看...",
//                                                                     @"Date":@"07-17"
//                                                                     }
//                                                                   ]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_MessageCenterViewCell"
                                                 configuration:^(LBB_MessageCenterViewCell *cell) {
                                                     if (indexPath.row < self.dataSourceArray.count) {
                                                         NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                         [self configCell:cell Model:cellDict];
                                                     }
                                                 }];
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_MessageCenterViewCell";
    LBB_MessageCenterViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_MessageCenterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    if (indexPath.row < self.dataSourceArray.count) {
        NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
        [self configCell:cell Model:cellDict];
    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:indexPath.row];
    NSInteger infoType = [[cellDict objectForKey:@"InfoType"] intValue];
    [self didSelectWithType:infoType];
}

- (void)configCell:(LBB_MessageCenterViewCell*)cell Model:(NSDictionary*)cellDict
{
    NSInteger infoType = [[cellDict objectForKey:@"InfoType"] intValue];
    NSString *imageName = nil;
    NSString *titleStr = nil;
    switch (infoType) {
        case ePromotions://优惠促销
        {
            titleStr = TEXT(@"优惠促销");
            imageName = @"优惠促销.png"; //icon 本地图标
        }
            break;
        case eCustomer://我的客服
        {
            titleStr = TEXT(@"我的客服");
            imageName = @"客服.png"; //icon 本地图标
        }
            break;
        case ePurchageNotifion://购买通知
        {
            titleStr = TEXT(@"购买通知");
            imageName = @"购买通知.png"; //icon 本地图标
        }
            break;
        case eNotice://鹭爸公告
        {
            titleStr = TEXT(@"鹭爸公告");
            imageName = @"鹭爸公告.png"; //icon 本地图标
        }
            break;
        case eSquareTravel://广场游记
        {
            titleStr = TEXT(@"广场游记");
            imageName = @"广场游记.png"; //icon 本地图标
        }
            break;
        default:
            break;
    }
    
    if (imageName) {
        cell.iconImgView.image = IMAGE(imageName);
    }
    
    cell.titleLabel.text = titleStr;
    cell.contentLabel.text = [cellDict objectForKey:@"Content"];
    cell.dateLabel.text = [cellDict objectForKey:@"Date"];
}


- (void)didSelectWithType:(NSInteger)infoType
{
    switch (infoType) {
        case ePromotions://优惠促销
        {
            [self performSegueWithIdentifier:@"LBB_PromotionsViewController" sender:[NSNumber numberWithInt:ePromotions]];
        }
            break;
        case eCustomer://我的客服
        {
            [self performSegueWithIdentifier:@"LBB_CustomerViewController" sender:[NSNumber numberWithInt:eCustomer]];
        }
            break;
        case ePurchageNotifion://购买通知
        {
            LBB_PurchaseModuleViewController *vc = [[LBB_PurchaseModuleViewController alloc] init];
            [self.navigationController pushViewController:vc  animated:YES];
        }
            break;
        case eNotice://鹭爸公告
        {
            [self performSegueWithIdentifier:@"LBB_NoticeViewController" sender:[NSNumber numberWithInt:eNotice]];
        }
            break;
        case eSquareTravel://广场游记
        {
            LBB_MessageSquareViewController *messageSquareVC = [[LBB_MessageSquareViewController alloc] init];
            [self.navigationController pushViewController:messageSquareVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *dstVC = segue.destinationViewController;;
    if ([dstVC isKindOfClass:NSClassFromString(@"MineBaseViewController")]) {
        if (sender && [sender isKindOfClass:[NSNumber class]]) {
            MineBaseViewController *baseVC = (MineBaseViewController*)dstVC;
            baseVC.baseViewType = [(NSNumber*)sender intValue];
        }
    }
    if ([dstVC isKindOfClass:NSClassFromString(@"LBB_PromotionsViewController")]) { //优惠促销
        
    }else if([dstVC isKindOfClass:NSClassFromString(@"LBB_CustomerViewController")]) {//我的客服
        
    }else if([dstVC isKindOfClass:NSClassFromString(@"LBB_MyPropertyViewController")]) {//我的资产
        
    }
}

@end
