//
//  LBB_TravelDetailHeadView.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDetailHeadView.h"
#import "LBBTravelContentImage.h"
#import "Header.h"

@implementation LBB_TravelDetailHeadView
{
    LBBTravelContentImage  *contentImage;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UILabel     *nameLabel;
    UIImageView *iconImage;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *heartBtn;
    
    UIButton    *downLoadBtn;
    UIButton    *shareBtn;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self setup];
        self.backgroundColor = WHITECOLOR;
    }
    return self;
}


- (void)setup
{
    
    contentImage = [[LBBTravelContentImage alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(195))];
    [self addSubview:contentImage];
    
    downLoadBtn = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(16.5) - 15, AUTO(25), AUTO(16.5), AUTO(14))];
    [downLoadBtn setBackgroundImage:IMAGE(@"zjmdownlaod") forState:0];
    [self addSubview:downLoadBtn];
    
    shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(33) - 30, AUTO(25), AUTO(16.5), AUTO(14))];
    [shareBtn setBackgroundImage:IMAGE(@"zjmshare") forState:0];
    [self addSubview:shareBtn];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, AUTO(55), DeviceWidth - 40, AUTO(20))];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = FONT(AUTO(17.0));
    [self addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, contentLabel.bottom + AUTO(5), DeviceWidth - 40, AUTO(20))];
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
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, iconImage.bottom + 10, DeviceWidth, 10)];
    bottomView.backgroundColor = BACKVIEWCOLOR;
    [self addSubview:bottomView];
    self.height = bottomView.bottom;
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
