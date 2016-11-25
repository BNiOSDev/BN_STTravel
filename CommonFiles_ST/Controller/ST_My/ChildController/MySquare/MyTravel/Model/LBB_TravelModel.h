//
//  LBB_TravelModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_TravelModel : NSObject

@property (nonatomic, copy)  NSString  *imageUrl;
@property (nonatomic, strong) NSString *iconName;//icon
@property (nonatomic, strong) NSString *name;//名字
@property (nonatomic, strong) NSString *msgContent;//内容
@property (nonatomic, copy) NSString    *timeStr;//时间
@property (nonatomic, copy) NSString    *daysStr;//历时多久
@property (nonatomic, copy) NSString    *vistNum;//浏览人数
@property (nonatomic, copy) NSString    *praiseNum;//赞数
@property (nonatomic, copy) NSString    *commentNum;//评论数
@property (nonatomic, copy) NSString    *collectNum;//收藏数
@property (nonatomic,assign) BOOL       isCollection;//是否收藏

@end
