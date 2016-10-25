//
//  LBB_ScenicDetailPriceMsgCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailPriceMsgCell.h"
#import "PoohCommon.h"
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
        [self.priceLabel setFont:Font4];
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
        
        self.signLabel = [UILabel new];
        [self.signLabel setText:@"签到"];
        [self.signLabel setFont:Font2];
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
        
        self.greatView = [[LBBPoohGreatItemView alloc]init];
        [self.greatView.iconView setImage:IMAGE(@"ST_Home_Great")];
        [self.greatView.desLabel setText:@"190"];
        [self.greatView.desLabel setTextColor:ColorLightGray];
        [v addSubview:self.greatView];
        [self.greatView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.bottom.equalTo(v);
            make.height.mas_equalTo(@15);
        }];
        [self.greatView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        self.commentsView = [[LBBPoohGreatItemView alloc]init];
        [ self.commentsView.iconView setImage:IMAGE(@"ST_Home_Comments")];
        [ self.commentsView.desLabel setText:@"1000"];
        [ self.commentsView.desLabel setTextColor:ColorLightGray];
        [v addSubview: self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.greatView.mas_right).offset(margin/2);
            make.centerY.height.equalTo(ws.greatView);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
        }];
        
        self.favoriteView = [[LBBPoohGreatItemView alloc]init];
        [ self.favoriteView.iconView setImage:IMAGE(@"ST_Home_Comments")];
        [ self.favoriteView.desLabel setText:@"1000"];
        [ self.favoriteView.desLabel setTextColor:ColorLightGray];
        [v addSubview: self.favoriteView];
        [self.favoriteView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.commentsView.mas_right).offset(margin/2);
            make.centerY.height.equalTo(ws.greatView);
            make.right.equalTo(v);
        }];
        
        [self.favoriteView bk_whenTapped:^{
            
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(v.mas_bottom).offset(2*margin);
        }];
    }
    return self;
}


-(void)setModel:(id)model{
    
    NSInteger price = 120;
    NSInteger num = 1;
    
    //单价设置
    NSString* strFormat1 = [NSString stringWithFormat:@"%ld元起/%ld人",price,num];
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
