//
//  UILabel+AutoFit.h
//  UILableAutoFit
//
//  Created by dangercheng on 15/8/19.
//  Copyright (c) 2015年 Todo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoFit)

- (void)autoFit:(NSString *)text size:(UIFont *)font maxSize:(CGSize )size;
- (void)autoFitReturnNewSize:(NSString *)text size:(UIFont *)font maxSize:(CGSize )size ;

@end
