//
//  LBB_ScenicMainTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicMainTableViewCell.h"


@implementation LBB_ScenicMainTableViewCell

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

        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(360/2));
        }];
        
        self.favoriteButton  = [UIButton new];
        [self.favoriteButton setBackgroundImage:IMAGE(@"景点详情_收藏HL") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.top.equalTo(ws.bgImageView).offset(2*margin);
            make.width.height.mas_equalTo(AutoSize(15));
        }];
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.titleLabel setText:@"厦门漫步之旅，住2晚厦门希尔顿玉林酒店"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.bgImageView).offset(2*margin);
            make.right.equalTo(ws.bgImageView).offset(-2*margin);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(margin);
        }];
        
        self.addressLabel = [UILabel new];
        [self.addressLabel setFont:Font13];
        [self.addressLabel setText:@"鹿角路"];
        [self.addressLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker* make){

            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(margin);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.addressLabel.mas_right).offset(3);
            make.centerY.equalTo(ws.addressLabel);
            make.height.equalTo(ws.addressLabel).offset(-3);
            make.width.mas_equalTo(SeparateLineWidth);
        }];
        
        self.streetLabel = [UILabel new];
        [self.streetLabel setFont:Font13];
        [self.streetLabel setText:@"鼓浪屿景区"];
        [self.streetLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.streetLabel];
        [self.streetLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(sep.mas_right).offset(3);
            make.centerY.height.equalTo(ws.addressLabel);
        }];
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.streetLabel.mas_right).offset(3);
            make.centerY.equalTo(ws.addressLabel);
            make.height.width.equalTo(sep);
        }];
        self.distanceLabel = [UILabel new];
        [self.distanceLabel setFont:Font13];
        [self.distanceLabel setText:@"90km"];
        [self.distanceLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.distanceLabel];
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(sep1.mas_right).offset(2);
            make.centerY.height.equalTo(ws.addressLabel);
        }];
        
        //right
        self.deletePriceLabel = [UILabel new];
        [self.deletePriceLabel setFont:Font10];
        [self.deletePriceLabel setText:@"230"];
        [self.deletePriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.deletePriceLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.deletePriceLabel];
        [self.deletePriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.centerY.equalTo(ws.addressLabel);
        }];
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setFont:Font10];
        [self.priceLabel setText:@"230元起/1人"];
        [self.priceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.deletePriceLabel.mas_left).offset(-8);
            make.centerY.equalTo(ws.addressLabel);
        }];
        
        self.greetView = [[LBBPoohGreatItemView alloc]init];
        [self.greetView.iconView setImage:IMAGE(@"ST_Home_Great")];
        [self.greetView.desLabel setText:@"190"];
        [self.greetView.desLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.addressLabel.mas_bottom).offset(margin);
            make.height.mas_equalTo(@15);
        }];
        [self.greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        
        self.commentsView = [[LBBPoohGreatItemView alloc]init];
        [ self.commentsView.iconView setImage:IMAGE(@"ST_Home_Comments")];
        [ self.commentsView.desLabel setText:@"1000"];
        [ self.commentsView.desLabel setTextColor:ColorLightGray];
        [self.contentView addSubview: self.commentsView];
        [ self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.greetView.mas_right).offset(margin/2);
            make.centerY.height.equalTo(ws.greetView);
        }];
        
        [self.commentsView bk_whenTapped:^{

        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.greetView.mas_bottom).offset(margin);
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
                               NSFontAttributeName:Font15};    //显示的字符串进行富文本转换
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
    
    //删除的价格设置
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"130"
                                  attributes:
       @{NSFontAttributeName:Font10,
    NSForegroundColorAttributeName:ColorLightGray,
    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    NSStrikethroughColorAttributeName:[UIColor blackColor]}];
    self.deletePriceLabel.attributedText = attrStr;
    
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/h%3D200/sign=5c00db24cd95d143c576e32343f18296/03087bf40ad162d9ec74553b14dfa9ec8a13cd7a.jpg"] placeholderImage:IMAGE(@"poohtest")];

}

@end
