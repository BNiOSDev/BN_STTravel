//
//  LBB_SpotModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <BN_BaseDataModel.h>

@interface LBB_SpotAddress : BN_BaseDataModel

@property (nonatomic,assign)long allSpotsId ;// 主键
@property (nonatomic,strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic,assign)int allSpotsType ;// 1.美食 2.民宿 3景点
@property (nonatomic,strong)NSString *address ;// 地址
@property (nonatomic,strong)NSString *longy;//精度
@property (nonatomic,strong)NSString *dimx;//伟度
@property (nonatomic,strong)NSString *dimensionality;//伟度
@property (nonatomic,strong)NSString *longitude;//精度
@property (nonatomic,strong)NSString *picUrl;//图片




@end
