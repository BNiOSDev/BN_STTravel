//
//  LBB_NoticeModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_NoticeDetailModel : NSObject

@property(nonatomic,copy) NSString *detailID;
@property(nonatomic,copy) NSString *detailDateStr;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *dateStr;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *detailURL;

@end

@interface LBB_NoticeModel : NSObject


- (NSArray<LBB_NoticeDetailModel*>*)getData;

@end
