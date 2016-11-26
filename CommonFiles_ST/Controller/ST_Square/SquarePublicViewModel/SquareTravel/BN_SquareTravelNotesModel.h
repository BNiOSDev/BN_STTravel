//
//  LBB_SquareTravelDetailViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_TagsViewModel.h"

@interface TravelNotesPics : BN_BaseDataModel

@property(nonatomic, assign)long picId;//	Long	图片ID
@property(nonatomic, strong)NSString* imageUrl;//	String	图片url

@end


@interface TravelNotesDetails : BN_BaseDataModel

@property(nonatomic, assign)long travelNotesDetailId;//	Long	标签ID
@property(nonatomic, strong)NSArray<TravelNotesPics*>* pics;//	List	图片集合
@property(nonatomic, strong)NSString* picRemark;//	String	图片描述
@property(nonatomic, assign)int whitchDay;//	Int	第几天
@property(nonatomic, strong)NSString* releaseDate;//	String	发布日期
@property(nonatomic, strong)NSString* releaseTime;//	String	发布时间
@property(nonatomic, assign)int likeNum;//	Int	点赞次数
@property(nonatomic, assign)int commentsNum;//	Int	评论条数
@property(nonatomic, assign)int isLiked;//	int	点赞标志 0未点赞 1：点赞
@property(nonatomic, assign)long objId;//	Long	场景ID
@property(nonatomic, assign)int allSpotsType;//	int	场景类型
@property(nonatomic, strong)NSString* allSpotsTypeName;//	String	场景类型名称
@property(nonatomic, strong)NSString* name;//	String	名称
@property(nonatomic, strong)NSString* longitude;//	String	经度
@property(nonatomic, strong)NSString* dimensionality;//	String	纬度
@property(nonatomic, strong)NSString* billAmount;//	String	账单金额
@property(nonatomic, assign)int consumptionType;//	Int	消费类型 1 民宿 2 交通 3 美食 4 门票 5 娱乐 6 购物 7 其他
@property(nonatomic, strong)NSString* consumptionDesc;//	String	消费描述


@end

@interface BN_SquareTravelNotesModel : BN_BaseDataModel

@property(nonatomic, assign)long travelNotesId;//	Long	主键
@property(nonatomic, strong)NSString* name;//	String	游记名称
@property(nonatomic, strong)NSString* picUrl;//	String	游记封面
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



@end





