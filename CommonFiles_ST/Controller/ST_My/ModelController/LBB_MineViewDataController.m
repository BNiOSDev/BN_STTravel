//
//  LBB_MineViewDataController.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MineViewDataController.h"
#import "LBB_MyViewCell.h"
#import "LBB_MySectionHeadViewCell.h"
#import "LBB_MySectionFooterViewCell.h"
#import "LBB_MyUserHeaderView.h"
#import "MineBaseViewController.h"

@implementation LBB_MineViewDataController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)initDataSource
{
    self.arr = [[NSMutableArray alloc] initWithCapacity:10];
    [self.arr addObject:@{@"Header" :
                               @{@"Title" : @"用户头像"}}];
    [self.arr addObject:@{@"Header" :
                              @{@"Title" : @"我的订单",
                                @"Desc":@"查看全部",
                                @"ActionType" : [NSNumber numberWithInt:eOrder]},
                          @"Content" : @[@{@"Title":@"待付款",
                                           @"Image" : @"待付款-订单.png",
                                           @"NewNum" : @"11",
                                           @"ActionType" : [NSNumber numberWithInt:eOrder_WaitPay]},
                                         @{@"Title":@"待收货",
                                           @"Image" : @"待收货-订单.png",
                                           @"ActionType" : [NSNumber numberWithInt:eOrder_WaitGetTicket]},
                                         @{@"Title":@"待评价",
                                           @"Image" : @"待评价-订单.png",
                                           @"NewNum" : @"9",
                                          @"ActionType" : [NSNumber numberWithInt:eOrder_WaitComment]},
                                         @{@"Title":@"售后",
                                           @"Image" : @"售后.png",
                                           @"ActionType" : [NSNumber numberWithInt:eOrder_AfterAales]}]}];
    [self.arr addObject:@{@"Header" :
                              @{@"Title" : @"我的门票",
                                @"Desc":@"查看全部",
                                @"ActionType" : [NSNumber numberWithInt:eTickets]},
                          @"Content" : @[@{@"Title":@"待付款",
                                           @"Image" : @"待付款-门票.png",
                                           @"ActionType" : [NSNumber numberWithInt:eTicket_WaitPay]},
                                         @{@"Title":@"待取票",
                                           @"Image" : @"待取票.png",
                                           @"NewNum" : @"8",
                                           @"ActionType" : [NSNumber numberWithInt:eTicket_WaitGetTicket]},
                                         @{@"Title":@"待评价",
                                           @"Image" : @"待评价-门票.png",
                                           @"ActionType" : [NSNumber numberWithInt:eTicket_WaitComment]},
                                         @{@"Title":@"退款",
                                           @"Image" : @"退票.png",
                                           @"NewNum" : @"99",
                                           @"ActionType" : [NSNumber numberWithInt:eTicket_Refund]}]}];
    [self.arr addObject:@{@"Header" :
                              @{@"Title" : @"我的广场"},
                          @"Content" : @[@{@"Title":@"照片",
                                           @"Image" : @"照片.png",
                                           @"ActionType" : [NSNumber numberWithInt:ePhoto]},
                                         @{@"Title":@"视频",
                                           @"Image" : @"视频.png",
                                           @"ActionType" : [NSNumber numberWithInt:eVideo]},
                                         @{@"Title":@"游记",
                                           @"Image" : @"游记.png",
                                           @"ActionType" : [NSNumber numberWithInt:eTravels]},
                                         @{@"Title":@"关注",
                                           @"Image" : @"关注.png",
                                           @"ActionType" : [NSNumber numberWithInt:eLove]}]}];
    [self.arr addObject:@{@"Header" :
                              @{@"Title" : @"我的收藏"},
                          @"Content" : @[@{@"Title":@"广场",
                                           @"Image" : @"广场.png",
                                           @"ActionType" : [NSNumber numberWithInt:eSquare]},
                                         @{@"Title":@"景点",
                                           @"Image" : @"景点.png",
                                           @"ActionType" : [NSNumber numberWithInt:eScenicSpot]},
                                         @{@"Title":@"美食",
                                           @"Image" : @"美食.png",
                                           @"ActionType" : [NSNumber numberWithInt:eFood]},
                                         @{@"Title":@"民宿",
                                           @"Image" : @"民宿.png",
                                           @"ActionType" : [NSNumber numberWithInt:eHalls]},
                                         @{@"Title":@"商品",
                                           @"Image" : @"商品.png",
                                           @"ActionType" : [NSNumber numberWithInt:eGoods]},
                                         @{@"Title":@"限时抢购",
                                           @"Image" : @"限时抢购.png",
                                           @"ActionType" : [NSNumber numberWithInt:eFlashSale]},
                                         @{@"Title":@"伴手礼专题",
                                           @"Image" : @"伴手礼专题.png",
                                           @"ActionType" : [NSNumber numberWithInt:eHandSpecial]},
                                         @{@"Title":@"攻略",
                                           @"Image" : @"攻略.png",
                                           @"ActionType" : [NSNumber numberWithInt:eTravelGuide]}]}];
    [self.arr addObject:@{@"Header" :
                              @{@"Title" : @""},
                          @"Content" : @[@{@"Title":@"积分",
                                           @"Image" : @"积分.png",
                                           @"ActionType" : [NSNumber numberWithInt:ePoints]},
                                         @{@"Title":@"下载",
                                           @"Image" : @"下载.png",
                                           @"ActionType" : [NSNumber numberWithInt:eDownload]},
                                         @{@"Title":@"定制路线",
                                           @"Image" : @"下载.png",
                                          @"ActionType" : [NSNumber numberWithInt:eRoute]},
                                         @{@"Title":@"设置",
                                           @"Image" : @"设置.png",
                                           @"ActionType" : [NSNumber numberWithInt:eSetting]}]}];
    
    //进行CollectionView和Cell的绑定
    UINib *nib = [UINib nibWithNibName:@"LBB_MyViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"LBB_MyViewCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册CollectionReusableView；
    UINib *nib2 = [UINib nibWithNibName:@"LBB_MySectionHeadViewCell" bundle:nil];
    [self.collectionView registerNib:nib2
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"LBB_MySectionHeadViewCell"];
    
    //注册CollectionReusableView；
    UINib *nib4 = [UINib nibWithNibName:@"LBB_MyUserHeaderView" bundle:nil];
    [self.collectionView registerNib:nib4
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"LBB_MyUserHeaderView"];
    
    
    UINib *nib3 = [UINib nibWithNibName:@"LBB_MySectionFooterViewCell" bundle:nil];
    [self.collectionView registerNib:nib3
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:@"LBB_MySectionFooterViewCell"];
    
}

- (NSDictionary*)getCellInfo:(NSIndexPath*)indexPath
{
    NSDictionary *cellInfo = nil;
    if (indexPath.section < self.arr.count) {
        NSDictionary *cellDict = [self.arr objectAtIndex:indexPath.section];
        NSArray *contentArray = [cellDict valueForKey:@"Content"];
        if (contentArray && [contentArray isKindOfClass:[NSArray class]]) {
            NSDictionary *infoDict = [contentArray objectAtIndex:indexPath.row];
            cellInfo = infoDict;
        }
        
    }
    return cellInfo;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.arr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *cellDict = [self.arr objectAtIndex:section];
    NSArray *contentArray = [cellDict valueForKey:@"Content"];
    if (contentArray && [contentArray isKindOfClass:[NSArray class]]) {
        return [contentArray count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LBB_MyViewCell";
    LBB_MyViewCell *cell =  (LBB_MyViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *infoDict = [self getCellInfo:indexPath];
    if (infoDict) {
        cell.imgView.image = IMAGE([infoDict objectForKey:@"Image"]);
        cell.label.text = [infoDict objectForKey:@"Title"];
        NSString *numStr = [infoDict objectForKey:@"NewNum"];
        if (numStr && [numStr intValue] > 0) {
            cell.numLabel.hidden = NO;
            cell.numLabel.text = numStr;
        }else {
             cell.numLabel.hidden = YES;
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            LBB_MyUserHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LBB_MyUserHeaderView" forIndexPath:indexPath];
            view.delegate = self.userHeaderDelegate;
            reusable = view;
        }else {
            LBB_MySectionHeadViewCell *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LBB_MySectionHeadViewCell" forIndexPath:indexPath];
            if (indexPath.section < self.arr.count) {
                NSDictionary *sectionDict = [self.arr objectAtIndex:indexPath.section];
                NSDictionary *infoDict = [sectionDict objectForKey:@"Header"];
                view.titleLabel.text = [infoDict objectForKey:@"Title"];
                view.userInfo = infoDict;
                view.viewType = [[infoDict objectForKey:@"ActionType"] intValue];
                view.delegate = self.cellDelegate;
                NSString *btnTitle = [infoDict objectForKey:@"Desc"];
                if (btnTitle && [btnTitle length]) {
                    [view.rightBtn setTitle:btnTitle forState:UIControlStateNormal];
                }else {
                    [view.rightBtn setTitle:nil forState:UIControlStateNormal];
                    view.arrowImgView.hidden = YES;
                }
                if ((indexPath.section == (self.arr.count - 1)) || (indexPath.section == 0)) {
                    view.lineView.hidden = YES;
                }else {
                    view.lineView.hidden = NO;
                }
            }else {
                view.titleLabel.text = nil;
                [view.rightBtn setTitle:nil forState:UIControlStateNormal];
                view.arrowImgView.hidden = YES;
            }
            reusable = view;
        }
       
    }else if(kind == UICollectionElementKindSectionFooter){
        LBB_MySectionFooterViewCell *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"LBB_MySectionFooterViewCell" forIndexPath:indexPath];
        reusable = view;
    }
    return reusable;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(didClickDetailActionDelegate:)]) {
        NSDictionary *infoDict = [self getCellInfo:indexPath];
        if (infoDict && [infoDict objectForKey:@"ActionType"]) {
            NSInteger viewType =  [[infoDict objectForKey:@"ActionType"] intValue];
            [self.cellDelegate didClickDetailActionDelegate:viewType];
        } 
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((DeviceWidth - 46.f) / 4,70.f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1,20,1,20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width * (283.f/475.f));
    }else if (section == (self.arr.count - 1)) {
         return CGSizeMake(self.collectionView.frame.size.width, 0.001f);
    }
    return CGSizeMake(self.collectionView.frame.size.width, 40.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.frame.size.width, 10.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f;
}


@end
