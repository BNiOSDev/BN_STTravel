//
//  LBB_Bill_View.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Bill_View.h"
#import "LBB_AddressTipView.h"
#import "Header.h"

@implementation LBB_Bill_View
{
    UIImageView  *houseImage;
    UILabel             *priceLbale;
    UILabel             *houseLabel;
    UIImageView     *arrowImage;
    LBB_AddressTipView  *addTipView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        LRViewBorderRadius(self, 5.0, 1.0, LINECOLOR);
        [self setup];
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)setup
{
    houseImage = [UIImageView new];
    houseImage.image = IMAGE(@"zjmtravelhouse");
    
    arrowImage = [UIImageView new];
    arrowImage.image = IMAGE(@"zjmtravelarrow");
    
    houseLabel = [UILabel  new];
    houseLabel.font = FONT(AUTO(12.0));
    houseLabel.textColor = MORELESSBLACKCOLOR;
    
    priceLbale = [UILabel  new];
    priceLbale.textColor = [UIColor redColor];
    priceLbale.font = FONT(AUTO(15.0));
        
    addTipView = [LBB_AddressTipView new];
    
    NSArray  *views = @[houseImage,houseLabel,priceLbale,arrowImage,addTipView];
    [self sd_addSubviews:views];
    
    houseImage.sd_layout
    .leftSpaceToView(self,AUTO(20))
    .topSpaceToView(self,AUTO(15))
    .heightIs(AUTO(13))
    .widthIs(AUTO(13));
    
    houseLabel.sd_layout
    .leftSpaceToView(houseImage,5)
    .centerYEqualToView(houseImage)
    .heightIs(AUTO(18))
    .widthIs(AUTO(200));

    priceLbale.sd_layout
    .rightSpaceToView(self,AUTO(50))
    .centerYEqualToView(houseImage)
    .heightIs(AUTO(18))
    .leftEqualToView(self);
    priceLbale.textAlignment = NSTextAlignmentRight;
    
    arrowImage.sd_layout
    .heightIs(AUTO(15))
    .widthIs(AUTO(10))
    .centerYEqualToView(self)
    .rightSpaceToView(self,10);
    
}

- (void)setModel:(ZJMHostModel *)model
{
    houseLabel.text = @"民宿";
    priceLbale.text = @"$123.00";
    addTipView.address = @"厦门第一豪";
    
    addTipView.sd_layout
    .leftEqualToView(houseImage)
    .topSpaceToView(houseImage,AUTO(15));
    
    [self setupAutoHeightWithBottomView:addTipView bottomMargin:AUTO(20)];
}

@end
