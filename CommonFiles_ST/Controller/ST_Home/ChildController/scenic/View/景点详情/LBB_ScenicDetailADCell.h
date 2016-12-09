//
//  LBB_ScenicDetailADCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_ScenicDetailADCell : LBBPoohBaseTableViewCell


-(void)setCycleScrollViewUrls:(NSArray*)urlArray;

-(void)setCycleScrollViewHeight:(CGFloat)height;

@property(nonatomic, strong)ClickBlock click;

@property(nonatomic, assign)BOOL enableBlock;

//详情页的订单信息
@property(nonatomic, retain)UIImageView* orderPortraitImageView;
-(void)showOrderMessage:(NSString*)string andImageUrl:(NSString*)url;

@property(nonatomic, strong)NSMutableArray<LBB_SpotsPics*> *allSpotsPics ;// 场景图片集合

#pragma 购买记录数据有问题，后台只是返回一个字符串，不是数组
@property(nonatomic, strong)NSMutableArray<LBB_PurchaseRecords*> *purchaseRecords ;// 最近6条购买记录
//@property(nonatomic, strong)NSMutableArray<LBB_PurchaseRecords*> *purchaseRecords ;// 最近6条购买记录

@end
