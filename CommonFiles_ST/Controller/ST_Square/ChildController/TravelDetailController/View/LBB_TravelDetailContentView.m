//
//  LBB_TravelDetailContentView.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDetailContentView.h"
#import "Header.h"

@implementation LBB_TravelDetailContentView
{
    UIImageView     *vistImage;
    UIImageView     *timeImage;
    UILabel              *contentLabel;
    UILabel              *timeLabel;
    LBB_AddressTipView  *addressTip;
    LBB_PraiseWithCommentView  *praiseCommentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        LRViewBorderRadius(self, 0, 0.5, LINECOLOR);
        [self setup];
        [self setModel];
    }
    return self;
}

- (void)prepareForReuse
{
    vistImage.image = nil;
    timeImage.image = nil;
}

- (void)setup
{
    
    vistImage = [UIImageView new];
    
    timeImage = [UIImageView new];
    timeImage.image = IMAGE(@"zjmtime");
    
    contentLabel = [UILabel new];
    contentLabel.font = FONT(AUTO(13.0));
    contentLabel.textColor = LESSBLACKCOLOR;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    timeLabel = [UILabel new];
    timeLabel = [UILabel new];
    timeLabel.font = FONT(AUTO(13.0));
    timeLabel.textColor = MORELESSBLACKCOLOR;
    
    praiseCommentView = [LBB_PraiseWithCommentView new];
    
    addressTip = [LBB_AddressTipView new];
    
    NSArray *views = @[vistImage,contentLabel,timeImage,timeLabel,addressTip];
    [vistImage addSubview:praiseCommentView];
    [self sd_addSubviews:views];
    
    vistImage.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(AUTO(225));
    
}

- (void)setModel
{
    
    [vistImage sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:DEFAULTIMAGE];
    
    praiseCommentView.praiseNum = @"190";
    praiseCommentView.commentNum = @"40";
    
    contentLabel.text = @"厦门是一座美丽的城市，在这座历史悠久的城市中，房价为何涨得怎么快。";
    [contentLabel autoFit:contentLabel.text size:contentLabel.font maxSize:CGSizeMake(DeviceWidth - 30, DeviceHeight)];
    timeLabel.text = @"2016-09-10 10:09";
    addressTip.address = @"约炮圣地";
    
    contentLabel.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(vistImage,5)
    .rightSpaceToView(self,5)
    .heightIs(contentLabel.height);
    
    timeImage.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(contentLabel,10)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
    timeLabel.sd_layout
    .leftSpaceToView(timeImage,5)
    .centerYEqualToView(timeImage)
    .rightEqualToView(self)
    .heightIs(AUTO(15));
    
    addressTip.sd_layout
    .centerYEqualToView(timeImage)
    .rightSpaceToView(self,10);
    
    
    praiseCommentView.sd_layout
    .bottomSpaceToView(vistImage,10)
    .rightSpaceToView(vistImage,10);
    
    
    [self setupAutoHeightWithBottomView:timeImage bottomMargin:15];
}


@end
