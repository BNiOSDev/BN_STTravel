//
//  PoohAppHelper.m
//
//
//  Created by pooh on 1/8/16.
//  Copyright © 2016 pooh. All rights reserved.
//

#import "PoohAppHelper.h"

#import "NSString+PoohCommon.h"

static NSString *kDateFormatValue[] = {
    [DateFormatFullDateWithTime] = @"yyyy-MM-dd HH:mm:ss",
    [DateFormatFullDate] = @"yyyy-MM-dd",
};

static NSString *kDateFormatFullDateWithTime = @"yyyy-MM-dd HH:mm:ss";
static NSString *kDateFormatFullDate = @"yyyy-MM-dd";

@implementation PoohAppHelper

+ (UIButton *)createVerticalButton:(UIImage *)image withTitle:(NSString *)title{
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setImage:image forState:UIControlStateNormal];
    [b setTitle:title forState:UIControlStateNormal];
    
    CGFloat spacing = 6.0;
    CGSize imageSize = b.imageView.frame.size;
    b.titleEdgeInsets = UIEdgeInsetsMake(
                                         0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    CGSize titleSize = b.titleLabel.frame.size;
    b.imageEdgeInsets = UIEdgeInsetsMake(
                                         - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);

    return b;
}

+ (CGFloat)scaleForI5{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.bounds.size.width/320.0;
}

+ (CGFloat)scaleForI6P{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.bounds.size.width/414.0;
}

+ (CGFloat)scaleForI6{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.bounds.size.width/375.0;
}


+ (NSDate *)getDateFromString:(NSString *)dateString withFormat:(DateFormat)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:kDateFormatValue[format]];
    return [df dateFromString: dateString];
}
+ (NSString *)getStringFromDate:(NSDate *)date withFormat:(DateFormat)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:kDateFormatValue[format]];
    return [df stringFromDate:date];
}


+ (NSString *)getUniqueString{
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    NSString *uniqueId = (__bridge NSString *)uuidStringRef;
    return uniqueId;
}

@end
