//
//  PoohCommon.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#ifndef PoohCommon_h
#define PoohCommon_h


typedef void(^ClickBlock)(id object);
typedef void(^ClickBlockEx)(id object, id param);
typedef void(^ClickBlockThree)(id object, id param1,id param2);
typedef void(^ClickBlockFour)(id object, id param1,id param2, id param3);


//#import <UIKit/UIKit.h>
#import <BlocksKit/BlocksKit.h>
#import <Masonry/Masonry.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <GLPubSub/NSObject+GLPubSub.h>
#import <UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "PoohAppHelper.h"

#import "NSString+PoohCommon.h"
#import "UIColor+PoohCommon.h"
#import "NSObject+PoohCommon.h"
#import "UILabel+Common.h"

#import "IConstants.h"
#import "UIView+FRCategory.h"
#import "SDAutoLayout.h"
#import "HMSegmentedControl.h"
#import "UINavigationBar+Awesome.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height

#define PlaceHolderImage @"poohtest"
#define SeparateLineWidth 1

//屏幕适配
#define FB_FIX_SIZE_WIDTH(w) (((w) / 320.0) * DeviceWidth)
//获取当前app版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
//获取适配后的数据大小
#define AutoSize(num)  num * (DeviceWidth /320.0)


typedef NS_ENUM(NSInteger, LBBPoohTicketStatus) {
    LBBPoohTicketStatusWaitPay = 0,//等待付款
    LBBPoohTicketStatusWaitCollect,//等待取票
    LBBPoohTicketStatusCollected,//已取票
    LBBPoohTicketStatusRefunded,//已退款    
};

#endif /* PoohCommon_h */
