//
//  CommentBoxView.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "CommentBoxView.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"

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
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(sendFunc) forControlEvents:UIControlEventTouchUpInside];
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
    .topSpaceToView(self,AUTO(30) / 4)
    .bottomSpaceToView(self,AUTO(30) / 4)
    .widthIs(1.0);
    
    commentBtn.sd_layout
    .leftSpaceToView(line,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0);
}

- (void)sendFunc
{
    //发送评论
    if(self.sendBlock)
        self.sendBlock(contentText.text,UITableViewCellSendMessage);
}

@end
