//
//  PraiseModel.h
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PraiseModel : NSObject
@property(nonatomic, copy)NSString      *iconUrl;// 头像
@property(nonatomic, copy)NSString      *userID;// 用户ID

@property (nonatomic, assign)long likeId ;// 标签ID

@end
