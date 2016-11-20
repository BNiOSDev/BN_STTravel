//
//  LBBPoohCycleScrollCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import <AutoScrollLabel/CBAutoScrollLabel.h>
#import "LBB_HomeViewModel.h"



@interface LBBPoohCycleScrollCell : LBBPoohBaseTableViewCell

-(void)setCycleScrollViewUrls:(NSArray*)urlArray;

-(void)setCycleScrollViewHeight:(CGFloat)height;

@property(nonatomic, strong)ClickBlock click;

@property(nonatomic, assign)BOOL enableBlock;

//详情页的订单信息
@property(nonatomic, retain)UIImageView* orderPortraitImageView;
@property(nonatomic, retain)UILabel* orderNewMessageLabel;
-(void)showOrderMessage;

@property (nonatomic, strong)NSMutableArray<BN_HomeAdvertisement*> *adModelArray;

@end
