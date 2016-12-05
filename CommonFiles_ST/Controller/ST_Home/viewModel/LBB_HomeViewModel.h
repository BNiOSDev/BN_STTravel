//
//  LBB_HomeViewModel.h
//  ST_Travel
//
//  Created by newman on 16/11/13.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_HomeCommonModel.h"

@interface BN_HomeUgcList : NSObject

@property (nonatomic, assign)long ugcId;//广场ID
@property (nonatomic, assign)int ugcType;//	1.照片 2.视频
@property (nonatomic, strong)NSString *ugcPicUrl;//显示图片地址
@property (nonatomic, strong)NSString *ugcVideoUrl;//视频地址
@property (nonatomic, assign)int likeNum;//点赞次数
@property (nonatomic, assign)int commentsNum;//评论条数
@property (nonatomic, strong)NSString *userName;//发布者用户名称
@property (nonatomic, strong)NSString *userPicUrl;//发布者头像URL
@property (nonatomic, assign)BOOL isCollected;//收藏标志 0未收藏 1：收藏
@property (nonatomic, assign)BOOL isLiked;//点赞标志 0未点赞 1：点赞

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block;


/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block;

@end

@interface BN_HomeTag : NSObject

@property (nonatomic, assign)long tagId;//标签ID
@property (nonatomic, strong)NSString *tagName;//标签名称

@end

@interface BN_HomeTravelNotes : NSObject

@property (nonatomic, assign)long travelNotesId;//游记ID
@property (nonatomic, strong)NSString *travelNotesName;//游记名称
@property (nonatomic, strong)NSString *travelNotesPicUrl;//游记图片
@property (nonatomic, strong)NSArray<BN_HomeTag*> *tags;//标签集合
@property (nonatomic, assign)int likeNum;//点赞次数
@property (nonatomic, assign)int commentsNum;//评论条数
@property (nonatomic, strong)NSString *userName;//发布者用户名称
@property (nonatomic, strong)NSString *userPicUrl;//发布者头像URL
@property (nonatomic, assign)BOOL isCollected;//收藏标志 0未收藏 1：收藏
@property (nonatomic, assign)BOOL isLiked;//点赞标志 0未点赞 1：点赞
@property (nonatomic, assign)int userId;//用户id

/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block;


/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block;

@end

@interface BN_HomeSpotsList : NSObject

@property (nonatomic, assign)long allSpotsId;//场景ID
@property (nonatomic, assign)int allSpotsType;//	1.美食 2.民宿 3景点
@property (nonatomic, strong)NSString *allSpotsName;//场景名称
@property (nonatomic, strong)NSString *allSpotsPicUrl;//场景图片
@property (nonatomic, assign)int likeNum;//点赞次数
@property (nonatomic, assign)int commentsNum;//评论条数
@property (nonatomic, strong)NSString *price;//价格
@property (nonatomic, assign)BOOL isCollected;//收藏标志 0未收藏 1：收藏
@property (nonatomic, assign)BOOL isLiked;//点赞标志 0未点赞 1：点赞


/**
 3.1.5 收藏

 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block;


/**
 点赞

 @param block 回调函数
 */
- (void)like:(void (^)(NSError *error))block;

@end

@interface BN_HomeNotices : NSObject

@property (nonatomic, assign)long noticesId;//主键
@property (nonatomic, strong)NSString *title;//标题
@property (nonatomic, strong)NSString *content;//内容

@end




@interface LBB_HomeViewModel : NSObject

//首页广告
@property (nonatomic, strong)NSMutableArray<BN_HomeAdvertisement*> *advertisementArray;
//热门推荐广告
@property (nonatomic, strong)NSMutableArray<BN_HomeAdvertisement*> *spotAdvertisementArray;
//公告
@property (nonatomic, strong)NSMutableArray<BN_HomeNotices*> *noticesArray;
//热门推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *spotsArray;
//游记推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeTravelNotes*> *travelNotesArray;

//达人景点推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *scenicSpotsArray;
//达人美食推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *footSpotsArray;
//达人民宿推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *liveSpotsArray;
//广场中心
@property (nonatomic, strong)NSMutableArray<BN_HomeUgcList *> *ugcArray;

@property (nonatomic,strong)BN_HomeUgcList *model;
@property(nonatomic,assign)NetLoadEvent modelEvent;

/**
 3.1.2 广告轮播 1.首页最顶部

 @param clear 是否清空原数据
 */
- (void)getAdvertisementListArrayClearData:(BOOL)clear;

/**
 3.1.2 广告轮播 5.首页热门推荐
 
 @param clear 是否清空原数据
 */
- (void)getSpotAdvertisementListArrayClearData:(BOOL)clear;

/**
 3.1.3 公告轮播

 @param clear 是否清空原数据
 */
- (void)getNoticesArrayClearData:(BOOL)clear;

/**
 3.1.4 热门推荐
 
 @param clear 是否清空原数据
 */
- (void)getSpotsArrayClearData:(BOOL)clear;


/**
 3.1.7 游记推荐

 @param clear 是否清空原数据
 */
- (void)getTravelNotesArrayClearData:(BOOL)clear;


/**
 3.1.8 达人推荐

 @param Type 1.景点 2.美食 3.民宿
 */
- (void)getSpotsArrayWithType:(NSInteger)Type;


/**
 3.1.9 广场中心

 @param clear 是否清空原数据
 */
- (void)getUgcArrayClearData:(BOOL)clear;

@end
