//
//  UIColor+Common.h
//  club
//
//  Created by zhuangyihang on 12/16/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor(PoohCommon)

+ (UIColor *)getRandomColor;

+ (UIColor *)colorWithRGB:(uint32_t)rgbValue;
+ (UIColor *)colorWithRGBA:(uint32_t)rgbaValue;
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

@end
