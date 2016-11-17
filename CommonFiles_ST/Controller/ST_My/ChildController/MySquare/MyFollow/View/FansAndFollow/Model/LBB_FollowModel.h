//
//  LBB_FollowModel.h
//  ST_Travel
//
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_FollowModel : NSObject

@property(nonatomic,copy) NSString *userImageURL; //用户头像
@property(nonatomic,copy) NSString *userName; //用户名称
@property(nonatomic,copy) NSString *userSignature; //用户签名
@property(nonatomic,assign) BOOL certified; //达人认证
@property(nonatomic,assign) NSInteger lvLevel; //lv 等级
@property(nonatomic,assign) BOOL isFollow; //是否关注

@end
