//
//  LBB_SquareTravelModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine_Common.h"

@interface LBB_SquareTravelModelDetail : NSObject

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *imagePath;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *underLineContent;
@property (nonatomic,copy) NSString *dateStr;

@end


@interface LBB_SquareTravelModel : NSObject

- (NSArray*)getDataWithType:(MessageCenterSquareTravelType)type;

@end
