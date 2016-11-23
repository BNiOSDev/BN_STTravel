//
//  LBB_HostelViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SpotDetailsViewModel.h"
#import "LBB_HomeCommonModel.h"
@interface LBB_HostelConditionOption : NSObject

@property(nonatomic,assign)int key;//主键(字典表里面的key，到手根据key来定义规则)
@property (nonatomic,strong)NSString *name;//显示名称

@end


@interface LBB_HostelCondition : BN_BaseDataModel

@property (nonatomic,strong)NSMutableArray<LBB_HostelConditionOption*> *type ;// 类别
@property (nonatomic,strong)NSMutableArray<LBB_HostelConditionOption*> *order ;// 排序
@property (nonatomic,strong)NSMutableArray<LBB_HostelConditionOption*> *hotRecommend ;// 热门推荐
@property (nonatomic,strong)NSMutableArray<LBB_HostelConditionOption*> *tags ;// 标签
@property (nonatomic,strong)NSMutableArray<LBB_HostelConditionOption*> *price ;// 价格


@end

@interface LBB_HostelViewModel : NSObject


@property (nonatomic,strong)LBB_HostelCondition *hostelCondition;//

@property (nonatomic,strong)NSMutableArray<LBB_SpotModel *> *hostelArray;

@property (nonatomic, strong)NSMutableArray<BN_HomeAdvertisement*> *advertisementArray;

/**
 3.2.3	民宿筛选条件(已测)
 */
- (void)getHostelCondition;

/**
 3.1.2 广告轮播 2.美食页面最顶部
 
 @param clear 是否清空原数据
 */
- (void)getAdvertisementListArrayClearData:(BOOL)clear;

/**
 2.3.6	民宿列表(已测)
 
 @param longitude Y坐标
 @param dimensionality X坐标
 @param typeKey 传入类别key
 @param orderKey 传入排序key
 @param hotRecommendKey 热门推荐key
 @param tagsKey 标签key
 @param priceKey 价格Key
 @param clear 是否清空原数据
 */
- (void)getHostelArrayLongitude:(NSString *)longitude
                dimensionality:(NSString *)dimensionality
                       typeKey:(int)typeKey
                      orderKey:(int)orderKey
               hotRecommendKey:(int)hotRecommendKey
                       tagsKey:(int)tagsKey
                      priceKey:(int)priceKey
                     clearData:(BOOL)clear;

@end
