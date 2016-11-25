//
//  LBB_TagsViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <BN_BaseDataModel.h>

@class LBB_TagsViewModel;
@class LBB_SquareTags;
@class LBB_UserShowViewModel;

@interface LBB_TagUserObj : BN_BaseDataModel

@property (nonatomic, assign)long objId ;// 对象主键
@property (nonatomic, assign)int actionType ;// 5 ugc图片 6 ugc视频 7 游记
@property (nonatomic, strong)NSString *picUrl ;// 图片地址

@end

@interface LBB_TagUser : BN_BaseDataModel

@property (nonatomic, assign)long userId ;// 用户ID
@property (nonatomic, strong)NSString *userName ;// 用户名称
@property (nonatomic, strong)NSString *userPicUrl ;// 用户头像
@property (nonatomic, assign)int photoNum ;// 照片数量
@property (nonatomic, assign)int auditState ;// 用户认证状态：0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property (nonatomic, strong)NSMutableArray *objs ;// 对象列表

@property (nonatomic, strong)LBB_UserShowViewModel *userShowViewModel;

/**
 3.4.6	广场-广场主页-个人主页（添加导游部分、未开发）
 */
- (void)getUserShowViewModelData;

@end

@interface LBB_TagShowViewData : BN_BaseDataModel

@property (nonatomic, assign)int actionType ;// 5 ugc图片 6 ugc视频 7 游记 11 广告
@property (nonatomic, assign)long objId ;// 对象主键
@property (nonatomic, strong)NSString *picUrl ;// 图片地址
@property (nonatomic, strong)NSMutableArray<LBB_SquareTags*> *tags ;// 标签
@property (nonatomic, assign)int adClasses ;// 1 外部连接 2 列表 3 详情
@property (nonatomic, assign)int adType ;// 1.美食 2.民宿  3.景点 4伴手礼
@property (nonatomic, strong)NSString *adPicDestUrl ;// 外部链接地址

@end

@interface LBB_SquareTags : BN_BaseDataModel

@property (nonatomic, assign)long tagId ;// 标签ID
@property (nonatomic, strong)NSString *tagName ;// 标签名称

@property (nonatomic, strong)LBB_TagsViewModel *tagsViewModel;
@property (nonatomic, strong)NSMutableArray<LBB_TagShowViewData *> *showImageHotArray;//标签图热门排序
@property (nonatomic, strong)NSMutableArray<LBB_TagShowViewData *> *showImageTimeArray;//标签图时间排序


/**
 1.1.1	广场-广场主页-标签主页-列表（已测）

 */
- (void)getTagsViewModelData;

/**
 3.4.11	广场-广场主页-标签主页-列表（已测）
 
 
 @param type 标签类型 1：热门排序 2：时间排序
 @param clear 清空原数据
 */
- (void)getShowImageArrayOrderType:(int)type ClearData:(BOOL)clear;

@end

@interface LBB_TagsViewModel : BN_BaseDataModel

@property (nonatomic, strong)NSString *tagName ;// 标签名字
@property (nonatomic, strong)NSString *picUrl ;// 标签图片
@property (nonatomic, strong)NSString *shareTitle ;// 分享标题
@property (nonatomic, strong)NSString *shareContent ;// 分享内容
@property (nonatomic, assign)int photoNum ;// 照片数量
@property (nonatomic, strong)NSMutableArray<LBB_SquareTags*> *tags ;// 关联标签



@end
