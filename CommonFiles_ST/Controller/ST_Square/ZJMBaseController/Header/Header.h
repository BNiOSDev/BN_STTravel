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
#import <Masonry.h>
#import "UILabel+AutoFit.h"
#import "UIView+SDAutoLayout.h"
#import <MJRefresh/MJRefresh.h>
#import "BN_MapView.h"
#import "LBB_CommentViewModel.h"

typedef NS_ENUM(NSInteger, UITableViewCellViewSignal)
{
    UITableViewCellPraise = 0,              //赞
    UITableViewCellCollect,              //收藏
    UITableViewCellConment,          //评论
    UITableViewCellFocus,               //关注
    UITableViewCellSendMessage   //发送评论
};



//使用宏定义16进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕适配
#define FB_FIX_SIZE_WIDTH(w) (((w) / 320.0) * DeviceWidth)
#define SET_FIX_SIZE_WIDTH (DeviceWidth /320.0)
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

#define DEFAULTIMAGE                  [UIImage imageNamed:@"defaultimage"]
#define FONT(x)                               [UIFont systemFontOfSize:x]
//#define LINECOLOR                        UIColorFromRGB(0xE0E0E0)

#define COMMONCOLOR                     UIColorFromRGB(0xcaa161)
#define BLACKCOLOR                          UIColorFromRGB(0x000000)
#define LESSBLACKCOLOR                 UIColorFromRGB(0x333333)
#define MORELESSBLACKCOLOR      UIColorFromRGB(0x626262)
#define LINECOLOR                              UIColorFromRGB(0xeeeeee)
#define WHITECOLOR                          UIColorFromRGB(0xffffff)
#define BACKVIEWCOLOR                   UIColorFromRGB(0xf5f5f5)

typedef void(^BtnFuncTion)(NSInteger tag);//按钮处理事件
typedef void(^ClickBlockForControl)(id object, id param);
typedef void(^CellBlockVIew)(id object,UITableViewCellViewSignal signal);
typedef void(^BlockAddTip)(id object);
typedef void(^hideBaseController)(id object);//控制器返回
typedef void(^JumpToController)(UIViewController  *object);//控制器跳转
typedef void(^BlockSelectVideo)(NSIndexPath *indexPath,BOOL  select,BOOL cancel);//选择视频回传选中的值

#endif /* Header_h */
