//
//  UIConstants.m
//  HappyPenguin
//
//  Created by zhuangyihang on 12/30/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import "UIConstants.h"
@implementation UIConstants

+ (UIFont *)getFont:(CGFloat)size{
    return [UIFont systemFontOfSize:size];
}
+ (UIFont *)getBoldFont:(CGFloat)size{
    return [UIFont boldSystemFontOfSize:size];
}

+ (UIColor *)getAppBackgroundColor{
    return [UIColor whiteColor];
}

+ (UIColor *)getAppColor{
    
     return [UIColor whiteColor]; //红色
}

#pragma color

/*
 * 小面积使用、用于特别需要强调和突出的文字、按钮和icon
 * 如价格相关的文字信息、icon切换填充色等
 */
+ (UIColor *)getProminentFillColor{
    return [UIColor colorWithRGB:0xcaa161];
}

/*
 * 用于辅助、次要文字信息、普通按钮描边
 * 如标签栏底色、小版块标题等
 */
+ (UIColor *)getSecondaryTitleColor{
    return [UIColor colorWithRGB:0x333333];
}

/*
 * 用于再次要文字信息、局部的标签提示
 * 如内容页文字说明，小图标等
 */
+ (UIColor *)getLevelThreeTitleColor{
    return [UIColor colorWithRGB:0x626262];
}


/*
 * 用于分割线、标签描边
 */
+ (UIColor *)getSeperatorLineColor{
    return [UIColor colorWithRGB:0xeeeeee];
}

/*
 * 用于分割模块的底色
 */
+ (UIColor *)getSeperatorBlockColor{
    return [UIColor colorWithRGB:0xf5f5f5];
}




+ (UIImage *)defaultPortrait{
    return [UIImage imageNamed:@"DefaultPortrait"];
}
@end
