//
//  LBB_PraiseWithCommentView.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PraiseWithCommentView.h"


@implementation LBB_PraiseWithCommentView
{
    UIImageView  *praiseImage;
    UIImageView  *commentImage;
    UILabel           *praiseLabel;
    UILabel           *commentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self setup];
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [BLACKCOLOR colorWithAlphaComponent:0.2];
    }
    return self;
}

- (void)setup
{
    praiseImage = [UIImageView new];
    praiseImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(praiseFunc:)];
    [praiseImage addGestureRecognizer:imageTag];
    praiseImage.image = IMAGE(@"zjmwhitePraise");
    
    commentImage = [UIImageView new];
    commentImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *commentTag = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(praiseFunc:)];
    [commentImage addGestureRecognizer:commentTag];
    commentImage.image = IMAGE(@"zjmwhitecomment");
    
    praiseLabel = [UILabel new];
    praiseLabel.font = FONT(AUTO(12.0));
    praiseLabel.textColor = WHITECOLOR;
    
    commentLabel = [UILabel new];
    commentLabel.font = FONT(AUTO(12.0));
    commentLabel.textColor = WHITECOLOR;
    
    NSArray *views = @[praiseImage,praiseLabel,commentLabel,commentImage];
    
    UIView *contentView = self;
    [contentView sd_addSubviews:views];
    
}

- (void)setPraiseNum:(NSString *)praiseNum
{
    _praiseNum = praiseNum;
    praiseLabel.text = praiseNum;
    
    [praiseLabel autoFitReturnNewSize:praiseNum size:praiseLabel.font maxSize:CGSizeMake(150, AUTO(14))];
    
    praiseImage.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(self,5)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
    praiseLabel.sd_layout
    .leftSpaceToView(praiseImage,0)
    .centerYEqualToView(praiseImage)
    .heightIs(praiseLabel.height)
    .widthIs(praiseLabel.width);
    
    commentImage.sd_layout
    .leftSpaceToView(praiseLabel,5)
    .topSpaceToView(self,5)
    .centerYEqualToView(praiseImage)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
}

- (void)setCommentNum:(NSString *)commentNum
{
    _commentNum = commentNum;
    commentLabel.text = commentNum;
    
    [commentLabel autoFitReturnNewSize:commentNum size:praiseLabel.font maxSize:CGSizeMake(150, AUTO(14))];
    
    commentLabel.sd_layout
    .leftSpaceToView(commentImage,0)
    .centerYEqualToView(commentImage)
    .heightIs(commentLabel.height)
    .widthIs(commentLabel.width);
    
    [self setupAutoWidthWithRightView:commentLabel rightMargin:5];
    [self setupAutoHeightWithBottomView:praiseImage bottomMargin:5];
}

- (void)setDianzanImage:(UIImage *)dianzanImage
{
    praiseImage.image = dianzanImage;
}

- (void)praiseFunc:(UITapGestureRecognizer *)tap
{
    if(tap.view == praiseImage)
    {
        if(self.cellBlock)
        {
            self.cellBlock(self,UITableViewCellPraise);
        }
    }else
    {
        if(self.cellBlock)
        {
            self.cellBlock(self,UITableViewCellConment);
        }
    }
}

@end
