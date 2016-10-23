//
//  CommentBoxView.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "CommentBoxView.h"
#import "UIView+SDAutoLayout.h"

@implementation CommentBoxView
{
        UITextField     *contentText;
        UIView            *line;
        UIButton         *commentBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.clipsToBounds = YES;
        [self setView];
    }
    return self;
}

- (void)setView
{
    contentText = [UITextField new];
    contentText.font = [UIFont systemFontOfSize:13.0];
    
    line = [UIView new];
    line.backgroundColor = [UIColor grayColor];
    
    commentBtn = [UIButton new];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [commentBtn setTitle:@"发送" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    NSArray  *views = @[contentText,line,commentBtn];
    [self sd_addSubviews:views];
    
    contentText.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(self,50);
    
    line.sd_layout
    .leftSpaceToView(contentText,0)
    .topSpaceToView(self,40 / 4)
    .heightIs(40 / 2)
    .widthIs(1.0);
    
    commentBtn.sd_layout
    .leftSpaceToView(line,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0);
}
@end
