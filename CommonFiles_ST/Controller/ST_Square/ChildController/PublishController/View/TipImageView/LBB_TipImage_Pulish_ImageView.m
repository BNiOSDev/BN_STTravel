//
//  LBB_TipImage_Pulish_ImageView.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TipImage_Pulish_ImageView.h"
#import "LBB_TipView.h"
#import "LBB_SelectTip_History_ViewController.h"

@implementation LBB_TipImage_Pulish_ImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self  == [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tapTouch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAddTip:)];
        [self addGestureRecognizer:tapTouch];
    }
    return self;
}

- (void)setTipArray:(NSArray *)tipArray
{
    _tipArray = tipArray;
    for(int i = 0;i < tipArray.count;i++)
    {
        
    }
}

- (void)touchAddTip:(UITapGestureRecognizer *)tag
{
    NSLog(@"添加标签");
    [[self viewController].navigationController pushViewController:[[LBB_SelectTip_History_ViewController alloc]init] animated:YES];
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;  
}

@end
