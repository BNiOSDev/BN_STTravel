//
//  UILabel+Common.m
//  HappyPenguin
//
//  Created by 柯尔祥 on 6/8/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)


-(CGSize)setLineSpace:(CGFloat)space{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    
    self.attributedText = attributedString;
    //调节高度
    CGSize size = CGSizeMake(self.frame.size.width, 500000);
    
    CGSize labelSize = [self sizeThatFits:size];
    
    CGRect frame = self.frame;
    frame.size = labelSize;
    [self setFrame:frame];
    return self.frame.size;
}

@end
