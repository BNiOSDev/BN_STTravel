//
//  LBB_ScenicDetailPriceMsgCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailPriceMsgCell.h"
#import "PoohCommon.h"
#import "LBB_StarRatingViewController.h"
#import "LBB_NearSign.h"

@implementation LBB_ScenicDetailPriceMsgCell

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
        [self.titleLabel setText:@"厦门曾厝垵景区"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(margin);
            make.centerX.equalTo(ws.contentView);
        }];
        
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setFont:Font13];
        [self.priceLabel setText:@"230元起/1人"];
        [self.priceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(2*margin);
            make.centerX.equalTo(ws.contentView);
        }];
        
        
        self.signButton = [UIButton new];
        [self.signButton setBackgroundImage:IMAGE(@"景点详情_签到") forState:UIControlStateNormal];
        [self.contentView addSubview:self.signButton];
        [self.signButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.priceLabel);
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.width.height.mas_equalTo(AutoSize(22));
        }];
        [self.signButton bk_whenTapped:^{
            
            [LBB_NearSign signObjId:ws.model.allSpotsId type:(int)ws.model.allSpotsType block:^(NSError* error){
                if (!error) {
                    ws.model.isSigned = YES;
                }
                else{
                    Base_BaseViewController* curVC = (Base_BaseViewController*)[ws getViewController];
                    [curVC showHudPrompt:error.domain];

                }
            }];
    
        }];
        
        
        self.signLabel = [UILabel new];
        [self.signLabel setText:@"签到"];
        [self.signLabel setFont:Font10];
        [self.contentView addSubview:self.signLabel];
        [self.signLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.signButton);
            make.top.equalTo(ws.signButton.mas_bottom).offset(margin);
        }];
        
        //点赞
        UIView* v = [UIView new];
        [self.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.centerY.equalTo(ws.signLabel);
        }];
        
        self.greatView = [[UIButton alloc]init];
        [self.greatView setImage:IMAGE(@"景点专题_点赞")forState:UIControlStateNormal];
        [self.greatView setTitle:@"190" forState:UIControlStateNormal];
        [self.greatView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greatView.titleLabel setFont:Font12];
        [self.greatView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [v addSubview:self.greatView];
        [self.greatView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.bottom.equalTo(v);
            //make.height.mas_equalTo(@15);
        }];

        
        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"景点专题_评论")forState:UIControlStateNormal];
        [self.commentsView setTitle:@"1000" forState:UIControlStateNormal];
        [self.commentsView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.commentsView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [v addSubview: self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.greatView.mas_right).offset(margin+4);
            make.centerY.height.equalTo(ws.greatView);
        }];
        
        self.favoriteView = [[UIButton alloc]init];
        [self.favoriteView setImage:IMAGE(@"景点专题_小收藏")forState:UIControlStateNormal];
        [self.favoriteView setTitle:@"1000" forState:UIControlStateNormal];
        [self.favoriteView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.favoriteView.titleLabel setFont:Font12];
        [self.favoriteView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [v addSubview: self.favoriteView];
        [self.favoriteView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.commentsView.mas_right).offset(margin+4);
            make.centerY.height.equalTo(ws.greatView);
            make.right.equalTo(v);
        }];
        

        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(v.mas_bottom).offset(2*margin);
        }];
        
#pragma action
        [self.commentsView bk_whenTapped:^{
            
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc] init];
            dest.allSpotsType = (int)ws.model.allSpotsType;// 场景类型 1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记9足迹  10 线路攻略11 美食专题 12民宿专题
            dest.allSpotsId = ws.model.allSpotsId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.greatView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            [ws.model like:^(NSError* error){
            
            }];
            
        }];
        [self.favoriteView bk_whenTapped:^{
            [ws.model collecte:^(NSError* error){
                
            }];
        }];
    }
    return self;
}


-(void)setModel:(LBB_SpotDetailsViewModel *)model{
    
    _model = model;
    
    [self.titleLabel setText:model.allSpotsName];
    
    // 点赞标志 0未点赞 1：点赞
    @weakify(self);
    [RACObserve(self.model, isLiked) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        BOOL status = [num boolValue];
        if (status) {
            [self.greatView setImage:IMAGE(@"景点专题_点赞HL")forState:UIControlStateNormal];
        }
        else{
            [self.greatView setImage:IMAGE(@"景点专题_点赞")forState:UIControlStateNormal];
        }
    }];
    
    // 点赞次数
    [RACObserve(self.model, likeNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        int likenum = [num intValue];
        [self.greatView setTitle:[NSString stringWithFormat:@"%d",likenum] forState:UIControlStateNormal];
    }];
    // 评论条数
    [RACObserve(self.model, commentsNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        int likenum = [num intValue];
        [self.commentsView setTitle:[NSString stringWithFormat:@"%d",likenum] forState:UIControlStateNormal];
    }];
    // 收藏次数
    [RACObserve(self.model, collecteNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        int likenum = [num intValue];
        [self.favoriteView setTitle:[NSString stringWithFormat:@"%d",likenum] forState:UIControlStateNormal];
    }];
    
    // 是否收藏
    [RACObserve(self.model, isCollected) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        BOOL status = [num boolValue];
        if (status) {
            [self.favoriteView setImage:IMAGE(@"景点专题_小收藏HL")forState:UIControlStateNormal];
        }
        else{
            [self.favoriteView setImage:IMAGE(@"景点专题_小收藏")forState:UIControlStateNormal];
        }
    }];
    
    
    // 是否签到
    [RACObserve(self.model, isSigned) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        BOOL status = [num boolValue];
        if (status) {
            [self.signLabel setText:@"已签到"];
        }
        else{
            [self.signLabel setText:@"签到"];
        }
    }];
    
    //单价设置
    NSString* strFormat1 = [NSString stringWithFormat:@"%@元起/人",model.realPrice];
    NSString* strFormat2 = @"元";
    UIColor* fontColor = ColorBtnYellow;
    NSDictionary* attrsDic = @{NSForegroundColorAttributeName:fontColor,
                               NSFontAttributeName:[UIFont systemFontOfSize:20]};    //显示的字符串进行富文本转换
    NSMutableAttributedString* strAttr = [[NSMutableAttributedString alloc]initWithString:strFormat1];
    //字体设置
    NSRange rang = [strFormat1 rangeOfString:strFormat2];
    if (rang.location != NSNotFound) {
        NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
        [strAttr addAttributes:attrsDic range:NSMakeRange(0, rang.location)];
    }else{
        NSLog(@"Not Found");
    }
    self.priceLabel.attributedText = strAttr;

    
}


@end
