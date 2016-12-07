//
//  LBBNearbyMenuListTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBNearbyMenuListTableViewCell.h"

@implementation LBBNearbyMenuListTableViewCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;

        CGFloat interval = 10;
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(2*interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView).offset(-interval);
            make.width.height.mas_equalTo(AutoSize(90/2));
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font14];
        [self.titleLabel setText:@"厦门鼓浪屿"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.bottom.equalTo(ws.portraitImageView.mas_centerY);
        }];
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font10];
        [self.subTitleLabel setTextColor:ColorLightGray];
        [self.subTitleLabel setText:@"船票25/人"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.top.equalTo(ws.portraitImageView.mas_centerY).offset(5);
        }];
       
        self.arrowImageView = [UIImageView new];
        [self.arrowImageView setImage:IMAGE(@"ST_Home_Arrow")];
       // [self.arrowImageView setContentMode:UIViewContentModeCenter];

        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-interval);
            make.centerY.equalTo(ws.titleLabel);
            make.width.mas_equalTo(10);
            make.height.equalTo(@15);
        }];
        
        self.descLabel = [UILabel new];
        [self.descLabel setFont:Font10];
        [self.descLabel setTextColor:ColorLightGray];
        [self.descLabel setText:@"1.5km"];
        [self.descLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-interval);
            make.centerY.equalTo(ws.subTitleLabel);
        }];
        
        self.sep = [UIView new];
        [self.sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:self.sep];
        [self.sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
    }
    return self;
}


-(void)setModel:(LBB_SpotModel *)model{

    _model = model;
    
    self.portraitImageView.layer.cornerRadius = 5;
    self.portraitImageView.layer.masksToBounds = YES;
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    
    [self.titleLabel setText:model.allSpotsName];
    [self.subTitleLabel setText:model.picRemark];
    [self.descLabel setText:[NSString stringWithFormat:@"%0.1fkm",model.distance]];
    
    
}

@end
