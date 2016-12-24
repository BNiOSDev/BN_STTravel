//
//  LBB_SpotDetailsViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SquareDetailViewModel.h"
@interface LBB_SpotsCommentsRecordPics : NSObject

@property(nonatomic, strong)NSString *imageUrl ;// URL
@property(nonatomic, assign)long picId;//	Long	图片ID
@end

@interface LBB_SpotsCommentsRecord : NSObject

@property(nonatomic, assign)long commentId ;// 主键
@property(nonatomic, strong)NSString *remark ;// 评论描述
@property(nonatomic, strong)NSMutableArray<LBB_SpotsCommentsRecordPics*> *pics ;// 评论图片集合
@property(nonatomic, strong)NSString *commentDate ;// 评论日期
@property(nonatomic, assign)int commentsNum ;// 评论条数
@property(nonatomic, assign)long userId ;// 发布者Id
@property(nonatomic, strong)NSString *userName ;// 发布者用户名称
@property(nonatomic, strong)NSString *userPicUrl ;// 发布者头像URL

@end

@interface LBB_SpotsAllCommentsRecord : NSObject //所有评论

@property(nonatomic, assign)long commentId;//	Long	评论ID
@property(nonatomic, assign)long userId;//	Long	主键
@property(nonatomic, strong)NSString *userName;//	String	收藏用户名称
@property(nonatomic, strong)NSString *userPicUrl;//	String	收藏头像URL
@property(nonatomic, assign)int scores;//	int	评分
@property(nonatomic, strong)NSString *remark;//	String	评语
@property(nonatomic, strong)NSMutableArray<LBB_SpotsCommentsRecordPics*> *pics;//	List	评论图片
@property(nonatomic, strong)NSString *commentDate;//	String	创建时间
@property(nonatomic, strong)NSMutableArray<LBB_SquareComments*> *comments;//	List	评论


@end

@interface LBB_SpotsCollectedRecord : NSObject

@property(nonatomic, assign)long userId ;// 主键
@property(nonatomic, strong)NSString *userName ;// 收藏用户名称
@property(nonatomic, strong)NSString *userPicUrl ;// 收藏头像URL

@end

@interface LBB_SpotsFacilities : NSObject

@property(nonatomic, assign)long tagId ;// 主键
@property(nonatomic, strong)NSString *tagName ;// 设施名称

@end

@interface LBB_SpotsTag : NSObject

@property(nonatomic, assign)long tagId ;// 主键
@property(nonatomic, strong)NSString *name ;// 标签名称

@end

@interface LBB_SpotsUgc : BN_BaseDataModel

@property(nonatomic, assign)long ugcId ;// 主键
@property(nonatomic, assign)int ugcType ;// 1.照片 2.视频
@property(nonatomic, strong)NSString *ugcVideoUrl ;// 视频地址
@property(nonatomic, strong)NSString *ugcPicUrl ;// 封面图片地址
@property(nonatomic, assign)int likeNum ;// 点赞次数
@property(nonatomic, assign)int commentsNum ;// 评论条数
@property(nonatomic, strong)NSString *userName ;// 发布者用户名称
@property(nonatomic, strong)NSString *userPicUrl ;// 发布者头像URL
@property(nonatomic, assign)BOOL isCollected ;// 是否收藏 0否 1是
@property(nonatomic, assign)BOOL isLiked ;// 是否点赞 0否 1是
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

@interface LBB_PurchaseRecords : BN_BaseDataModel

@property(nonatomic, assign)long purchaseId ;// 主键
@property(nonatomic, strong)NSString *showContent ;// 显示内容 （最新的订单来之XX，YY前） XX代表用户名称 YY代表时间如：3秒、3分钟、3小时、3天
@end

@interface LBB_SpotsPics : BN_BaseDataModel

@property(nonatomic, assign)long picId ;// 主键
@property(nonatomic, strong)NSString *imageUrl ;// 图片地址(绝对地址)

@end

@interface LBB_SpotsNearbyRecommendData : BN_BaseDataModel

@property(nonatomic, assign)long allSpotsId ;// 场景ID
@property(nonatomic, assign)long allSpotsType ;// 场景类型
@property(nonatomic, strong)NSString *allSpotsName ;// 场景名称
@property(nonatomic, strong)NSString *picUrl ;// 场景图片
@property(nonatomic, strong)NSString *picRemark ;// 场景图片描述
@property(nonatomic, strong)NSString *realPrice ;// 价格(实际价格)
@property(nonatomic, strong)NSMutableArray<LBB_SpotsTag*> *tags ;// 标签集合

@end

@interface LBB_SpotDetailsViewModel : BN_BaseDataModel

