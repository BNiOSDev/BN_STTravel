//
//  LBB_HotTipCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HotTipCell.h"
#import "Header.h"

@implementation LBB_HotTipCell
{
    UIImageView     *tipImage;
    UILabel              *tipLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        tipImage = [[UIImageView alloc]initWithFrame:CGRectMake(AUTO(15), 0, AUTO(15), AUTO(15))];
        tipImage.image = IMAGE(@"zjmbiaoqian");
        [self addSubview:tipImage];
        
        tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(tipImage.right + AUTO(8), 0, 300, AUTO(15))];
        tipLabel.textColor = MORELESSBLACKCOLOR;
        tipLabel.font = FONT(AUTO(12.0));
        tipLabel.centerY = AUTO(40)/2.0;
        tipImage.centerY = tipLabel.centerY;
        [self addSubview:tipLabel];
        
    }
    return self;
}

- (void)setTipTitle:(NSString *)tipTitle
{
    tipLabel.text = tipTitle;
}


@end
