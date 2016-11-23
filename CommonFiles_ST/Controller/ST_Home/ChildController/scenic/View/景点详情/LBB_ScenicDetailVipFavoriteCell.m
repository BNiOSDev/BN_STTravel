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
    }
    return self;
}


-(void)setCollectedRecord:(NSMutableArray<LBB_SpotsCollectedRecord *> *)collectedRecord{
    
    _collectedRecord = collectedRecord;
    /*
     @property(nonatomic, assign)long userId ;// 主键
     @property(nonatomic, strong)NSString *userName ;// 收藏用户名称
     @property(nonatomic, strong)NSString *userPicUrl ;// 收藏头像URL

     */
    //标签
    self.favoriteImageView1.hidden = YES;
    self.favoriteImageView2.hidden = YES;
    self.favoriteImageView3.hidden = YES;
    self.favoriteImageView4.hidden = YES;
    self.favoriteImageView5.hidden = YES;
    self.favoriteImageView6.hidden = YES;
    
    NSInteger count = collectedRecord.count;
    if (count > 0) {
        self.favoriteImageView1.hidden = NO;
        LBB_SpotsCollectedRecord* tag = [collectedRecord objectAtIndex:0];
        [self.favoriteImageView1 sd_setImageWithURL:[NSURL URLWithString:tag.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 1){
        self.favoriteImageView2.hidden = NO;
        LBB_SpotsCollectedRecord* tag = [collectedRecord objectAtIndex:1];
        [self.favoriteImageView2 sd_setImageWithURL:[NSURL URLWithString:tag.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 2){
        self.favoriteImageView3.hidden = NO;
        LBB_SpotsCollectedRecord* tag = [collectedRecord objectAtIndex:2];
        [self.favoriteImageView3 sd_setImageWithURL:[NSURL URLWithString:tag.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 3){
        self.favoriteImageView4.hidden = NO;
        LBB_SpotsCollectedRecord* tag = [collectedRecord objectAtIndex:3];
        [self.favoriteImageView4 sd_setImageWithURL:[NSURL URLWithString:tag.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 4){
        self.favoriteImageView5.hidden = NO;
        LBB_SpotsCollectedRecord* tag = [collectedRecord objectAtIndex:4];
        [self.favoriteImageView5 sd_setImageWithURL:[NSURL URLWithString:tag.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 5){
        self.favoriteImageView6.hidden = NO;
        LBB_SpotsCollectedRecord* tag = [collectedRecord objectAtIndex:5];
        [self.favoriteImageView6 sd_setImageWithURL:[NSURL URLWithString:tag.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
}


@end
