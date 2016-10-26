//
//  LBB_ScenicDetailVipFavoriteCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailVipFavoriteCell.h"

@implementation LBB_ScenicDetailVipFavoriteCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat margin = 8;
        
        self.titleLable = [UILabel new];
        [self.titleLable setText:@"50位达人已收藏"];
        [self.titleLable setTextColor:ColorBtnYellow];
        [self.titleLable setFont:Font15];
        [self.contentView addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(2* margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
        }];
        
        CGFloat width = AutoSize(30);
        self.addButton = [UIButton new];
        [self.addButton setBackgroundImage:IMAGE(@"景点专题_添加") forState:UIControlStateNormal];
        self.addButton.layer.cornerRadius = width/2;
        [self.contentView addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLable);
            make.top.equalTo(ws.titleLable.mas_bottom).offset(2*margin);
            make.width.height.mas_equalTo(width);
        }];
        
        ///达人收藏图标
        self.favoriteImageView1 = [UIImageView new];
        [self.contentView addSubview:self.favoriteImageView1];
        self.favoriteImageView2 = [UIImageView new];
        [self.contentView addSubview:self.favoriteImageView2];
        self.favoriteImageView3 = [UIImageView new];
        [self.contentView addSubview:self.favoriteImageView3];
        self.favoriteImageView4 = [UIImageView new];
        [self.contentView addSubview:self.favoriteImageView4];
        self.favoriteImageView5 = [UIImageView new];
        [self.contentView addSubview:self.favoriteImageView5];
        self.favoriteImageView6 = [UIImageView new];
        [self.contentView addSubview:self.favoriteImageView6];
        
        self.favoriteImageView1.layer.cornerRadius = width/2;
        self.favoriteImageView2.layer.cornerRadius = width/2;
        self.favoriteImageView3.layer.cornerRadius = width/2;
        self.favoriteImageView4.layer.cornerRadius = width/2;
        self.favoriteImageView5.layer.cornerRadius = width/2;
        self.favoriteImageView6.layer.cornerRadius = width/2;

        self.favoriteImageView1.layer.masksToBounds = YES;
        self.favoriteImageView2.layer.masksToBounds = YES;
        self.favoriteImageView3.layer.masksToBounds = YES;
        self.favoriteImageView4.layer.masksToBounds = YES;
        self.favoriteImageView5.layer.masksToBounds = YES;
        self.favoriteImageView6.layer.masksToBounds = YES;

        
        [self.favoriteImageView1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.width.height.equalTo(ws.addButton);
            make.left.equalTo(ws.addButton.mas_right).offset(2*margin);
        }];
        [self.favoriteImageView2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.width.height.equalTo(ws.addButton);
            make.left.equalTo(ws.favoriteImageView1.mas_right).offset(margin/2);
        }];
        [self.favoriteImageView3 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.width.height.equalTo(ws.addButton);
            make.left.equalTo(ws.favoriteImageView2.mas_right).offset(margin/2);
        }];
        [self.favoriteImageView4 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.width.height.equalTo(ws.addButton);
            make.left.equalTo(ws.favoriteImageView3.mas_right).offset(margin/2);
        }];
        [self.favoriteImageView5 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.width.height.equalTo(ws.addButton);
            make.left.equalTo(ws.favoriteImageView4.mas_right).offset(margin/2);
        }];
        [self.favoriteImageView6 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.width.height.equalTo(ws.addButton);
            make.left.equalTo(ws.favoriteImageView5.mas_right).offset(margin/2);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.addButton.mas_bottom).offset(2*margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.bottom.equalTo(ws.contentView);
        }];
     
        
        [self.favoriteImageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.favoriteImageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.favoriteImageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.favoriteImageView4 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.favoriteImageView5 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.favoriteImageView6 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

    }
    return self;
}

@end
