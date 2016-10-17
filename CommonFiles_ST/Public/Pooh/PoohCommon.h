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

#import "NSString+PoohCommon.h"
#import "UIColor+PoohCommon.h"
#import "NSObject+PoohCommon.h"
#import "UIConstants.h"
#import "IConstants.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height




#endif /* PoohCommon_h */
