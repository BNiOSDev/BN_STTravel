//
//  LBB_SearchViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SpotDetailsViewModel.h"
#import "LBB_UserShowViewModel.h"
#import "LBB_SquareViewModel.h"
#import "LBB_SquareTravelListViewModel.h"
@interface LBB_SearchHotWordModel : NSObject

@property(nonatomic, strong)NSString* name;

@end

@interface LBB_SearchSquareUgc : BN_BaseDataModel


@property (nonatomic, assign)long ugcId;//	Long	主键
@property (nonatomic, assign)int ugcType;//	Int	5：图片 6视频
@property (nonatomic, assign)long userId;//	Long	用户ID
@property (nonatomic, strong)NSString *userName;//	String	用户名称
@property (nonatomic, strong)NSString *userPicUrl;//	String	用户头像
@property (nonatomic, strong)NSString *remark;//	String	备注
@property (nonatomic, strong)NSString *videoUrl;//	String	视频地址(视频)
@property (nonatomic, strong)NSString *timeDistanceRemark;//距离时间秒速
@property (nonatomic, strong)NSMutableArray<LBB_SquarePics *> *pics;//	List	图片集合
@property (nonatomic, assign)long timeDistance;//	Long	时间距离(分)
@property (nonatomic, assign)long allSpotsId;//	Long	场景ID
@property (nonatomic, assign)int allSpotsType;//	Int	1.美食 2.民宿 3景点
@property (nonatomic, strong)NSString *allSpotsName;//	String	场景名称
@property (nonatomic, strong)NSMutableArray<LBB_SquareTags *> *tags;//	List	标签集合

@end

@interface LBB_SearchViewModel : NSObject

@property (nonatomic, strong)NSMutableArray<LBB_SearchHotWordModel*> *hotWordArray;
@property (nonatomic, strong)NSMutableArray<LBB_SpotModel*> *scenicSpotsArray;
@property (nonatomic, strong)NSMutableArray<LBB_SpotModel*> *foodSpotsArray;
@property (nonatomic, strong)NSMutableArray<LBB_SpotModel*> *hostelSpotsArray;

@property (nonatomic, strong)NSMutableArray<LBB_SearchHotWordModel*> *allSpotWordArray;//美食、景点、民宿的热词
@property (nonatomic, strong)NSMutableArray<LBB_SearchSquareUgc*> *ugcArray;//展示图片/视频数据列表
@property (nonatomic, strong)NSMutableArray<BN_SquareTravelList*> *travelNoteArray;//游记


@property (nonatomic, strong)NSMutableArray<LBB_UserOther*> *userArray;//搜索到的用户信息

/**
 3.6.1	搜索-热门搜索词汇（已测）
 */
- (void)getHotWordArray;


/**
 3.6.4	搜索-景点/美食/民宿（已测）

 @param longitude Y坐标
 @param dimensionality X坐标
 @param allSpotsType 1.美食 2.民宿 3景点
 @param name 搜索名称
 @param clear 清空原数据
 */
- (void)getAllSpotsArrayLongitude:(NSString *)longitude
                   dimensionality:(NSString *)dimensionality
                     allSpotsType:(int)allSpotsType
                             name:(NSString*)name
                        clearData:(BOOL)clear;



/**
 3.6.5 搜索-景点/美食/民宿 词汇（已测）

 @param allSpotsType 1.美食 2.民宿 3景点
 @param name         搜索名称
 */
- (void)getSearchAllSpotsWordsArrayWithType:(int)allSpotsType
                             name:(NSString*)name;


/**
 3.6.6 搜索-用户（已测）

 @param name   搜索名称
 @param clear 清空原数据
 */
-(void)getUserArrayName:(NSString*)name
              clearData:(BOOL)clear;


/**
 3.6.7 搜索-用户 词汇（已测）
 @param name 搜索名称
 */
- (void)getSearchUserWordsArray:(NSString*)name;

/**
 3.6.3 搜索-广场 词汇（已测）
 @param name 搜索名称
 */
- (void)getSearchSquareWordsArray:(NSString*)name;

/**
 3.6.2 搜索-广场（已测）
 @param name 搜索名称
 */
- (void)getSquareUgcArray:(NSString*)name
                clearData:(BOOL)clear;

/**
3.6.9 搜索-游记 词汇（已测）
 @param name 搜索名称
 */
- (void)getSearchTravelNotesWordsArray:(NSString*)name;

/**
 3.6.8 搜索-游记（已测）
 @param name 搜索名称
 */
- (void)getSquareTravelNoteArray:(NSString*)name
                clearData:(BOOL)clear;

@end
