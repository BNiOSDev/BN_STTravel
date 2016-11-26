//
//  LBB_TravelModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine_Common.h"

@interface LBB_TravelModel : BN_BaseDataModel

@property (nonatomic, assign)long travelNoteId ;//游记主键
@property (nonatomic, copy)NSString* travelNoteName ;//游记名称
@property (nonatomic, copy)NSString* travelNotePicUrl ;//游记封面
@property (nonatomic, copy)NSString* releaseDate ;//发布日期
@property (nonatomic, assign) int    dayCount;//天数
@property (nonatomic, assign) int    isLiked;//是否点赞
@property (nonatomic, assign) int    isCollected;//是否收藏
@property (nonatomic, assign) int     totalLike;//赞数
@property (nonatomic, assign) int     totalComment;//评论数
@property (nonatomic, assign) int     totalCollected;//收藏数

@end

@interface LBB_TravelViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_TravelModel*>* travelArray;

/**
 *3.5.6 我的-广场 游记（已测）
 *3.5.12 我的-收藏 广场 游记（已测）
 */
- (void)getMyTravelList:(BOOL)isClear VidewType:(MySquareViewType)videoType;

@end
