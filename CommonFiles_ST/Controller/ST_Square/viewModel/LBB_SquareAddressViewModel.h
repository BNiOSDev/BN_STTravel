//
//  LBB_SquareAddressViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LBB_SquareSpots : NSObject

@property (nonatomic,assign)long allSpotsId ;// 主键
@property (nonatomic,strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic,assign)int allSpotsType ;// 1.美食 2.民宿 3景点
@property (nonatomic,strong)NSString *address ;// 地址

@end

@interface LBB_SquareAddressViewModel : NSObject

@property (nonatomic,strong)NSMutableArray<LBB_SquareSpots*> *squareSpotsArray;

/**
 3.4.26	主页-游记添加地址（已测）
 
 @param allSpotsType 1.美食 2.民宿 3景点(可为空)
 @param name 可为空 模糊查询
 @param clear 是否清空原数据
 */
- (void)getsTravelNotesDetailAllSpotsType:(int)allSpotsType name:(NSString *)name ClearData:(BOOL)clear;

@end
