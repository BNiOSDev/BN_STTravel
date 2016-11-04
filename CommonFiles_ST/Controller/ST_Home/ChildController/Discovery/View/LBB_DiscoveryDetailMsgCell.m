//
//  LBB_DiscoveryDetailInfoCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryDetailMsgCell.h"
#import "PoohCommon.h"
@implementation LBB_DiscoveryDetailMsgCell

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
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setText:@"一起探索最厦门的自由行"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(margin);
            make.centerX.equalTo(ws.contentView);
        }];
        
        
        self.timeLabel = [UILabel new];
        [self.timeLabel setFont:Font13];
        [self.timeLabel setText:@"3天2夜"];
        [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.timeLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(margin);
            make.centerX.equalTo(ws.contentView);
        }];
        
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.left.equalTo(ws.contentView).offset(44);
            make.right.equalTo(ws.contentView).offset(-44);
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(margin);
        }];
        
        //点赞
        UIView* v = [UIView new];
        [self.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(sep.mas_bottom).offset(1.5*margin);
        }];
        
        self.greatButton = [[UIButton alloc]init];
        [self.greatButton setImage:IMAGE(@"景点专题_点赞") forState:UIControlStateNormal];
        [self.greatButton setTitle:@"190" forState:UIControlStateNormal];
        [self.greatButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greatButton.titleLabel setFont:Font12];
        [self.greatButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [v addSubview:self.greatButton];
        [self.greatButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.bottom.equalTo(v);
           // make.height.mas_equalTo(@15);
        }];
        [self.greatButton bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        self.commentsButton = [[UIButton alloc]init];
        [ self.commentsButton setImage:IMAGE(@"景点专题_评论") forState:UIControlStateNormal];
        [ self.commentsButton setTitle:@"1000" forState:UIControlStateNormal];
        [ self.commentsButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsButton.titleLabel setFont:Font12];
        [self.commentsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [v addSubview: self.commentsButton];
        [self.commentsButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.greatButton.mas_right).offset(margin);
            make.centerY.height.equalTo(ws.greatButton);
        }];
        
        [self.commentsButton bk_whenTapped:^{
            
        }];
        
        self.favoriteButton = [[UIButton alloc]init];
        [ self.favoriteButton setImage:IMAGE(@"景点专题_小收藏") forState:UIControlStateNormal];
        [ self.favoriteButton setTitle:@"1000" forState:UIControlStateNormal];
        [ self.favoriteButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.favoriteButton.titleLabel setFont:Font12];
        [self.favoriteButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [v addSubview: self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.commentsButton.mas_right).offset(margin);
            make.centerY.height.equalTo(ws.greatButton);
            make.right.equalTo(v);
        }];
        
        [self.favoriteButton bk_whenTapped:^{
            
        }];
        
        
        
        UILabel* note = [UILabel new];
        [note setText:@"线路推荐景点、民宿及美食"];
        [note setFont:Font13];
        [note setTextColor:ColorGray];
        [self.contentView addSubview:note];
        [note mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(v.mas_bottom).offset(3*margin);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.height.width.equalTo(sep);
            make.top.equalTo(note.mas_bottom).offset(margin);
        }];
        
        //推荐景点view
        UIView* v2 = [UIView new];
        [self.contentView addSubview:v2];
        [v2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(sep2);
            make.top.equalTo(sep2.mas_bottom).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        self.scenicButton = [UIButton new];
        [self.scenicButton setTitle:@"景点100" forState:UIControlStateNormal];
        [self.scenicButton setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.scenicButton.titleLabel setFont:Font15];
        [self.scenicButton setImage:IMAGE(@"ST_Discovery_Scenic") forState:(UIControlStateNormal)];
        [self.scenicButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [v2 addSubview:self.scenicButton];
        [self.scenicButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.top.bottom.left.equalTo(v2);
        }];
        
        self.foodsButton = [UIButton new];
        [self.foodsButton setTitle:@"美食10" forState:UIControlStateNormal];
        [self.foodsButton setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.foodsButton.titleLabel setFont:Font15];
        [self.foodsButton setImage:IMAGE(@"ST_Discovery_Foods") forState:(UIControlStateNormal)];
        [self.foodsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [v2 addSubview:self.foodsButton];
        [self.foodsButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.top.bottom.equalTo(v2);
            make.centerX.equalTo(v2);
        }];
        
        self.hostelButton = [UIButton new];
        [self.hostelButton setTitle:@"民宿10" forState:UIControlStateNormal];
        [self.hostelButton setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.hostelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [self.hostelButton.titleLabel setFont:Font15];
        [self.hostelButton setImage:IMAGE(@"ST_Discovery_Hostel") forState:(UIControlStateNormal)];
        [v2 addSubview:self.hostelButton];
        [self.hostelButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.top.bottom.right.equalTo(v2);
        }];
    }
    return self;
}


@end
