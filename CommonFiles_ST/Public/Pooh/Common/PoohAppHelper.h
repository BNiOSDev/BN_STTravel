//
//  PoohAppHelper.h
//
//
//  Created by pooh on 1/8/16.
//  Copyright © 2016 pooh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DateFormat) {
    DateFormatFullDateWithTime,//YYYY-MM-dd HH:mm:ss
    DateFormatFullDate,//YYYY-MM-dd
};


@interface PoohAppHelper : NSObject

+ (UIButton *)createVerticalButton:(UIImage *)image withTitle:(NSString *)title;

//当前屏幕宽度与指定机型的比例
+ (CGFloat)scaleForI5;
+ (CGFloat)scaleForI6P;
+ (CGFloat)scaleForI6;

//日期格式化
+ (NSDate *)getDateFromString:(NSString *)dateString withFormat:(DateFormat)format;
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(DateFormat)format;


//

//格式化短信模版信息

+ (NSString *)getUniqueString;


@end
