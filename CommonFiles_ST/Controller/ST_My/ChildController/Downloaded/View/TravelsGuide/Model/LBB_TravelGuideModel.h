//
//  LBB_TravelGuideModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_TravelGuideModel : BN_BaseDataModel

@property(nonatomic,assign) long lineId;//路线ID
@property(nonatomic,copy) NSString *coverImageUrl;//列表上显示的图片
@property(nonatomic,copy) NSString *name;//标题

@property (nonatomic, copy)NSString* releaseDate ;//发布日期
@property (nonatomic, assign) int    dayCount;//天数

@property (nonatomic, assign) int    isCollected;//收藏标志0未收藏 1：收藏
@property (nonatomic, assign) int    isLiked;//点赞标志 0未点赞 1：点赞
@property (nonatomic, assign) int     likeNum;//点赞次数
@property (nonatomic, assign) int     commentsNum;//评论条数
@property (nonatomic, assign) int     collecteNum;//收藏次数

/**
 *3.1.4 收藏(已测)
 */
- (void)collect;

/**
 *3.1.5 点赞(已测)
 */
- (void)like;


@end

@interface LBB_TravelGuideViewModelModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_TravelGuideModel*>* travelGuideArray;

/**
 *3.5.17 我的-收藏 广场 攻略（已测）
 */
- (void)getMyTravelGuideList:(BOOL)isClear;

@end
