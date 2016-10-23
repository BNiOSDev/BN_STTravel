//
//  NSString+Common.m
//  club
//
//  Created by zhuangyihang on 12/16/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import "NSString+PoohCommon.h"

@implementation NSString(PoohCommon)

- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font{
    CGFloat height = MAXFLOAT;
    
    CGRect r = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return r.size.height;
}

- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font withMaxLine:(NSInteger)line{
    CGFloat lineHeight = font.lineHeight;
    
    CGFloat height = MAXFLOAT;
    if (line==0) {
        height = MAXFLOAT;
    }else{
        height = line * lineHeight;
    }
    
    CGRect r = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return r.size.height;
}

+ (NSString *)createGuid{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}


- (BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)validatePhone{
    NSString *phoneRegex = @"1[3|4|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (NSString *)urlencode {
    static CFStringRef charset = CFSTR("!@#$%&*()+'\";:=,/?[] ");
    CFStringRef str = (__bridge CFStringRef)self;
    CFStringEncoding encoding = kCFStringEncodingUTF8;
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, str, NULL, charset, encoding));
}
@end
