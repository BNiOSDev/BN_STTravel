//
//  Header.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <UIImageView+WebCache.h>

//使用宏定义16进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕适配
#define FB_FIX_SIZE_WIDTH(w) (((w) / 320.0) * UISCREEN_WIDTH)
#define SET_FIX_SIZE_WIDTH (UISCREEN_WIDTH /320.0)
//获取当前app版本
#define IOS_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
//获取适配后的数据大小
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

#define LRViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define DEFAULTIMAGE                  [UIImage imageNamed:@""]
#define FONT(x)                               [UIFont systemFontOfSize:x]
#define LINECOLOR                        UIColorFromRGB(0xE0E0E0)


typedef void(^ClickBlockForControl)(id object, id param);

#endif /* Header_h */
