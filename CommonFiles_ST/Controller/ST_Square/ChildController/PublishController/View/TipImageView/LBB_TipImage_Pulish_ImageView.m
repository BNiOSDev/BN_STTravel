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
#import "LBB_PulishContain_ViewController.h"
#import "LBB_TagsViewModel.h"
#import "LBB_TagView.h"

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

- (void)setTipArray:(NSMutableArray *)tipArray
{
    _tipArray = tipArray;
    for(UIView *view in [self subviews])
    {
        if([view isKindOfClass:[LBB_TagView class]])
        {
            [view removeFromSuperview];
        }
    }
    for(int i = 0;i < tipArray.count;i++)
    {
        LBB_SquareTags  *tagsModel = [_tipArray objectAtIndex:i];
        LBB_TagView   *tagView = [[LBB_TagView alloc]initWithFrame:CGRectMake(self.width - AUTO(80), self.height - AUTO(25) - (AUTO(25) * i), AUTO(80), AUTO(20))];
        tagView.tagTitleStr = tagsModel.tagName;
        [self addSubview:tagView];
    }
}

- (void)setTagViews
{
    for(UIView *view in [self subviews])
    {
        if([view isKindOfClass:[LBB_TagView class]])
        {
            [view removeFromSuperview];
        }
    }
    for(int i = 0;i < _tipArray.count;i++)
    {
        LBB_SquareTags  *tagsModel = [_tipArray objectAtIndex:i];
        LBB_TagView   *tagView = [[LBB_TagView alloc]initWithFrame:CGRectMake(self.width - AUTO(80), self.height - AUTO(25) - (AUTO(25) * i), AUTO(80), AUTO(20))];
        tagView.tagTitleStr = tagsModel.tagName;
        [self addSubview:tagView];
    }
}

- (void)touchAddTip:(UITapGestureRecognizer *)tag
{
    NSLog(@"添加标签");
//    self._blockAddTip(self);
    LBB_SelectTip_History_ViewController  *Vc =[[LBB_SelectTip_History_ViewController alloc]init];
    Vc.transTags = ^(id tags){
        if(!self.tipArray)
        {
            self.tipArray = [[NSMutableArray alloc]init];
        }
        if(![self containsObject:tags])
        {
                [_tipArray addObject:tags];
        }
        [self setTagViews];
        
        [((LBB_PulishContain_ViewController *)[self viewController]) transTagsWithViewTag:self.tipArray viewTag:self.tag];
    };
    [[self viewController].navigationController pushViewController:Vc animated:YES];
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

- (BOOL)containsObject:(LBB_SquareTags *)tag
{
    for(int i = 0; i < self.tipArray.count; i++)
    {
        LBB_SquareTags *chareTag = [self.tipArray objectAtIndex:i];
        if([chareTag.tagName isEqualToString:tag.tagName])
        {
            return YES;
        }
    }
    return NO;
}

@end
