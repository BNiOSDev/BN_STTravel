//
//  LBB_MyPhotoModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine_Common.h"

@interface LBB_MyPhotoModel : BN_BaseDataModel

@property (nonatomic, assign) long  ugcId;//明细主键
@property (nonatomic, copy) NSString  *coverImageUrl;//封面图片
@property (nonatomic, assign) int    isLiked;//是否点赞
@property (nonatomic, assign) int    isCollected;//是否收藏
@property (nonatomic, assign) int     totalLike;//赞数
@property (nonatomic, assign) int     totalComment;//评论数

/**
 * 还没提供 我的-广场图片/视频删除（已测）
 */
- (void)deleteMyPhoto;


@end

@interface LBB_MyPhotoViewModel : BN_BaseDataModel


@property(nonatomic,strong) NSMutableArray<LBB_MyPhotoModel*>* photoArray;

/**
 *3.5.4 我的-广场图片列表（已测)
 *3.5.13 我的-收藏 广场 照片（已测）
 */
- (void)getMyPhotoList:(BOOL)isClear VidewType:(MySquareViewType)videoType;

@end
