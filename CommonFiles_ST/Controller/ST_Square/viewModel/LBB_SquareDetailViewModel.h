//
//  LBB_SquareDetailViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//
#import <BN_BaseDataModel.h>
#import "LBB_UserShowViewModel.h"

@interface LBB_SquareComments : BN_BaseDataModel

@property (nonatomic, assign)long commentId ;// 评论ID
@property (nonatomic, strong)NSString *userName ;// 用户名称
@property (nonatomic, strong)NSString *remark ;// 评论内容

@end

@interface LBB_SquareLikeList : BN_BaseDataModel

@property (nonatomic, assign)long likeId ;// 标签ID
@property (nonatomic, assign)long userId ;// 用户ID
@property (nonatomic, strong)NSString *portrait ;// 头像

@end

@interface LBB_SquarePics : BN_BaseDataModel

@property (nonatomic, assign)long picId ;// 图片ID
@property (nonatomic, strong)NSString *imageUrl ;// 图片url
@property (nonatomic, strong)NSMutableArray<LBB_SquareTags*> *tags ;// 图片标签

@end

@interface LBB_SquareDetailViewModel : BN_BaseDataModel

@property (nonatomic,assign)long ugcId ;// 主键
@property (nonatomic, strong)NSString *shareUrl ;// 分享URL
@property (nonatomic, strong)NSString *shareTitle ;// 分享标题
@property (nonatomic, strong)NSString *shareContent ;// 分享内容
@property (nonatomic, assign)int type ;// 1.照片 2.视频
@property (nonatomic, strong)NSString *videoUrl ;// 视频地址(类型为2)
@property (nonatomic,assign)long userId ;// 用户ID
@property (nonatomic, strong)NSString *userName ;// 用户名称
@property (nonatomic, strong)NSString *userPicUrl ;// 用户头像
@property (nonatomic, strong)NSString *createTime ;// 创建时间
@property (nonatomic, strong)NSString *timeDistance ;// 时间距离
@property (nonatomic,assign)long allSpotsId ;// 场景ID
@property (nonatomic, strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic, strong)NSMutableArray<LBB_SquarePics *> *pics ;// 图片集合
@property (nonatomic, strong)NSMutableArray<LBB_SquareTags *> *tags ;// 视频标签
@property (nonatomic, assign)int picNum ;// 图片总数
@property (nonatomic, strong)NSString *picsRemark ;// 图片描述
@property (nonatomic, strong)NSString *videoRemark ;// 视频描述
@property (nonatomic, assign)int likeNum ;// 点赞次数
@property (nonatomic, assign)int isLiked ;// 是否点赞
@property (nonatomic, strong)NSMutableArray<LBB_SquareLikeList *> *likeList ;// 点赞集合
@property (nonatomic, assign)int isCollected ;// 是否收藏
@property (nonatomic, strong)NSMutableArray<LBB_SquareComments *> *comments ;// 评论集合

@end
