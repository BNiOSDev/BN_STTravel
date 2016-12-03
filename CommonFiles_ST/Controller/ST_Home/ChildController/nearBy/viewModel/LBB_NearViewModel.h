//
//  LBB_NearViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <BN_BaseDataModel.h>
#import "LBB_SpotDetailsViewModel.h"
#import "LBB_SquareAddressViewModel.h"

@interface LBB_SignInUser : BN_BaseDataModel

@property (nonatomic,assign)long userId ;// 用户ID
@property (nonatomic,strong)NSString *userName ;// 用户名称
@property (nonatomic,strong)NSString *userPicUrl ;// 用户头像
@property (nonatomic,assign)long signInNum ;// 签到数

@end

@interface LBB_NearSignIn : BN_BaseDataModel

@property (nonatomic,assign)long allSpotsId ;// 场景ID
@property (nonatomic,assign)int allSpotsType ;// 1.美食 2.民宿 3景点
@property (nonatomic,strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic,strong)NSString *picUrl ;// 场景图片
@property (nonatomic,strong)NSString *signInTime ;// 签到时间

@end

@interface LBB_NearShopModel : BN_BaseDataModel

@property (nonatomic,assign)long allSpotsId ;// 场景ID
@property (nonatomic,strong)NSString *allSpotsName ;// 场景名称
@property (nonatomic,strong)NSString *longitude ;// Y坐标
@property (nonatomic,strong)NSString *dimensionality ;// X坐标
@property (nonatomic,assign)int isSignIn ;// 是否签到

@end

@interface LBB_NearViewModel : BN_BaseDataModel

@property (nonatomic,strong)NSMutableArray<LBB_SpotModel *> *foodsArray;
@property (nonatomic,strong)NSMutableArray<LBB_SpotModel *> *hostelArray;
@property (nonatomic,strong)NSMutableArray<LBB_SpotModel *> *spotArray;

@property (nonatomic,strong)NSMutableArray<LBB_NearShopModel *> *nearShopArray;
@property (nonatomic,strong)NSMutableArray<LBB_NearSignIn *> *nearSignInArray;
@property (nonatomic,assign)long signInNum;
@property (nonatomic,assign)int rank;
@property (nonatomic,strong)NSMutableArray<LBB_SignInUser *> *signInUserArray;

/**
 3.9.2	附近 –美食\名宿\景点列表(已测)

 @param longitude Y坐标
 @param dimensionality X坐标
 @param distance 距离多少范围以内(单位米)
 @param allSpotsType 1.美食 2.民宿 3景点
 @param clear 是否清空原数据
 */
- (void)getSpotArrayLongitude:(NSString *)longitude
               dimensionality:(NSString *)dimensionality
                     distance:(int)distance
                 allSpotsType:(int)allSpotsType
                    clearData:(BOOL)clear;



/**
 3.3.4	攻略列表(已测)

 @param lineTime 行程时间
 @param allSpots 场景列表
 @param tags 个性标签列表
 */
- (void)getNearShopArrayLineTime:(long)lineTime
                        allSpots:(NSArray<LBB_SpotsTag*>*)allSpots
                            tags:(NSArray<LBB_SpotAddress*>*)tags;


/**
 3.9.3	附近–签到列表(已测)

 @param clear 清空原数据
 */
- (void)getNearSignInArrayClearData:(BOOL)clear;


/**
 3.9.4	附近–签到信息(已测)
 */
- (void)getSignInfo;


/**
 3.9.5	附近–签到排名(已测)

 @param clear 清空原数据
 */
- (void)getSignInUserArrayClearData:(BOOL)clear;

@end
