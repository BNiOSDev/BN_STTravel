//
//  UILabel+AutoFit.m
//  UILableAutoFit
//
//  Created by dangercheng on 15/8/19.
//  Copyright (c) 2015年 Todo. All rights reserved.
//

#import "UILabel+AutoFit.h"

@implementation UILabel (AutoFit)

- (void)autoFit:(NSString *)text size:(UIFont *)font maxSize:(CGSize )size{
    self.text = text;
    self.numberOfLines = 0;
    CGSize labelSize = [text boundingRectWithSize:size//限制最大的宽度和高度
                                            options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                         attributes:@{NSFontAttributeName:font}//传人的字体字典
                                            context:nil].size;
    self.size = CGSizeMake(size.width, labelSize.height+3);
}

- (void)autoFitReturnNewSize:(NSString *)text size:(UIFont *)font maxSize:(CGSize )size{
    self.text = text;
    self.numberOfLines = 0;
    CGSize labelSize = [text boundingRectWithSize:size//限制最大的宽度和高度
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                       attributes:@{NSFontAttributeName:font}//传人的字体字典
                                          context:nil].size;
    self.size = CGSizeMake(labelSize.width+3, labelSize.height+3);
}

@end
