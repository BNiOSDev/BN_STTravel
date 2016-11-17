//
//  LBB_MyTravelTableViewCell.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyTravelTableViewCell.h"
#import "LBBTravelContentImage.h"
#import "Header.h"

@implementation LBB_MyTravelTableViewCell
{
    LBBTravelContentImage  *contentImage;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *heartBtn;
    UIButton    *deleteBtn;
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
    
    deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20, contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    deleteBtn.titleLabel.font = FONT(AUTO(10.0));
    [deleteBtn setTitleColor:[UIColor grayColor] forState:0];
    [deleteBtn setImage:IMAGE(@"我的登录_删除") forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.width = [self getWidthWithContent:@"删除" height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    [self addSubview:deleteBtn];
    
    heartBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - deleteBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
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
    
    //屏蔽两个按钮可以同时被点击
    deleteBtn.exclusiveTouch = YES;
    heartBtn.exclusiveTouch = YES;
    pinBtn.exclusiveTouch = YES;
    zanBtn.exclusiveTouch = YES;
}

- (void)setViewType:(TravelsViewType)viewType
{
    _viewType = viewType;
    switch (_viewType) {
        case TravelsViewDownloaed://我的下载-游记
        case TravelsViewGuide: //我的下载-攻略
        {
            deleteBtn.hidden = NO;
        }
            break;
        case TravelsViewRoute:
        {
            zanBtn.hidden = YES;
            pinBtn.hidden = YES;
            heartBtn.hidden = YES;
            deleteBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)setModel:(ZJMTravelModel *)model
{
    _model = model;
    contentImage.imageUrl = model.imageUrl;
    contentLabel.text  = model.msgContent;
    timeLabel.text = [NSString stringWithFormat:@"%@  %@   %@",model.timeStr,model.daysStr,model.vistNum];
    
    CGFloat deleteWidth = 0.f;
    
    deleteBtn.left = DeviceWidth - 10 - deleteBtn.width;
    deleteWidth = deleteBtn.width;
    [deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [deleteBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [heartBtn setTitle:model.collectNum forState:0];
    heartBtn.width = [self getWidthWithContent:model.collectNum height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    heartBtn.left = DeviceWidth - 10 - heartBtn.width - deleteWidth;
    [heartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [heartBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [pinBtn setTitle:model.commentNum forState:0];
    pinBtn.width = [self getWidthWithContent:model.commentNum height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    pinBtn.left = DeviceWidth - heartBtn.width - pinBtn.width  - 10 - deleteWidth;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [zanBtn setTitle:model.praiseNum forState:0];
    zanBtn.width = [self getWidthWithContent:model.praiseNum height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = DeviceWidth - pinBtn.width - heartBtn.width - zanBtn.width  - 10 - deleteWidth;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
}

- (void)btnFunc:(UIButton *)btn
{
    if (self.cellBlock) {
        if (btn == heartBtn) {
            self.cellBlock(btn,UITableViewCellCollect);
        }else if(btn == pinBtn)
        {
            self.cellBlock(btn,UITableViewCellConment);
        }else if(btn == zanBtn){
            self.cellBlock(btn,UITableViewCellPraise);
        }else{
            self.cellBlock(btn,UITableViewCellDelete);
        }
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
