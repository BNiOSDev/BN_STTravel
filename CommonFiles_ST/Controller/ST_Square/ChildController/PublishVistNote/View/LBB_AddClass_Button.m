//
//  LBB_AddClass_Button.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddClass_Button.h"
#import "Header.h"
#import "NSString+TPCategory.h"

@implementation LBB_AddClass_Button
{
    UILabel   *titleLabel;
    UIImageView *tipImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        
        UILabel *lineTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 1.0)];
        lineTop.backgroundColor = ColorLine;
        [self addSubview:lineTop];
        
        UILabel *lineBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width, 1.0)];
        lineBottom.backgroundColor = ColorLine;
        [self addSubview:lineBottom];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        titleLabel.textColor = ColorBlack;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = FONT(AUTO(13.0));
        [self addSubview:titleLabel];
        
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    
    CGSize size = [_titleStr textSize:titleLabel.font withWidth:titleLabel.width];
    titleLabel.width = size.width + 10;
    titleLabel.centerX = self.width / 2.0;
    titleLabel.text = titleStr;
    
    tipImage = [[UIImageView alloc]initWithFrame:CGRectMake( titleLabel.left - AUTO(13), 0, AUTO(13), AUTO(13))];
    tipImage.image = [UIImage imageNamed:@"zjmadd"];
    tipImage.centerY = self.height / 2.0;
    [self addSubview:tipImage];
}

@end
