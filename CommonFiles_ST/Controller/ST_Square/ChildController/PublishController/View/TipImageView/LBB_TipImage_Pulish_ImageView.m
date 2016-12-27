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
#import "LBB_PulishContain_ViewController.h"
#import "LBB_PublishVideo_Contain_ViewController.h"
#import "LBB_LabelDetailViewController.h"

@implementation LBB_TipImage_Pulish_ImageView
{
    UITapGestureRecognizer  *tapTouch;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self  == [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        tapTouch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchAddTip:)];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
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
        tagView.tagModel = tagsModel;
        __weak typeof(tagView) weakTagView = tagView;
        tagView.blockTagFunc = ^(LBB_TagView *view)
        {
            weakTagView.left = self.width - view.width - 5;
        };
        tagView.tagTitleStr = tagsModel.tagName;
//        [tagView addTarget:self action:@selector(tagsDetailFunc:) forControlEvents:UIControlEventTouchUpInside];
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
        LBB_TagView   *tagView = [[LBB_TagView alloc]initWithFrame:CGRectMake(0, self.height - AUTO(25) - (AUTO(25) * i), AUTO(80), AUTO(20))];
        tagView.tagModel = tagsModel;
        __weak typeof(tagView) weakTagView = tagView;
        tagView.blockTagFunc = ^(LBB_TagView *view)
        {
            weakTagView.left = self.width - view.width - 5;
        };
        tagView.tagTitleStr = tagsModel.tagName;
//        [tagView addTarget:self action:@selector(tagsDetailFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tagView];

    }
}

- (void)touchAddTip:(UITapGestureRecognizer *)tag
{
    NSLog(@"添加标签");
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
        
        //回传数据，上传数据使用
        if([[self viewController] isKindOfClass:[LBB_PulishContain_ViewController class]])
        {
                [((LBB_PulishContain_ViewController *)[self viewController]) transTagsWithViewTag:self.tipArray viewTag:self.tag];
        }else{
               [((LBB_PublishVideo_Contain_ViewController *)[self viewController]) transTagsWithViewTag:self.tipArray viewTag:self.tag];
        }
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

#pragma mark -- 跳转标签详情
//- (void)tagsDetailFunc:(LBB_TagView *)tagView
//{
//    LBB_LabelDetailViewController  *vc = [[LBB_LabelDetailViewController alloc]init];
//    vc.viewModel = tagView.tagModel;
//    [[self viewController].navigationController pushViewController:vc animated:YES];
//}

- (void)clearNotifi
{
    [self removeGestureRecognizer:tapTouch];
}

@end
