//
//  LBB_MineModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MineModel.h"
#import "LBB_LoginManager.h"


@implementation LBB_MineDetaiInfo

- (id)init
{
    self = [super init];
    if (self) {
        _newNum = 0;
    }
    
    return self;
}
@end


@implementation LBB_MineSectionInfo


@end


@implementation LBB_MineViewModel

- (id)init
{
    self = [super init];
    if (self ) {
        [self initData];
    }
    return self;
}
/**
 3.5.1 我的-首页（已测）
 */
- (void)getMineInfo
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/index",BASEURL];
    
    self.loadSupport.loadEvent = NetLoadingEvent;
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSLog(@"responseObject = %@",responseObject);
        NSString *remark = [dic objectForKey:@"remark"];
        if(codeNumber.intValue == 0)
        {
            [weakSelf mj_setKeyValues:[dic objectForKey:@"result"]];
            [weakSelf updateData];
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else {
              [weakSelf mj_setKeyValues:[dic objectForKey:@"result"]];
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

- (void)updateData
{
    //我的订单
    LBB_MineSectionInfo *sectionInfo0 = self.sectionInfo[0];//订单信息
    NSArray *ordertabArray = sectionInfo0.detailArary;
    for (int i = 0; i < ordertabArray.count; i++) {
        LBB_MineDetaiInfo *detailInfo = ordertabArray[i];
        switch (i) {
            case 0:
                detailInfo.newNum = self.waitPayOrderCount;
                break;
            case 1:
                detailInfo.newNum = self.waitTakeOrderCount;
                break;
            case 2:
                detailInfo.newNum = self.waitCommentOrderCount;
                break;
            case 3:
                detailInfo.newNum = self.afterSaleOrderCount;
                break;
            default:
                break;
        }
    }
    //我的门票
    LBB_MineSectionInfo *sectionInfo1 = self.sectionInfo[1];//门票信息
    NSArray *ticketArray = sectionInfo1.detailArary;
    for (int i = 0; i < ticketArray.count; i++) {
        LBB_MineDetaiInfo *detailInfo = ticketArray[i];
        switch (i) {
            case 0:
                detailInfo.newNum = self.waitPayTicketCount;
                break;
            case 1:
                detailInfo.newNum = self.waitTakeTicketCount;
                break;
            case 2:
                detailInfo.newNum = self.waitCommentTicketCount;
                break;
            case 3:
                detailInfo.newNum = self.refundTicketCount;
                break;
            default:
                break;
        }
    }
}

- (void)initData
{
    self.name = @"登录";
    
    NSMutableArray *sectionArary = [[NSMutableArray alloc] init];
    
    LBB_MineSectionInfo *orderSectionInfo = [[LBB_MineSectionInfo alloc] init];
    orderSectionInfo.setcionType = eOrder;
    orderSectionInfo.sectionContent = @"我的订单";
    orderSectionInfo.needCheckAll = YES;
    orderSectionInfo.detailArary = [self getOrderArray];
    [sectionArary addObject:orderSectionInfo];
    
    LBB_MineSectionInfo *ticketSectionInfo = [[LBB_MineSectionInfo alloc] init];
    ticketSectionInfo.setcionType = eTickets;
    ticketSectionInfo.sectionContent = @"我的门票";
    ticketSectionInfo.needCheckAll = YES;
    ticketSectionInfo.detailArary = [self getTicketArray];
    [sectionArary addObject:ticketSectionInfo];
    
    LBB_MineSectionInfo *squareSectionInfo = [[LBB_MineSectionInfo alloc] init];
    squareSectionInfo.setcionType = eTypeNone;
    squareSectionInfo.sectionContent = @"我的广场";
    squareSectionInfo.detailArary = [self getSquareArray];
    [sectionArary addObject:squareSectionInfo];
    
    LBB_MineSectionInfo *favoriteSectionInfo = [[LBB_MineSectionInfo alloc] init];
    favoriteSectionInfo.setcionType = eTypeNone;
    favoriteSectionInfo.sectionContent = @"我的收藏";
    favoriteSectionInfo.detailArary = [self getFavoriteArray];
    [sectionArary addObject:favoriteSectionInfo];
     
    LBB_MineSectionInfo *otherSectionInfo = [[LBB_MineSectionInfo alloc] init];
    otherSectionInfo.setcionType = eTypeNone;
    otherSectionInfo.sectionContent = nil;
    otherSectionInfo.detailArary = [self getOtherArray];
    [sectionArary addObject:otherSectionInfo];
    
    self.sectionInfo = sectionArary; 
}

- (NSMutableArray *)getOrderArray
{
    NSMutableArray *detailArray = [[NSMutableArray alloc] init];
    for (int i = eOrder_WaitPay; i < eOrder_WaitPay + 4; i++ ) {
        LBB_MineDetaiInfo *detailInfo = [[LBB_MineDetaiInfo alloc] init];
        detailInfo.detailType = i;
        switch (i) {
            case eOrder_WaitPay:
            {
                detailInfo.detailImage = @"待付款-订单.png";
                detailInfo.detailContent = @"待付款";
            }
                
                break;
            case eOrder_WaitGetTicket:
            {
                detailInfo.detailImage = @"待收货-订单.png";
                detailInfo.detailContent = @"待收货";
            }
                
                break;
            case eOrder_WaitComment:
            {
                detailInfo.detailImage = @"待评价-订单.png";
                detailInfo.detailContent = @"待评价";
            }
                
                break;
            case eOrder_AfterAales:
            {
                detailInfo.detailImage = @"售后.png";
                detailInfo.detailContent = @"售后";
            }
               
                break;
            default:
                break;
        }
        [detailArray addObject:detailInfo];
    }
    return detailArray;
}


- (NSMutableArray *)getTicketArray
{
    NSMutableArray *detailArray = [[NSMutableArray alloc] init];
    for (int i = eTicket_WaitPay; i < eTicket_WaitPay + 4; i++ ) {
        LBB_MineDetaiInfo *detailInfo = [[LBB_MineDetaiInfo alloc] init];
        detailInfo.detailType = i;
        switch (i) {
            case eTicket_WaitPay:
            {
               detailInfo.detailImage = @"待付款-门票.png";
               detailInfo.detailContent = @"待付款";
            }
                
                break;
            case eTicket_WaitGetTicket:
            {
                detailInfo.detailImage = @"待取票.png";
                detailInfo.detailContent = @"待取票";
            }
                
                break;
            case eTicket_WaitComment:
            {
                detailInfo.detailImage = @"待评价-门票.png";
                detailInfo.detailContent = @"待评价";
            }
                
                break;
            case eTicket_Refund:
            {
                detailInfo.detailImage = @"退票.png";
                detailInfo.detailContent = @"退票.";
            }
                
                break;
            default:
                break;
        }
        [detailArray addObject:detailInfo];
    }
    return detailArray;
}

- (NSMutableArray *)getSquareArray
{
    NSMutableArray *detailArray = [[NSMutableArray alloc] init];
    for (int i = ePhoto; i < ePhoto + 4; i++ ) {
        LBB_MineDetaiInfo *detailInfo = [[LBB_MineDetaiInfo alloc] init];
        detailInfo.detailType = i;
        switch (i) {
            case ePhoto:
            {
                detailInfo.detailImage = @"照片.png";
                detailInfo.detailContent = @"照片";
            }
                break;
            case eVideo:
            {
                detailInfo.detailImage = @"视频.png";
                detailInfo.detailContent = @"视频";
            }
                break;
            case eTravels:
            {
                detailInfo.detailImage = @"游记.png";
                detailInfo.detailContent = @"游记";
            }
                break;
            case eLove:
            {
                detailInfo.detailImage = @"关注.png";
                detailInfo.detailContent = @"关注";
            }
                break;
            default:
                break;
        }
        [detailArray addObject:detailInfo];
    }
    return detailArray;
}

- (NSMutableArray*)getFavoriteArray
{
    NSMutableArray *detailArray = [[NSMutableArray alloc] init];
    for (int i = eSquare; i < eSquare + 8; i++ ) {
        LBB_MineDetaiInfo *detailInfo = [[LBB_MineDetaiInfo alloc] init];
        detailInfo.detailType = i;
        switch (i) {
            case eSquare:
            {
                detailInfo.detailImage = @"广场.png";
                detailInfo.detailContent = @"广场";
            }
                break;
            case eScenicSpot:
            {
                detailInfo.detailImage = @"景点.png";
                detailInfo.detailContent = @"景点";
            }
                break;
            case eFood:
            {
                detailInfo.detailImage = @"美食.png";
                detailInfo.detailContent = @"美食";
            }
                break;
            case eHalls:
            {
                detailInfo.detailImage = @"民宿.png";
                detailInfo.detailContent = @"民宿";
            }
                break;
                
            case eGoods:
            {
                detailInfo.detailImage = @"商品.png";
                detailInfo.detailContent = @"商品";
            }
                break;
            case eFlashSale:
            {
                detailInfo.detailImage = @"限时抢购.png";
                detailInfo.detailContent = @"限时抢购";
            }
                break;
            case eHandSpecial:
            {
                detailInfo.detailImage = @"伴手礼专题.png";
                detailInfo.detailContent = @"伴手礼专题";
            }
                break;
            case eTravelGuide:
            {
                detailInfo.detailImage = @"攻略.png";
                detailInfo.detailContent = @"攻略";
            }
                break;
            default:
                break;
        }
        [detailArray addObject:detailInfo];
    }
    return detailArray;
}

- (NSMutableArray*)getOtherArray
{
    NSMutableArray *detailArray = [[NSMutableArray alloc] init];
    for (int i = ePoints; i < ePoints + 4; i++ ) {
        LBB_MineDetaiInfo *detailInfo = [[LBB_MineDetaiInfo alloc] init];
        detailInfo.detailType = i;
        switch (i) {
            case ePoints:
            {
                detailInfo.detailImage = @"积分.png";
                detailInfo.detailContent = @"积分";
            }
                break;
            case eDownload:
            {
                detailInfo.detailImage = @"下载.png";
                detailInfo.detailContent = @"下载";
            }
                break;
            case eRoute:
            {
                detailInfo.detailImage = @"定制线路.png";
                detailInfo.detailContent = @"定制线路";
            }
                break;
            case eSetting:
            {
                detailInfo.detailImage = @"设置.png";
                detailInfo.detailContent = @"设置";
            }
                break;
            default:
                break;
        }
        [detailArray addObject:detailInfo];
    }
    return detailArray;
}

/**
 3.5.2 我的-首页修改封面（已测）
 */
- (void)updateCover:(NSString*)coverURL
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/cover/update",BASEURL];
    if (!coverURL || [coverURL length] == 0) {
        return;
    }
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionaryWithCapacity:0];
    [parames setObject:coverURL forKey:@"coverImageUrl"];
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSLog(@"responseObject = %@",responseObject);
        NSString *remark = [dic objectForKey:@"remark"];
        if(codeNumber.intValue == 0)
        {
            weakSelf.coverImageUrl = coverURL;
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else {
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end
