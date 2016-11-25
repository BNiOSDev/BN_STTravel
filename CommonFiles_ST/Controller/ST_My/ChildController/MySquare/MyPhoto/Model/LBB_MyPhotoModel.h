//
//  LBB_MyPhotoModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_MyPhotoModel : NSObject
@property (nonatomic, copy) NSString  *imageUrl;
@property (nonatomic, copy) NSString    *praiseNum;//赞数
@property (nonatomic, copy) NSString    *commentNum;//评论数
@property (nonatomic,assign) BOOL      isCollection; //是否收藏
@end
