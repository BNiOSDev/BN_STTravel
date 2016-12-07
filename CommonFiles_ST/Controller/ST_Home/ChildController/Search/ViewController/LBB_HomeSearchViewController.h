//
//  LBB_HomeSearchViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
typedef NS_ENUM(NSInteger, LBBPoohHomeSearchType) {
    LBBPoohHomeSearchTypeGoods = 0,//伴手礼
    LBBPoohHomeSearchTypeScenic,//景点
    LBBPoohHomeSearchTypeFoods,//美食
    LBBPoohHomeSearchTypeHostel,//民宿
    LBBPoohHomeSearchTypeUser,//用户
    LBBPoohHomeSearchTypeSquare,//广场
    LBBPoohHomeSearchTypeTravel,//游记
    LBBPoohHomeSearchTypeDefault,//默认

};
@interface LBB_HomeSearchViewController : Base_BaseViewController

@property(nonatomic, assign)LBBPoohHomeSearchType searchType;
@property(nonatomic, strong)ClickBlockEx click;

@end
