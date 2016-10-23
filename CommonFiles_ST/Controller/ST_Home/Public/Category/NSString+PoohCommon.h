//
//  NSString+Common.h
//  club
//
//  Created by zhuangyihang on 12/16/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString(PoohCommon)

- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font;
- (CGFloat)getHeightWithWidth:(CGFloat)width withFont:(UIFont *)font withMaxLine:(NSInteger)line;

+ (NSString *)createGuid;

- (BOOL)validateEmail;
- (BOOL)validatePhone;

- (NSString *)urlencode;

@end
