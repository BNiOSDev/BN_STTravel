//
//  LBBTravelTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBTravelTableViewCell.h"
#import "LBBTravelContentImage.h"
#import "Header.h"

@implementation LBBTravelTableViewCell
{
    LBBTravelContentImage  *contentImage;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UILabel     *nameLabel;
    UIImageView *iconImage;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *heartBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        [self setup];
    }
    return self;
}

- (void)setup
{
    contentImage = [[LBBTravelContentImage alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(180))];
    [self addSubview:contentImage];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, DeviceWidth - 40, AUTO(20))];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = FONT(AUTO(17.0));
    [self addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, contentLabel.bottom + AUTO(10), DeviceWidth - 40, AUTO(20))];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = FONT(AUTO(13.0));
    [self addSubview:timeLabel];
    
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, contentImage.bottom - AUTO(10), AUTO(30), AUTO(30))];
    iconImage.clipsToBounds = YES;
    LRViewBorderRadius(iconImage, iconImage.height / 2.0, 0, [UIColor clearColor]);
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImage.right + AUTO(5), contentImage.bottom + AUTO(5), 300, AUTO(15))];
    nameLabel.font = FONT(AUTO(12));
    nameLabel.textColor = [UIColor blackColor];
    [self addSubview:nameLabel];
    
    heartBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20, contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    heartBtn.titleLabel.font = FONT(AUTO(11.0));
    [heartBtn setTitleColor:[UIColor grayColor] forState:0];
    [heartBtn setImage:IMAGE(@"zjmlittlecollect_no") forState:0];
    [self addSubview:heartBtn];
    
    pinBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - heartBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    pinBtn.titleLabel.font = FONT(AUTO(11.0));
    [pinBtn setTitleColor:[UIColor grayColor] forState:0];
    [pinBtn setImage:IMAGE(@"zjmcomment") forState:0];
    [self addSubview:pinBtn];
    
    zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - pinBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    zanBtn.titleLabel.font = FONT(AUTO(11.0));
    [zanBtn setTitleColor:[UIColor grayColor] forState:0];
    [zanBtn setImage:IMAGE(@"zjmdianzan") forState:0];
    [self addSubview:zanBtn];
    
}

- (void)setModel:(ZJMTravelModel *)model
{
    _model = model;
    contentImage.imageUrl = model.imageUrl;
    contentLabel.text  = model.msgContent;
    timeLabel.text = [NSString stringWithFormat:@"%@  %@   %@",model.timeStr,model.daysStr,model.vistNum];
    [iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconName] placeholderImage:DEFAULTIMAGE];
    nameLabel.text = model.name;
    
    [heartBtn setTitle:model.collectNum forState:0];
    heartBtn.width = [self getWidthWithContent:model.collectNum height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    heartBtn.left = DeviceWidth - 10 - heartBtn.width;
    [heartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [heartBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [pinBtn setTitle:model.commentNum forState:0];
    pinBtn.width = [self getWidthWithContent:model.commentNum height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
     pinBtn.left = DeviceWidth - heartBtn.width - pinBtn.width  - 10;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [zanBtn setTitle:model.praiseNum forState:0];
    zanBtn.width = [self getWidthWithContent:model.praiseNum height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = DeviceWidth - pinBtn.width - heartBtn.width - zanBtn.width  - 10;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
}


- (void)btnFunc:(UIButton *)btn
{
    if (btn == heartBtn) {
        self.cellBlock(btn,UITableViewCellCollect);
    }else if(btn == pinBtn)
    {
        self.cellBlock(btn,UITableViewCellConment);
    }else{
        self.cellBlock(btn,UITableViewCellPraise);
    }
}

- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(999, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}

@end
