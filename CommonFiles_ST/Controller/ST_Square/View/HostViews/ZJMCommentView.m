//
//  ZJMCommentView.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "ZJMCommentView.h"
#import "UIView+SDAutoLayout.h"
#import "CommentModel.h"

@implementation ZJMCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
    }
    return self;
}

- (void)setCommentArray:(NSArray *)commentArray
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    UIView  *lastTopView;
    CGFloat margin = 5;
    
    for (int i = 0; i < commentArray.count; i++) {
        CommentModel *model = commentArray[i];
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%@: %@",model.userName,model.contentStr];
        [self addSubview:label];
        
        label.sd_layout
        .topSpaceToView(lastTopView,margin)
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .autoHeightRatio(0);
        lastTopView = label;
        [self setupAutoHeightWithBottomView:lastTopView bottomMargin:10];
    }

    NSLog(@"height");
}

@end
