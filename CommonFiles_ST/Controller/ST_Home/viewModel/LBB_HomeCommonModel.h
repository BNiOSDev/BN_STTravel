//
//  LBB_HomeCommonModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BN_HomeAdvertisement : NSObject

@property (nonatomic, assign)long advertisementId;//广告主键
@property (nonatomic, assign)int classes;//广告类型1 外部连接 2 列表 3 详情
@property (nonatomic, assign)int type;//1.美食 2.民宿  3.景点 4伴手礼
@property (nonatomic, strong)NSString *picUrl;//广告图片地址
@property (nonatomic, strong)NSString *hrefUrl;//跳转地址（当是外部链接的时候有值）
@property (nonatomic, assign)long objId;//跳转主键（当是跳转到原生的时候有值）

@end



@interface LBB_HomeCommonModel : NSObject

@end
