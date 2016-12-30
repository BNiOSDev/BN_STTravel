//
//  LBB_SquareViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SquareDetailViewModel.h"
#import "LBB_UserShowViewModel.h"

@interface LBB_SquareUgc : BN_BaseDataModel

@property (nonatomic, assign)long ugcId ;// 主键
@property (nonatomic, assign)int ugcType ;// 1.照片 2.视频
@property (nonatomic, strong)NSString *videoUrl ;// 视频地址(类型为2)
@property (nonatomic, strong)NSString *coverImageUrl;// 封面图片(类型为2)
@property (nonatomic, assign)long userId ;// 用户ID
@property (nonatomic, strong)NSString *userName ;// 用户名称
@property (nonatomic, strong)NSString *userPicUrl ;// 用户头像
@property (nonatomic, assign)long timeDistance ;// 时间距离(分)
@property (nonatomic, strong)NSString *timeDistanceRemark;//距离时间秒速
@property (nonatomic, assign)long allSpotsId ;// 场景ID
@property (nonatomic, strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic, strong)NSMutableArray<LBB_SquarePics *> *pics ;// 图片集合
@property (nonatomic, strong)NSMutableArray<LBB_SquareTags *> *tags ;// 视频标签
@property (nonatomic, assign)int picNum ;// 图片总数
@property (nonatomic, strong)NSString *picsRemark ;// 图片描述
@property (nonatomic, strong)NSString *videoRemark ;// 视频描述
@property (nonatomic, assign)int likeNum ;// 点赞次数
@property (nonatomic, assign)int isLiked ;// 是否点赞 0 否 1是
@property (nonatomic, strong)NSMutableArray<LBB_SquareLikeList *> *likeds ;// 点赞集合
@property (nonatomic, assign)int isCollected ;// 是否收藏0 否 1是
@property (nonatomic, strong)NSMutableArray<LBB_SquareComments *> *comments ;// 评论集合

@property (nonatomic, strong)LBB_SquareDetailViewModel *squareDetailViewModel;

@property (nonatomic, strong)LBB_UserShowViewModel *userShowViewModel;

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSDictionary*dic, NSError *error))block;

/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSDictionary*dic, NSError *error))block;

/**
 3.4.5	广场-广场主页-图片/视频详情（已测）
 */
- (void)getSquareDetailViewModelData;


/**
 3.4.6	广场-广场主页-个人主页（添加导游部分、未开发）
 */
- (void)getUserShowViewModelData;

@end

@interface LBB_SquareFriend : BN_BaseDataModel

@property (nonatomic, assign)long followId ;// 主键
@property (nonatomic, strong)NSString *userName ;// 用户名称
@property (nonatomic, strong)NSString *attentionRemark ;// 关注备注(如：哈哈小子等3人与TA互相关注)
@property (nonatomic, strong)NSString *userHeadPortraitUrl ;// 用户头像
@property (nonatomic, assign)int AttentionStatus ;// 0:未关注 1：已关注
@property (nonatomic, assign)int  userId;

/**
 3.4.3	广场-广场主页-好友关注（已测）

 @param block 回调block
 */
- (void)attention:(void (^)(NSError *error))block;

@end


@interface LBB_SquareViewModel : NSObject

@property (nonatomic, strong)LBB_SquareFriend *squareRecommend;//好友推荐数据
@property (nonatomic, strong)NSMutableArray<LBB_SquareFriend*> *friendArray;//好友列表数据

@property (nonatomic, strong)NSMutableArray<LBB_SquareUgc*> *ugcImageArray;//展示图片数据列表
@property (nonatomic, strong)NSMutableArray<LBB_SquareUgc*> *ugcVideoArray;//展示视频数据列表

/**
 3.4.1	广场-广场主页-好友推荐（已测）
 */
- (void)getSquareRecommendData;


/**
 3.4.2	广场-广场主页-好友推荐列表（已测）

 @param clear 清空原数据
 */
- (void)getFriendArrayClearData:(BOOL)clear;



// 3.4.4	广场-广场主页-图片/视频列表（已测）
// @param clear 清空原数据


/**
 3.4.4	广场-广场主页-图片/视频列表（已测）

 @param type 1主页  视频为单独的2.视频
 @param clear 清空原数据
 */
- (void)getUgcArrayType:(int)type ClearData:(BOOL)clear;

@end
