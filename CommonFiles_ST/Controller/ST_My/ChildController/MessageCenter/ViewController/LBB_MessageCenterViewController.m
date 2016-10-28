//
//  LBB_MessageCenterViewController.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MessageCenterViewController.h"
#import "LBB_MessageCenterViewCell.h"
#import "LBB_PromotionsViewController.h"
#import "LBB_CustomerViewController.h"
#import "LBB_PurchaseNotificationViewController.h"
#import "LBB_MyPropertyViewController.h"

@interface LBB_MessageCenterViewController ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSourceArray;

@end

@implementation LBB_MessageCenterViewController

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
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@{@"InfoType":[NSNumber numberWithInt:ePromotions],
                                                                    @"Content":@"喜迎国庆,全场8折优惠（最新活动）",
                                                                    @"Date":@"07-17"
                                                                    },
                                                                  @{@"InfoType":[NSNumber numberWithInt:eCustomer],
                                                                    @"Content":@"点击查看您的最新客服会话记录",
                                                                    @"Date":@"07-17"
                                                                    },
                                                                  @{@"InfoType":[NSNumber numberWithInt:ePurchageNotifion],
                                                                    @"Content":@"已发货，您2016-07-16购买黑蒜...",
                                                                    @"Date":@"07-17"
                                                                    },
                                                                  @{@"InfoType":[NSNumber numberWithInt:eMyProperty],
                                                                    @"Content":@"提现成功，您2016-07-12申请100...",
                                                                    @"Date":@"07-17"
                                                                    },
                                                                  @{@"InfoType":[NSNumber numberWithInt:eSquareTravel],
                                                                    @"Content":@"您发布的游记XX被点赞了，快去看...",
                                                                    @"Date":@"07-17"
                                                                    }
                                                                  ]];
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
                                                     NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [self configCell:cell Model:cellDict];
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
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_MessageCenterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    [self configCell:cell Model:cellDict];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
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
            imageName = @""; //icon 本地图标
        }
            break;
        case eCustomer://我的客服
        {
            titleStr = TEXT(@"我的客服");
            imageName = @""; //icon 本地图标
        }
            break;
        case ePurchageNotifion://购买通知
        {
            titleStr = TEXT(@"购买通知");
            imageName = @""; //icon 本地图标
        }
            break;
        case eMyProperty://我的资产
        {
            titleStr = TEXT(@"我的资产");
            imageName = @""; //icon 本地图标
        }
            break;
        case eSquareTravel://广场游记
        {
            titleStr = TEXT(@"广场游记");
            imageName = @""; //icon 本地图标
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
            [self performSegueWithIdentifier:@"LBB_PromotionsViewController" sender:nil];
        }
            break;
        case eCustomer://我的客服
        {
            [self performSegueWithIdentifier:@"LBB_CustomerViewController" sender:nil];
        }
            break;
        case ePurchageNotifion://购买通知
        {
            [self performSegueWithIdentifier:@"LBB_PurchaseNotificationViewController" sender:nil];
        }
            break;
        case eMyProperty://我的资产
        {
        }
            break;
        case eSquareTravel://广场游记
        {
        }
            break;
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *dstVC = segue.destinationViewController;;
    if ([dstVC isKindOfClass:NSClassFromString(@"LBB_PromotionsViewController")]) { //优惠促销
        
    }else if([dstVC isKindOfClass:NSClassFromString(@"LBB_CustomerViewController")]) {//我的客服
        
    }else if([dstVC isKindOfClass:NSClassFromString(@"LBB_PurchaseNotificationViewController")]) {//购买通知
        
    }else if([dstVC isKindOfClass:NSClassFromString(@"LBB_MyPropertyViewController")]) {//我的资产
        
    }else{
        //广场游记调用API
    }
}

@end
