//
//  LBB_DiscoveryViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_DiscoveryDetailModel : BN_BaseDataModel

@property (nonatomic, assign)long lineId ;// 路线ID
@property (nonatomic, strong)NSString *name ;// 标题
@property (nonatomic, strong)NSString *coverImagesUrl ;// 封面图片
@property (nonatomic, strong)NSString *lineTime ;// 线路时长 如:1日游
@property (nonatomic, assign)int totalFood ;// 美食个数
@property (nonatomic, assign)int totalHomestay ;// 民宿个数
@property (nonatomic, assign)int totalScenicSpots ;//景点个数
@property (nonatomic, strong)NSString *lineContent ;// 行程内容 为富文本
@property (nonatomic, strong)NSString *lineFeature ;// 路线特色 为富文本
@property (nonatomic, strong)NSString *shareUrl ;// 分享URL
@property (nonatomic, strong)NSString *shareTitle ;// 分享标题
@property (nonatomic, strong)NSString *shareContent ;// 分享内容
@property (nonatomic, assign)int isCollected ;// 收藏标志 0未收藏 1：收藏
@property (nonatomic, assign)int isLiked ;// 点赞标志 0未点赞 1：点赞
@property (nonatomic, assign)int likeNum ;// 点赞次数
@property (nonatomic, assign)int commentsNum ;// 评论条数
@property (nonatomic, assign)int collecteNum ;// 收藏次数

@end

@interface LBB_DiscoveryModel : BN_BaseDataModel

@property (nonatomic, assign)long lineId ;// 路线ID
@property (nonatomic, strong)NSString *coverImageUrl ;// 列表上显示的图片
@property (nonatomic, strong)NSString *name ;// 标题
@property (nonatomic, strong)NSString *lineDesc ;// 列表上的描述

@property (nonatomic,strong)LBB_DiscoveryDetailModel *discoveryDetail;


/**
 3.3.5	攻略详情(已测)
 */
- (void)getDiscoveryDetailData;

@end

@interface LBB_DiscoveryViewModel : NSObject

@property (nonatomic, strong)NSMutableArray<LBB_DiscoveryModel *> *discoveryArray;

@property (nonatomic,strong)NSMutableArray<LBB_SquareSpots*> *squareSpotsArray;

/**
 3.4.26	主页-游记添加地址（已测）
 
 @param allSpotsType 1.美食 2.民宿 3景点(可为空)
 @param name 可为空 模糊查询
 @param clear 是否清空原数据
 */
- (void)getsTravelNotesDetailAllSpotsType:(int)allSpotsType name:(NSString *)name ClearData:(BOOL)clear;

- (void)getDiscoveryArrayClearData:(BOOL)clear;

@end
