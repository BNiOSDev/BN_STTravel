//
//  LBB_FoodsViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SpotDetailsViewModel.h"
#import "LBB_HomeCommonModel.h"
@interface LBB_FoodsConditionOption : NSObject

@property(nonatomic,assign)int key;//主键(字典表里面的key，到手根据key来定义规则)
@property (nonatomic,strong)NSString *name;//显示名称

@end


@interface LBB_FoodsCondition : BN_BaseDataModel

@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *distance ;// 附近距离
@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *tradingArea ;// 商圈
@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *type ;// 类别
@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *order ;// 排序
@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *hotRecommend ;// 热门推荐
@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *tags ;// 标签
@property (nonatomic,strong)NSMutableArray<LBB_FoodsConditionOption*> *price ;// 价格

@end

@interface LBB_FoodsViewModel : NSObject

@property (nonatomic,strong)LBB_FoodsCondition *foodsCondition;//

@property (nonatomic,strong)NSMutableArray<LBB_SpotModel *> *foodsArray;

@property (nonatomic, strong)NSMutableArray<BN_HomeAdvertisement*> *advertisementArray;

/**
 3.2.2	美食筛选条件(已测)
 */
- (void)getFoodsCondition;

/**
 3.1.2 广告轮播 3.美食页面最顶部
 
 @param clear 是否清空原数据
 */
- (void)getAdvertisementListArrayClearData:(BOOL)clear;

/**
 3.2.5	美食列表(已测)

 @param longitude Y坐标
 @param dimensionality X坐标
 @param tradingAreaKey 商圈Key
 @param distance 传入距离key
 @param typeKey 传入类别key
 @param orderKey 传入排序key
 @param hotRecommendKey 热门推荐key
 @param tagsKey 标签key
 @param priceKey 价格Key
 @param clear 是否清空原数据
 */
- (void)getFoodsArrayLongitude:(NSString *)longitude
               dimensionality:(NSString *)dimensionality
                      tradingAreaKey:(int)tradingAreaKey
                     distance:(int)distance
                      typeKey:(int)typeKey
                      orderKey:(int)orderKey
                     hotRecommendKey:(int)hotRecommendKey
                      tagsKey:(int)tagsKey
                     priceKey:(int)priceKey
                    clearData:(BOOL)clear;

@end
