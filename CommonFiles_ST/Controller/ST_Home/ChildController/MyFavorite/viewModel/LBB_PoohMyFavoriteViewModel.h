//
//  LBB_PoohMyFavoriteViewModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

//我的-收藏 广场 景点/美食/民宿 列表
@interface LBB_PoohMyFavoriteModel : BN_BaseDataModel

@property(nonatomic,assign)long allSpotsId;//场景ID
@property(nonatomic,copy)NSString* allSpotsName;//场景名称
@property(nonatomic,copy)NSString* allSpotsPicUrl;//场景图片
@property(nonatomic,copy)NSString* detailedAddr;//地址
@property(nonatomic,copy)NSString* price;//价格
@property(nonatomic,assign)int isCollected;//	收藏标志 0未收藏 1：收藏

/**
 *3.1.4 收藏(已测)
 @parames allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题
 */

- (void)collect:(int)allSpotsType;

@end


@interface LBB_PoohMyFavoriteViewModel : BN_BaseDataModel


@property(nonatomic,strong)NSMutableArray<LBB_PoohMyFavoriteModel*> *favoriteArray;

/**
 *3.5.15 我的-收藏 广场 景点/美食/民宿 列表（已测）
 @parames allSpotsType	1.美食 2.民宿 3景点
 @parames isClear 是否清除缓存
 */
- (void)getPoohMyFavoriteData:(int)allSpotsType Clear:(BOOL)isClear;

@end


//我的-收藏 广场 景点/美食/民宿 专题列表
@interface LBB_PoohMyFavoriteSpecialModel : BN_BaseDataModel

@property(nonatomic,assign)long specialId;//主键
@property(nonatomic,copy)NSString* specialName;//名字
@property(nonatomic,copy)NSString* coverImg;//封面图片
@property(nonatomic,copy)NSString* content;//描述
@property(nonatomic,assign)int isCollected;//	收藏标志 0未收藏 1：收藏
 
/**
 *3.1.4 收藏(已测)
 @parames allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题
 */

- (void)collect:(int)allSpotsType;

@end

//我的-收藏 广场 景点/美食/民宿 专题
@interface LBB_PoohMyFavoriteSpecialViewModel : BN_BaseDataModel


@property(nonatomic,strong)NSMutableArray<LBB_PoohMyFavoriteSpecialModel*> *favoriteSpeciallArray;

/**
 *3.5.16 我的-收藏 广场 专题（已测）
 @parames allSpotsType	1.美食 2.民宿 3景点
 @parames isClear 是否清除缓存
 */
- (void)getPoohMyFavoriteSpecialData:(int)allSpotsType Clear:(BOOL)isClear;

@end


