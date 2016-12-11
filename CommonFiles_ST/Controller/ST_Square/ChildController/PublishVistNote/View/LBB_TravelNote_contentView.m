//
//  LBB_TravelNote_contentView.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelNote_contentView.h"
#import "Header.h"

@implementation LBB_TravelNote_contentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        LRViewBorderRadius(self, 0, 0.5, LINECOLOR);
    }
    return self;
}

- (void)setup
{
    [self removeAllSubviews];
    
    imagesScroll = [UIScrollView new];
    
    contentLabel = [UILabel new];
    contentLabel.textColor = BLACKCOLOR;
    contentLabel.font = FONT(AUTO(11.0));
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    timeImage = [UIImageView new];
    timeImage.image = IMAGE(@"zjmtime");
    
    timeLabel = [UILabel new];
    timeLabel.font = FONT(AUTO(13.0));
    timeLabel.textColor = MORELESSBLACKCOLOR;
    
    addressTip = [LBB_AddressTipView new];
    
    NSArray *views = @[imagesScroll,contentLabel,timeImage,timeLabel,addressTip];
    [self sd_addSubviews:views];
}

- (void)setModel:(TravelNotesDetails *)model
{
    [self setup];
    _model = model;
    CGFloat scrollHeight = AUTO(70);
    if(!model.pics.count)
    {
        scrollHeight = 0;
    }
    if(!_model)
    {
        contentLabel.text = @"asdfhajkshdfajkshdfk";
        timeLabel.text = @"asdasfasg";
        addressTip.address = @"约炮圣地";
    }else{
        contentLabel.text = model.picRemark;
        timeLabel.text = [NSString stringWithFormat:@"%@    %@",model.releaseDate,model.releaseTime];
        addressTip.address = model.allSpotsTypeName;
    }
    
    imagesScroll.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .heightIs(scrollHeight)
    .rightSpaceToView(self,30);
    
    [model.pics enumerateObjectsUsingBlock:^(TravelNotesPics * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((scrollHeight + 5) * idx, 0, scrollHeight, scrollHeight)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj.imageUrl] placeholderImage:DEFAULTIMAGE];
        [imagesScroll addSubview:imageView];
        [imagesScroll setContentSize:CGSizeMake(imageView.right + 10, 0)];
    }];
    
    contentLabel.sd_layout
    .topSpaceToView(imagesScroll,5)
    .leftSpaceToView(self,AUTO(15))
    .rightSpaceToView(self,AUTO(30))
    .centerXEqualToView(self)
    .autoHeightRatio(0);
    
    timeImage.sd_layout
    .leftSpaceToView(self,AUTO(20))
    .topSpaceToView(contentLabel,10)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
    timeLabel.sd_layout
    .leftSpaceToView(timeImage,5)
    .centerYEqualToView(timeImage)
    .rightEqualToView(self)
    .heightIs(AUTO(15));

    addressTip.sd_layout
    .topSpaceToView(timeImage,5)
    .leftEqualToView(timeImage);
    
    [self setupAutoHeightWithBottomView:addressTip bottomMargin:10];
}

@end
