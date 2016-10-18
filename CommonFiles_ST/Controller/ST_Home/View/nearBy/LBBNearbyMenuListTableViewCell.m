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
        
        CGFloat interval = 8;
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(2*interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView).offset(-interval);
            make.width.equalTo(ws.portraitImageView.mas_height);
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font6];
        [self.titleLabel setText:@"厦门鼓浪屿"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.bottom.equalTo(ws.portraitImageView.mas_centerY);
        }];
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font1];
        [self.subTitleLabel setTextColor:[UIConstants getSecondaryTitleColor]];
        [self.subTitleLabel setText:@"船票25/人"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.top.equalTo(ws.portraitImageView.mas_centerY).offset(3);
        }];
       
        self.arrowImageView = [UIImageView new];
        [self.arrowImageView setImage:IMAGE(@"poohArrow")];
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-interval);
            make.centerY.equalTo(ws.titleLabel);
            make.width.height.equalTo(@20);
        }];
        
        self.descLabel = [UILabel new];
        [self.descLabel setFont:Font1];
        [self.descLabel setTextColor:[UIConstants getSecondaryTitleColor]];
        [self.descLabel setText:@"1.5km"];
        [self.descLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-interval);
            make.centerY.equalTo(ws.subTitleLabel);
        }];
        
        self.sep = [UIView new];
        [self.sep setBackgroundColor:[UIConstants getSeperatorLineColor]];
        [self.contentView addSubview:self.sep];
        [self.sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws.contentView);
            make.height.equalTo(@1.5);
        }];
        
    }
    return self;
}





-(CGFloat)getCellHeight{
    
    CGFloat height = 70;
    NSLog(@"getCellHeight:%f",height);
    return height;
}

@end
