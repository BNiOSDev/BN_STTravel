//
//  LBB_ScenicDetailVipMPaiCellItem.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailVipMPaiCellItem.h"
#import "PoohCommon.h"
@implementation LBB_ScenicDetailVipMPaiCellItem


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    WS(ws);
    if (self) {
        
        self.mainImageView = [UIImageView new];
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(LBB_ScenicDetailVipMPaiCellMainImageViewHeight);
        }];
        
        self.playButton = [UIButton new];
        [self.playButton setImage:IMAGE(@"景点详情_播放") forState:UIControlStateNormal];
        [self.contentView addSubview:self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.equalTo(ws.mainImageView);
            make.height.width.mas_equalTo(50);
        }];
        
        CGFloat margin = 8;
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.width.height.mas_equalTo(LBB_ScenicDetailVipMPaiCellPortraitImageViewHeight);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(-(LBB_ScenicDetailVipMPaiCellPortraitImageViewHeight/2));
            make.bottom.equalTo(ws.contentView).offset(-margin);
        }];
        self.portraitImageView.layer.cornerRadius =(LBB_ScenicDetailVipMPaiCellPortraitImageViewHeight)/2;
        self.portraitImageView.layer.masksToBounds = YES;
        
        self.nickNameLabel = [UILabel new];
        [self.nickNameLabel setFont:Font13];
        [self.nickNameLabel setText:@"pooh handsome"];
        [self.contentView addSubview:self.nickNameLabel];
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin/2);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(2);
        }];
        
        self.commentsButton = [[UIButton alloc]init];
        [self.commentsButton setImage:IMAGE(@"景区列表_评论")forState:UIControlStateNormal];
        [self.commentsButton setTitle:@"1000" forState:UIControlStateNormal];
        [self.commentsButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsButton.titleLabel setFont:Font12];
        [self.contentView addSubview:self.commentsButton];
        [self.commentsButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-3);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(3);
           // make.height.equalTo(@15);
        }];

        
        self.greatButton = [[UIButton alloc]init];

        [self.greatButton setImage:IMAGE(@"景区列表_点赞")forState:UIControlStateNormal];
        [self.greatButton setTitle:@"1000" forState:UIControlStateNormal];
        [self.greatButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greatButton.titleLabel setFont:Font12];
        [self.contentView addSubview:self.greatButton];
        [self.greatButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsButton.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsButton);
        }];

    
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(PlaceHolderImage)];

        
        [self.contentView layoutSubviews];//it must to be done to layouts subviews
        
    }
    return self;
}



@end
