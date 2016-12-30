//
//  LBBFriendTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBFriendTableViewCell.h"
#import "Header.h"

@implementation LBBFriendTableViewCell
{
    UIImageView   *iconImage;
    UILabel            *nameLabel;
    UILabel            *contentLabel;
    UIButton           *focusBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    return self;
}

//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//    iconImage.image = nil;
//}
- (void)setup
{
    iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,AUTO(10) , AUTO(40), AUTO(40))];
    [self addSubview:iconImage];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconImage.right + 5, iconImage.top, DeviceWidth - AUTO(65) - iconImage.right - 5, AUTO(15))];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = FONT(AUTO(13.0));
    [self addSubview:nameLabel];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom + AUTO(5), nameLabel.width, AUTO(15))];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = FONT(AUTO(11.0));
    [self addSubview:contentLabel];
    
    focusBtn = [[UIButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(45) - 20, AUTO(20), AUTO(45), AUTO(20))];
//    [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [focusBtn setTitleColor:UIColorFromRGB(0xBA9150) forState:0];
    focusBtn.titleLabel.font = FONT(AUTO(12.0));
    LRViewBorderRadius(focusBtn, 2.0, 0.5, UIColorFromRGB(0xBA9150));
    [self addSubview:focusBtn];
    
    [focusBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)attention:(UIButton*)sender{
     @weakify(self)
    [self.model attention:^(NSError* error){
        @strongify(self);
        if (error) {
            NSLog(@"关注动作失败:%@",error.domain);
        }
        else{
            NSLog(@"关注动作成功:%d",self.model.AttentionStatus);
        }
    }];
    
}

- (void)setModel:(LBB_SquareFriend *)model
{
    [self removeAllSubviews];
    [self setup];
    _model = model;
    [iconImage sd_setImageWithURL:[NSURL URLWithString:model.userHeadPortraitUrl] placeholderImage:DEFAULTIMAGE];
    nameLabel.text = model.userName;
//    [self showShadow:nameLabel];
    contentLabel.text = model.attentionRemark;
    if(model.AttentionStatus == 0)
    {
        [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    }else{
        [focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }
    @weakify(self)
    [RACObserve(model, AttentionStatus) subscribeNext:^(NSNumber* num) {
        
        int status = [num intValue];
        if (status == 0) {//未关注
            [focusBtn setTitle:@"关注" forState:UIControlStateNormal];
             NSLog(@"id = %ld,status",model.userId);
        }
        else{//已关注
            [focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
            NSLog(@"id = %ld,statused",model.userId);
        }
    }];

}

//  加阴影
- (void)showShadow:(UIView*)view
{
    CALayer *layer = [view layer];
    layer.shadowOffset = CGSizeMake(1.f, 1.f);
    layer.shadowRadius = .5f;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.7;
}

@end
