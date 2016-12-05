//
//  LBB_NearSign.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_NearSign : NSObject


/**
 3.1.9	签到(已测)

 @param objId 主键ID
 @param type 1美食 2 民宿 3 景点
 @param block 回调函数
 */
+ (void)signObjId:(long)objId type:(int)type block:(void (^)(NSError *error))block;

@end
