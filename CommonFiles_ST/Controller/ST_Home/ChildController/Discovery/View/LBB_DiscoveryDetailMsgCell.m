//
//  LBB_DiscoveryDetailInfoCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryDetailMsgCell.h"
#import "PoohCommon.h"
#import "LBB_StarRatingViewController.h"

@implementation LBB_DiscoveryDetailMsgCell
{
    RACDisposable* racCollecteNum;
    RACDisposable* racLikeNum;
    RACDisposable* racCommentsNum;
}
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
            
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc] init];
            dest.allSpotsType = 10;// 场景类型 1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记9足迹  10 线路攻略11 美食专题 12民宿专题
            dest.allSpotsId = ws.model.lineId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
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

-(void)setModel:(LBB_DiscoveryDetailModel *)model{
    
    _model = model;

    [self.titleLabel setText:model.name];// 标题
    [self.timeLabel setText:model.lineTime];// 线路时长 如:1日游
    
    @weakify(self);
    [racCollecteNum dispose];
    [racLikeNum dispose];
    [racCommentsNum dispose];

    racLikeNum = [RACObserve(model, likeNum) subscribeNext:^(NSNumber* num){// 点赞次数
        @strongify(self);
        [self.greatButton setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    
    racCommentsNum = [RACObserve(model, commentsNum) subscribeNext:^(NSNumber* num){// 评论条数
        @strongify(self);
        [self.commentsButton setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    
    racCollecteNum = [RACObserve(model, collecteNum) subscribeNext:^(NSNumber* num){// 收藏次数
        @strongify(self);
        [self.favoriteButton setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    

    [self.self.scenicButton setTitle:[NSString stringWithFormat:@"景点%d",model.totalScenicSpots] forState:UIControlStateNormal];// 景点个数
    [self.self.foodsButton setTitle:[NSString stringWithFormat:@"美食%d",model.totalFood] forState:UIControlStateNormal];// 美食个数
    [self.self.hostelButton setTitle:[NSString stringWithFormat:@"民宿%d",model.totalHomestay] forState:UIControlStateNormal];// 民宿个数
    
    // 点赞标志 0未点赞 1：点赞
    if (model.isLiked) {
        [self.greatButton setImage:IMAGE(@"景点专题_点赞HL") forState:UIControlStateNormal];
    }
    else{
        [self.greatButton setImage:IMAGE(@"景点专题_点赞") forState:UIControlStateNormal];
    }
    // 收藏标志 0未收藏 1：收藏
    if (model.isCollected) {
        [ self.favoriteButton setImage:IMAGE(@"景点专题_小收藏HL") forState:UIControlStateNormal];
    }
    else{
        [ self.favoriteButton setImage:IMAGE(@"景点专题_小收藏") forState:UIControlStateNormal];
    }
}

@end