@property(nonatomic, assign)long allSpotsId ;// 场景ID
@property (nonatomic,assign)long allSpotsType ;// 场景类型
@property(nonatomic, strong)NSMutableArray<LBB_SpotsPics*> *allSpotsPics ;// 场景图片集合
//@property(nonatomic, strong)NSMutableArray<LBB_PurchaseRecords*> *purchaseRecords ;// 最近6条购买记录
@property(nonatomic, strong)NSString *purchaseRecords ;// 最近6条购买记录

@property(nonatomic, assign)BOOL isCollected ;// 收藏标志 0未收藏 1：收藏
@property(nonatomic, strong)NSString *shareUrl ;// 分享URL
@property(nonatomic, strong)NSString *shareTitle ;// 分享标题
@property(nonatomic, strong)NSString *shareContent ;// 分享内容
@property(nonatomic, strong)NSString *allSpotsName ;// 场景名称
@property(nonatomic, strong)NSString *realPrice ;// 价格(实际价格)
@property(nonatomic, assign)BOOL isSigned ;// 签到标识 0未签到 1：签到
@property(nonatomic, assign)BOOL isLiked ;// 点赞标志 0未点赞 1：点赞
@property(nonatomic, assign)int likeNum ;// 点赞次数
@property(nonatomic, assign)int commentsNum ;// 评论条数
@property(nonatomic, assign)int collecteNum ;// 收藏次数
@property(nonatomic, strong)NSString *phoneNoRemark ;// 电话描述
@property(nonatomic, strong)NSString *phoneNo ;// 联系电话
@property(nonatomic, strong)NSString *address ;// 地址
@property(nonatomic, strong)NSString *longitude ;// Y坐标
@property(nonatomic, strong)NSString *dimensionality ;// X坐标
@property(nonatomic, strong)NSMutableArray<LBB_SpotsUgc*> *ugc ;// 视频记录
@property(nonatomic, strong)NSString *recommendedReason ;// 推荐理由
@property(nonatomic, strong)NSString *details ;// 详情
@property(nonatomic, strong)NSMutableArray<LBB_SpotsTag*> *tags ;// 标签
@property(nonatomic, strong)NSMutableArray<LBB_SpotsFacilities*> *facilities ;// 设施
@property(nonatomic, strong)NSString *warmPrompt ;// 温馨提示
@property(nonatomic, assign)int isAdvanceReturn ;// 是否提前1天退货 0：否 1：是
@property(nonatomic, assign)int isMakeAppointment ;// 是否需要预约 0：否 1：是
@property(nonatomic, strong)NSMutableArray<LBB_SpotsCollectedRecord*> *collectedRecord ;// 收藏记录（具体几个后台控制）
@property(nonatomic, strong)NSMutableArray<LBB_SpotsCommentsRecord*> *commentsRecord ;// 评论记录（具体几个后台控制）

@property(nonatomic, strong)NSMutableArray<LBB_SpotsNearbyRecommendData*> *nearbySpotRecommends;
@property(nonatomic, strong)NSMutableArray<LBB_SpotsNearbyRecommendData*> *nearbyFoodRecommends;
@property(nonatomic, strong)NSMutableArray<LBB_SpotsNearbyRecommendData*> *nearbyHostelRecommends;



@property(nonatomic, strong)NSMutableArray<LBB_SpotsAllCommentsRecord*> *allCommentsRecord ;// 所有评论记录（具体几个后台控制）

/**
 3.2.8	周边推荐(已测)

 @param type 1.景点 2.美食 3.民宿
 @param clear 是否清空原数据
 */
- (void)getSpotNearbyRecommendsType:(int)type
                          clearData:(BOOL)clear;

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


/**
3.1.14 评论列表(已测)
 type	int	1美食 2 民宿 3 景点 4 伴手礼 5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略
 11 美食专题 12民宿专题 13景点专题 14伴手礼专题
 objId	Long	对象主键

 @param clear 是否清空原数据
 */
- (void)getSpotAllRecommendsType:(BOOL)clear;

@end


@interface LBB_SpotSpecialRecommendSpecials : NSObject

@property(nonatomic, assign)long specialId;//	Long	主键
@property(nonatomic, assign)int type;//	Int	1美食 2 民宿 3 景点  4 伴手礼
@property(nonatomic, strong)NSString *name;//	String	名称
@property(nonatomic, strong)NSString *coverImagesUrl;//	String	封面图片
@property(nonatomic, strong)NSMutableArray<LBB_SpotsTag*> *tags;//	List	标签列表

@end

@interface LBB_SpotSpecialList : NSObject

