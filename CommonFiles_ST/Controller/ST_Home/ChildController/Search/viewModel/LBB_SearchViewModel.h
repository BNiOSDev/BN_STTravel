//
//  LBB_SearchViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_SearchHotWordModel : NSObject

@property(nonatomic, strong)NSString* name;

@end

@interface LBB_SearchViewModel : NSObject

@property (nonatomic, strong)NSMutableArray<LBB_SearchHotWordModel*> *hotWordArray;
@property (nonatomic, strong)NSMutableArray<LBB_SpotModel*> *scenicSpotsArray;
@property (nonatomic, strong)NSMutableArray<LBB_SpotModel*> *foodSpotsArray;
@property (nonatomic, strong)NSMutableArray<LBB_SpotModel*> *hostelSpotsArray;


/**
 3.6.1	搜索-热门搜索词汇（已测）
 */
- (void)getHotWordArray;


/**
 3.6.4	搜索-景点/美食/民宿（已测）

 @param longitude Y坐标
 @param dimensionality X坐标
 @param allSpotsType 1.美食 2.民宿 3景点
 @param name 搜索名称
 @param clear 清空原数据
 */
- (void)getAllSpotsArrayLongitude:(NSString *)longitude
                   dimensionality:(NSString *)dimensionality
                     allSpotsType:(int)allSpotsType
                             name:(NSString*)name
                        clearData:(BOOL)clear;

@end
