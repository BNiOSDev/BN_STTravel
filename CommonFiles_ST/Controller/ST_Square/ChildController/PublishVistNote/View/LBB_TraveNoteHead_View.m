//
//  LBB_TraveNoteHead_View.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TraveNoteHead_View.h"
#import "Header.h"
@implementation LBB_TraveNoteHead_View
{
    UIButton         *setCover;
    UIButton         *addTip;
    UIImageView  *backImage;
    UIImageView  *headImage;
    UILabel           *travelNameLabel;
    UILabel           *travelTimeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self addSubview:backImage];
        
        setCover = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(75), 74, AUTO(65), AUTO(17.5))];
        [setCover setTitle:@"设置封面" forState:0];
        [setCover setTitleColor:WHITECOLOR forState:0];
        setCover.titleLabel.font = FONT(AUTO(12.0));
        setCover.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        LRViewBorderRadius(setCover, setCover.height / 2, 0, [UIColor clearColor]);
        [setCover addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setCover];
        
        addTip = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(150), 74, AUTO(65), AUTO(17.5))];
        [addTip setTitle:@"添加标签" forState:0];
        [addTip setTitleColor:WHITECOLOR forState:0];
        addTip.titleLabel.font = FONT(AUTO(12.0));
        addTip.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        [addTip addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
        LRViewBorderRadius(addTip, addTip.height / 2, 0, [UIColor clearColor]);
        [self addSubview:addTip];
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(10), self.height - AUTO(59), AUTO(44), AUTO(44))];
        LRViewBorderRadius(headImage, headImage.height / 2.0, 0, [UIColor clearColor]);
        [headImage sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:DEFAULTIMAGE];
        [self addSubview:headImage];
        
        travelNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImage.right + AUTO(10), headImage.top + 2, DeviceWidth, AUTO(20))];
        travelNameLabel.textColor = WHITECOLOR;
        travelNameLabel.font = FONT(AUTO(15.0));
        [self addSubview:travelNameLabel];
        
        travelTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(headImage.right + AUTO(10), travelNameLabel.bottom + 2, DeviceWidth, AUTO(15))];
        travelTimeLabel.textColor = WHITECOLOR;
        travelTimeLabel.font = FONT(AUTO(12.0));
        [self addSubview:travelTimeLabel];
    }
    return self;
}

- (void)setCoverImage:(UIImage *)coverImage
{
    backImage.image = coverImage;
}

- (void)setTravelName:(NSString *)travelName
{
    travelNameLabel.text = travelName;
}

- (void)setTravelTime:(NSString *)travelTime
{
    travelTimeLabel.text = travelTime;
}

- (void)btnFunc:(UIButton *)btn
{
    if(btn == setCover)
    {
        self.btnFunction(1);
    }else{
        self.btnFunction(0);
    }
}
@end
