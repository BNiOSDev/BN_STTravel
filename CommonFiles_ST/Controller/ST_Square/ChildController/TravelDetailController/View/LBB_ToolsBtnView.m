//
//  LBB_ToolsBtnView.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ToolsBtnView.h"
#import "Header.h"

@implementation LBB_ToolsBtnView
{
    NSArray *imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = ColorWhite;
        imageArray = @[@"zjmbeauty",@"zjmfood",@"zjmhouse",@"zjmshop"];
    }
    return self;
}

- (void)setButtonList:(NSArray<NSString *> *)buttonList
{
    CGFloat  btnwidth = DeviceWidth / 4.0;
    [buttonList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton  *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnwidth * idx, 0, btnwidth, self.height)];
        btn.titleLabel.font = FONT(AUTO(13.0));
        [btn setTitle:obj forState:0];
        [btn setTitleColor:BLACKCOLOR forState:0];
        [btn setImage:IMAGE(imageArray[idx]) forState:0];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self addSubview:btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(AUTO(10), self.height - 1.0, DeviceWidth - AUTO(20), 1.0)];
        line.backgroundColor = LINECOLOR;
        [self addSubview:line];
        
    }];

}

@end
