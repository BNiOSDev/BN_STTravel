//
//  LBB_ScenicMainViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SpotDetailsViewModel.h"
#import "LBB_HomeCommonModel.h"

@interface LBB_ScenicSpotConditionOption : NSObject

@property(nonatomic,assign)int key;//主键(字典表里面的key，到手根据key来定义规则)
@property (nonatomic,strong)NSString *name;//显示名称

@end

@interface LBB_ScenicSpotCondition : BN_BaseDataModel

@property (nonatomic,strong)NSMutableArray<LBB_ScenicSpotConditionOption*> *type;//类别 
@property (nonatomic,strong)NSMutableArray<LBB_ScenicSpotConditionOption*> *order;//排序
@property (nonatomic,strong)NSMutableArray<LBB_ScenicSpotConditionOption*> *hotRecommend;//热门推荐
@property (nonatomic,strong)NSMutableArray<LBB_ScenicSpotConditionOption*> *tags;//标签
@property (nonatomic,strong)NSMutableArray<LBB_ScenicSpotConditionOption*> *price;//价格

@end

@interface LBB_ScenicViewModel : NSObject

@property (nonatomic,strong)LBB_ScenicSpotCondition *scenicSpotCondition;//

@property (nonatomic,strong)NSMutableArray<LBB_SpotModel *> *spotArray;

@property (nonatomic, strong)NSMutableArray<BN_HomeAdvertisement*> *advertisementArray;

/**
 3.2.1	景点筛选条件(已测)
 */
- (void)getSpotCondition;

/**
 3.1.2 广告轮播 4.景点页面最顶部
 
 @param clear 是否清空原数据
 */
- (void)getAdvertisementListArrayClearData:(BOOL)clear;

/**
 3.2.4	景点列表(已测)

 @param longitude Y坐标
 @param dimensionality Y坐标
 @param typeKey 传入景点类型key
 @param orderKey 传入排序key
 @param hotRecommendKey 热门推荐key
 @param tagsKey 标签key
 @param priceKey 价格Key
 */
- (void)getSpotArrayLongitude:(NSString *)longitude
               dimensionality:(NSString *)dimensionality
                      typeKey:(int)typeKey
                     orderKey:(int)orderKey
              hotRecommendKey:(int)hotRecommendKey
                      tagsKey:(int)tagsKey
                     priceKey:(int)priceKey
                    clearData:(BOOL)clear;

@end
