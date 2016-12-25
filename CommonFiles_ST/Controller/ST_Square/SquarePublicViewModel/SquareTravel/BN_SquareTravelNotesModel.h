//
//  LBB_SquareTravelDetailViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_TagsViewModel.h"
#import "BN_SquareTravelNotesBillModel.h"
#import "LBB_SquareAddressViewModel.h"
#import "LBB_SquareDetailViewModel.h"

@interface TravelNotesPics : BN_BaseDataModel

@property(nonatomic, assign)long picId;//	Long	图片ID
@property(nonatomic, strong)NSString* imageUrl;//	String	图片url

@end

@interface BN_TravelNotesDetailsComments : BN_BaseDataModel

@property(nonatomic, assign)long travelNotesDetailId ;// 足记ID
@property(nonatomic, strong)NSString* shareUrl ;// 分享URL
@property(nonatomic, strong)NSString* shareTitle ;// 分享标题
@property(nonatomic, strong)NSString* shareContent ;// 分享内容
@property(nonatomic, strong)NSArray<TravelNotesPics*>* pics ;// 图片集合
@property(nonatomic, strong)NSString* picRemark ;// 图片描述
@property(nonatomic, strong)NSString* releaseDate ;// 发布日期
@property(nonatomic, strong)NSString* releaseTime ;// 发布时间
@property(nonatomic, assign)long objId ;// 场景ID
@property(nonatomic, assign)int allSpotsType ;// 场景类型
@property(nonatomic, strong)NSString* allSpotsTypeName ;// 场景类型名称
@property(nonatomic, assign)int isLiked ;// 是否点赞
@property(nonatomic, assign)int likeNum ;// 点赞数
@property(nonatomic, strong)NSArray<LBB_SquareLikeList*>* likeList ;// 点赞集合
@property(nonatomic, assign)int commentsNum ;// 评论数
@property(nonatomic, strong)NSArray<LBB_SquareComments*>* comments ;// 评论集合

@end


@interface TravelNotesDetails : BN_BaseDataModel

@property(nonatomic, assign)long travelNotesDetailId;//	Long	标签ID
@property(nonatomic, strong)NSArray<TravelNotesPics*>* pics;//	List	图片集合
@property(nonatomic, strong)NSString* picRemark;//	String	图片描述
@property(nonatomic, strong)NSString* picUrl;//	String	图片描述

@property(nonatomic, assign)int whitchDay;//	Int	第几天
@property(nonatomic, strong)NSString* releaseDate;//	String	发布日期 发布日期格式: 2016-11-15

@property(nonatomic, strong)NSString* releaseTime;//	String	发布时间发布时间格式 20:30

@property(nonatomic, assign)int likeNum;//	Int	点赞次数
@property(nonatomic, assign)int commentsNum;//	Int	评论条数
@property(nonatomic, assign)int isLiked;//	int	点赞标志 0未点赞 1：点赞
@property(nonatomic, assign)long objId;//	Long	场景ID，就是选择的地址id
@property(nonatomic, assign)int allSpotsType;//	int	场景类型 1美食 2 民宿 3 景点
@property(nonatomic, strong)NSString* allSpotsTypeName;//	String	场景类型名称
@property(nonatomic, strong)NSString* name;//String	名称
@property(nonatomic, strong)NSString* longitude;//	String	经度
@property(nonatomic, strong)NSString* dimensionality;//	String	纬度
@property(nonatomic, strong)NSString* billAmount;//	String	账单金额
@property(nonatomic, assign)int consumptionType;//	Int	消费类型 1 民宿 2 交通 3 美食 4 门票 5 娱乐 6 购物 7 其他
@property(nonatomic, strong)NSString* consumptionDesc;//	String	消费描述

/**
 3.4.29	主页-足记评论（已测)
 */
@property(nonatomic, strong)BN_TravelNotesDetailsComments *travelNotesDetailsComments;
-(void)getTravelNotesDetailsCommentsModel;


/**
  3.4.24 主页-足记保存（已测）

 @param isAdd YES:新增足迹  NO:修改足迹
 @param spotAddress 选择地址回调的地址内容
 @param travelNoteId 草稿的游记id
 @param block 结果回调
 */

-(void)saveTravelTrackData:(BOOL)isAdd
              travelNoteId:(long)travelNoteId
                   address:(LBB_SpotAddress*)spotAddress
                     block:(void (^)(NSError *error))block;


/**
 3.4.26 主页-足记删除（已测）

 @param block 结果回调
 */
-(void)deleteTravelTrackData:(void (^)(NSError *error))block;


/**
 点赞
 
 @param block 回调函数
 */
- (void)like:(void (^)(NSDictionary*dic, NSError *error))block;


@end

//3.4.17 主页-游记详情/游记下载（已测）
@interface BN_SquareTravelNotesModel : BN_BaseDataModel

@property(nonatomic, assign)long travelNotesId;//	Long	主键
@property(nonatomic, strong)NSString* name;//	String	游记名称
@property(nonatomic, strong)NSString* picUrl;//	String	游记封面
@property(nonatomic, strong)NSString* picRemark;//	String	游记封面备注

@property(nonatomic, assign)int displayState;//	查看状态 1公开游记 2好友可见 3 自己可见

@property(nonatomic, assign)long userId;//	Long	用户ID
@property(nonatomic, strong)NSString* userName;//	String	用户名称
@property(nonatomic, strong)NSString* userPicUrl;//	String	用户头像
@property(nonatomic, strong)NSArray<LBB_SquareTags*>* tags;//	List	标签
@property(nonatomic, strong)NSString*lastReleaseTime;//	String	发表日期
@property(nonatomic, assign)long totalPageViews;//	Long	浏览数量
@property(nonatomic, strong)NSString* shareUrl;//	String	分享URL
@property(nonatomic, strong)NSString* shareTitle;//	String	分享标题
@property(nonatomic, strong)NSString* shareContent;//	String	分享内容
@property(nonatomic, assign)int totalScenicSpots;//	Int	景点个数
@property(nonatomic, assign)int totalFood;//	Int	美食个数
@property(nonatomic, assign)int totalHomestay;//	Int	民宿个数
@property(nonatomic, assign)int totalShop;//	Int	购物个数
@property(nonatomic, assign)int travelDayCount;//	Int	旅行天数
@property(nonatomic, strong)NSArray<TravelNotesDetails*>* travelNotesDetails;//	List	足记列表
@property(nonatomic, assign)int isLiked;//	int	是否点赞
@property(nonatomic, assign)int totalLike;//	Int	点赞数
@property(nonatomic, assign)int totalComment;//	Int	评论数
@property(nonatomic, assign)int isCollected;//	int	是否收藏
@property(nonatomic, assign)int totalCollected;//	Int	收藏数

/**
 3.4.18 主页-游记账单（已测）
 */
@property(nonatomic, strong)BN_SquareTravelNotesBillModel* travelBillModel;
-(void)getTravelBilllModel;

@end