@property(nonatomic, assign)long relId;//	Long	专题与对象关系ID
@property(nonatomic, assign)int type;//	int	对象类型 1美食 2 民宿 3 景点  4 伴手礼
@property(nonatomic, assign)long objId;//	Long	对应的对象ID 如类型是景点,则本ID为关联的景点id
@property(nonatomic, strong)NSString *titleDisplay;//	String	显示标题
@property(nonatomic, strong)NSString *viceTitleDisplay;//	String	副显示标题
@property(nonatomic, strong)NSString *imageUrl1;//	图片1
@property(nonatomic, strong)NSString *imageUrl2;//	图片2
@property(nonatomic, strong)NSString *contentDisplay;//	String	显示内容富文本
@property(nonatomic, assign)int likeNum;//	Int	点赞次数
@property(nonatomic, assign)int commentsNum;//	Int	评论条数
@property(nonatomic, assign)int collecteNum;//	Int	收藏次数
@property(nonatomic, assign)int isCollected;//	int	收藏标志 0未收藏 1：收藏
@property(nonatomic, assign)int isLiked;//	int	点赞标志 0未点赞 1：点赞

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

@interface LBB_SpotSpecialDetailsModel : BN_BaseDataModel //专题详情页

@property(nonatomic, assign)long specialId;//	Long	专题ID
@property (nonatomic,assign)long type;//	Int	1美食 2 民宿 3 景点  4 伴手礼
@property(nonatomic, strong)NSString *name;//	String	名称
@property(nonatomic, strong)NSString *content;//	String	专题描述 为纯文本
@property(nonatomic, strong)NSString *coverImagesUrl;//	String	封面图片
@property(nonatomic, strong)NSString *shareUrl;//	String	分享URL
@property(nonatomic, strong)NSString *shareTitle;//	String	分享标题
@property(nonatomic, strong)NSString *shareContent;//	String	分享内容
@property(nonatomic, assign)int isCollected;//	int	收藏标志 0未收藏 1：收藏
@property(nonatomic, assign)int collecteNum;//	Int	收藏次数
@property(nonatomic, strong)NSMutableArray<LBB_SpotsTag*> *tags;//	List	标签列表
@property(nonatomic, strong)NSMutableArray<LBB_SpotsCollectedRecord*> *collectedRecord;//	List	收藏记录（具体几个后台控制）
@property(nonatomic, strong)NSMutableArray<LBB_SpotsCommentsRecord*> *commentsRecord;//	List	评论记录（具体几个后台控制）
@property(nonatomic, strong)NSMutableArray<LBB_SpotSpecialRecommendSpecials*> *recommendSpecials;//	List	推荐专题


/**
 3.1.5 收藏
 
 @param block 回调函数
 */
- (void)collecte:(void (^)(NSError *error))block;


@end



@interface LBB_SpotModel : BN_BaseDataModel

@property (nonatomic,assign)long allSpotsId ;// 场景ID
@property (nonatomic,assign)long allSpotsType ;// 场景类型
@property (nonatomic,strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic,strong)NSString *picUrl ;// 场景图片
@property (nonatomic,strong)NSString *picRemark ;// 场景图片描述
@property (nonatomic,assign)double distance ;// 距离 (单位km)
@property (nonatomic,assign)int likeNum ;// 点赞次数
@property (nonatomic,assign)int commentsNum ;// 评论条数
@property (nonatomic,strong)NSString *standardPrice ;// 原价
@property (nonatomic,strong)NSString *realPrice ;// 实际价格
@property (nonatomic,assign)BOOL isCollected ;// 收藏标志 0未收藏 1：收藏
@property (nonatomic,assign)BOOL isLiked ;// 点赞标志 0未点赞 1：点赞
@property (nonatomic,strong)NSMutableArray<LBB_SpotsTag*> *tags ;// 标签
@property (nonatomic,strong)NSString* dimensionality;//维度
@property (nonatomic,strong)NSString* longitude;//精度
@property (nonatomic,strong)NSString* address;//地址



@property (nonatomic,strong)LBB_SpotDetailsViewModel *spotDetails;



/**
 3.2.7	景点/美食/民宿详情(已测)
 */
- (void)getSpotDetailsData:(BOOL)clear;


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


//专题详情页的
@interface LBB_SpotSpecialDetailsViewModel : BN_BaseDataModel


@property(nonatomic, assign)long specialId;//	Long	专题ID


@property (nonatomic,strong)LBB_SpotSpecialDetailsModel *spotSpecialDetails;//专题内容详情

@property (nonatomic,strong)NSMutableArray<LBB_SpotSpecialList*> *spotSpecialList ;// 专题内容列表

/**
 3.2.9 专题详情(已测)
 */
- (void)getSpotSpecialDetailsData;

/**
 3.2.10 专题列表内容(已测)
 */
- (void)getSpotSpecialListArray:(BOOL)clear;

@end
