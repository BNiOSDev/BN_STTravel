//
//  LBB_ShopCatgory_View.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ShopCatgory_View.h"
#import "Header.h"

@implementation LBB_ShopCatgory_View
{
    UIImageView *image;
    UILabel          *addressLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        LRViewBorderRadius(self, 5, 0, [UIColor clearColor]);
        self.backgroundColor = [LINECOLOR colorWithAlphaComponent:0.7];
        [self setup];
    }
    return self;
}

- (void)setup
{
    image = [UIImageView new];
    image.image = IMAGE(@"zjmhousegray");
    [self addSubview:image];
    
    addressLabel = [UILabel new];
    addressLabel.font = FONT(AUTO(12.0));
    addressLabel.textColor = [UIColorFromRGB(0x575859) colorWithAlphaComponent:1.0];
    [self addSubview:addressLabel];
    
    image.sd_layout
    .leftSpaceToView(self,5.0)
    .topSpaceToView(self,2.5)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
}

- (void)setAddress:(NSString *)address
{
    _address = address;
    addressLabel.text = address;
    [addressLabel autoFitReturnNewSize:address size:addressLabel.font maxSize:CGSizeMake(300, 15)];
    addressLabel.sd_layout
    .leftSpaceToView(image,10.0)
    .heightIs(addressLabel.height)
    .widthIs(addressLabel.width)
    .centerYEqualToView(image);
    
    [self setupAutoWidthWithRightView:addressLabel rightMargin:10.0];
    [self setupAutoHeightWithBottomView:image bottomMargin:2.5];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    image.image = IMAGE(@"imageName");
}

@end
