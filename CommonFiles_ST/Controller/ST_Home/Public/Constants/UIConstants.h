//
//  UIConstants.h
//  HappyPenguin
//
//  Created by zhuangyihang on 12/30/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIConstants : NSObject

+ (UIFont *)getFont:(CGFloat)size;
+ (UIFont *)getBoldFont:(CGFloat)size;

+ (UIColor *)getAppBackgroundColor;
+ (UIColor *)getAppColor;



#pragma color

/*
 * 小面积使用、用于特别需要强调和突出的文字、按钮和icon
 * 如价格相关的文字信息、icon切换填充色等
 */
+ (UIColor *)getProminentFillColor;

/*
 * 用于辅助、次要文字信息、普通按钮描边
 * 如标签栏底色、小版块标题等
 */
+ (UIColor *)getSecondaryTitleColor;

/*
 * 用于再次要文字信息、局部的标签提示
 * 如内容页文字说明，小图标等
 */
+ (UIColor *)getLevelThreeTitleColor;

/*
 * 用于分割线、标签描边
 */
+ (UIColor *)getSeperatorLineColor;

/*
 * 用于分割模块的底色
 */
+ (UIColor *)getSeperatorBlockColor;


+ (UIImage *)defaultPortrait;
@end
