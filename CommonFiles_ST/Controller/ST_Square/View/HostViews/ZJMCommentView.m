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
#import "Header.h"

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
    for (int i = 0; i < commentArray.count; i++) {
        CommentModel *model = commentArray[i];
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = ColorGray;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        NSString *text = [NSString stringWithFormat:@"%@: %@",model.userName,model.contentStr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc ]initWithString:text];
        NSRange range = NSMakeRange(0,[text rangeOfString:@":"].location+1);
        [str addAttributes:@{NSForegroundColorAttributeName:BLACKCOLOR} range:range];
        [label setAttributedText:str];
        [self addSubview:label];
        
        UILabel  *heightLabel = [[UILabel alloc]init];
        [heightLabel autoFit:label.text size:label.font maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
        if(_maxWidth > 0)
        {
            [heightLabel autoFit:label.text size:label.font maxSize:CGSizeMake(_maxWidth, DeviceHeight)];
        }
        if(lastTopView)
        {
            label.sd_layout
            .topSpaceToView(lastTopView,0)
            .leftSpaceToView(self,0)
            .rightEqualToView(self)
            .heightIs(heightLabel.size.height);
        }else
        {
            label.sd_layout
            .topEqualToView(self)
            .leftSpaceToView(self,0)
            .rightEqualToView(self)
            .heightIs(heightLabel.size.height);
        }
        lastTopView = label;
        [self setupAutoHeightWithBottomView:lastTopView bottomMargin:0];
    }

    NSLog(@"height");
}

@end
