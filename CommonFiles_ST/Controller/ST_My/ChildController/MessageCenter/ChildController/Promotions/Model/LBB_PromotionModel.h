//
//  LBB_PromotionModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_PromotionModel : BN_BaseDataModel

@property(nonatomic,assign) long promotionId;//主键
@property(nonatomic,copy) NSString *title;//标题
@property(nonatomic,copy) NSString *describe;//描述
@property(nonatomic,copy) NSString *imageUrl;//图片URL
@property(nonatomic,copy) NSString *startTime;//开始时间
@property(nonatomic,copy) NSString *endTime;//结束时间
@property(nonatomic,copy) NSString *publishTime;//发布时间
@property(nonatomic,copy) NSString *content;//内容
@property(nonatomic,assign) int isEnd;//是否结束

@end


@interface LBB_PromotionViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_PromotionModel*>* dataArray;

/**
 *3.10.4 优惠促销列表(已测)
 */
- (void)getPromotionDataArray:(BOOL)isClear;

@end
