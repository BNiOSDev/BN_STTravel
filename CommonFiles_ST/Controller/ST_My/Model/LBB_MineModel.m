//
//  LBB_MineModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MineModel.h"


@implementation LBB_MineUserInfo

- (id)init
{
    self = [super init];
    if (self) {
       
    }
    
    return self;
}
@end


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


@implementation LBB_MineModelData


@end


@implementation LBB_MineModel

- (LBB_MineModelData*)getData
{
    LBB_MineModelData *modelData = [[LBB_MineModelData alloc] init];
    
    LBB_MineUserInfo *userInfo = [[LBB_MineUserInfo alloc] init];
    userInfo.userID = @"11ea";
    userInfo.userImagePath = @"19.pic.jpg";
    userInfo.coverPicturePath = IMAGE(@"IMG_0849.JPG");
    userInfo.userName = @"滨滨";
    userInfo.lvLevel = 10;
    userInfo.isGuideAuth = YES;
    userInfo.signature = @"要么读书，要么旅行，身体和思想总有一个在路上";
    
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
    
    modelData.userInfo = userInfo;
    modelData.sectionInfo = sectionArary;
    
    return modelData;
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
                detailInfo.newNum = 99;
            }
                
                break;
            case eOrder_WaitGetTicket:
            {
                detailInfo.detailImage = @"待收货-订单.png";
                detailInfo.detailContent = @"待收货";
                detailInfo.newNum = 0;
            }
                
                break;
            case eOrder_WaitComment:
            {
                detailInfo.detailImage = @"待评价-订单.png";
                detailInfo.detailContent = @"待评价";
                detailInfo.newNum = 99;
            }
                
                break;
            case eOrder_AfterAales:
            {
                detailInfo.detailImage = @"售后.png";
                detailInfo.detailContent = @"售后";
                detailInfo.newNum = 0;
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
               detailInfo.newNum = 3;
               detailInfo.detailContent = @"待付款";
            }
                
                break;
            case eTicket_WaitGetTicket:
            {
                detailInfo.detailImage = @"待取票.png";
                detailInfo.newNum = 0;
                detailInfo.detailContent = @"待取票";
            }
                
                break;
            case eTicket_WaitComment:
            {
                detailInfo.detailImage = @"待评价-门票.png";
                detailInfo.newNum = 3;
                detailInfo.detailContent = @"待评价";
            }
                
                break;
            case eTicket_Refund:
            {
                detailInfo.detailImage = @"退票.png";
                detailInfo.newNum = 3;
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
                detailInfo.detailContent = @"照片";
            }
                break;
            case eTravels:
            {
                detailInfo.detailImage = @"游记.png";
                detailInfo.detailContent = @"照片";
            }
                break;
            case eLove:
            {
                detailInfo.detailImage = @"关注.png";
                detailInfo.detailContent = @"照片";
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
                detailInfo.detailImage = @"照片.png";
                detailInfo.detailContent = @"广场";
            }
                break;
            case eScenicSpot:
            {
                detailInfo.detailImage = @"视频.png";
                detailInfo.detailContent = @"景点";
            }
                break;
            case eFood:
            {
                detailInfo.detailImage = @"游记.png";
                detailInfo.detailContent = @"美食";
            }
                break;
            case eHalls:
            {
                detailInfo.detailImage = @"民宿.png";
                detailInfo.detailContent = @"照片";
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

@end
