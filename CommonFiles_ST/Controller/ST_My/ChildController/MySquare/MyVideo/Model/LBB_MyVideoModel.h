//
//  LBB_MyVideoModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine_Common.h"

@interface LBB_MyVideoTagModel : BN_BaseDataModel

@property (nonatomic, assign) long  tagId;
@property (nonatomic, copy) NSString  *tagName;

@end

@interface LBB_MyVideoModel : BN_BaseDataModel

@property (nonatomic, assign) long  ugcId;//明细主键
@property (nonatomic, copy) NSString  *videoUrl;//封面图片
@property (nonatomic, assign) int    isLiked;//是否点赞
@property (nonatomic, assign) int    isCollected;//是否收藏
@property (nonatomic, assign) int     totalLike;//赞数
@property (nonatomic, assign) int     totalComment;//评论数
@property (nonatomic, strong)NSMutableArray<LBB_MyVideoTagModel *> *tags ;// 视频标签

/**
 *3.5.5 我的-广场图片/视频删除（已测）
 */
- (void)deleteMyVideo;

@end


@interface LBB_MyVideoViewModel : BN_BaseDataModel

@property (nonatomic, strong) NSMutableArray<LBB_MyVideoModel*> *videoArray;

/**
 *3.5.3 我的-广场视频列表（已测）
 *3.5.14 我的-收藏 广场 视频（已测）
 */
- (void)getMyVideoList:(BOOL)isClear VidewType:(MySquareViewType)videoType;

@end
