//
//  LBB_ScenicDetailTravelRecommendCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailTravelRecommendCell.h"

@implementation LBB_ScenicDetailTravelRecommendCell

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
        
        CGFloat width = AutoSize(287/2);
        CGFloat height = AutoSize(177/2);

        self.mainImageView = [UIImageView new];
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
        }];
        self.titleLabel = [UILabel new];
        [self.titleLabel setText:@"厦门大学打算的骄傲大的"];
        [self.titleLabel setTextColor:ColorBlack];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.mainImageView.mas_right).offset(margin);
            make.top.equalTo(ws.mainImageView);
            make.right.equalTo(ws.contentView).offset(-2);
        }];
        
        self.addressLabel = [UILabel new];
        [self.addressLabel setFont:Font13];
        [self.addressLabel setText:@"白鹭洲公寓"];
        [self.addressLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(margin);
            make.right.equalTo(ws.titleLabel);
        }];
        self.priceLable = [UILabel new];
        [self.priceLable setFont:Font13];
        [self.priceLable setTextColor:ColorBtnYellow];
        [self.priceLable setText:@"120元起/人"];
        [self.contentView addSubview:self.priceLable];
        [self.priceLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.addressLabel.mas_bottom).offset(margin);
            make.right.equalTo(ws.titleLabel);
        }];
        
        CGFloat btnHeight = AutoSize(35/2);
        CGFloat btnWidth = AutoSize(108/2);
        self.styleButton = [UIButton new];
        [self.styleButton setTitle:@"浪漫风暴" forState:UIControlStateNormal];
        [self.styleButton setTitleColor:ColorGray forState:UIControlStateNormal];
        self.styleButton.layer.cornerRadius = btnHeight/2;
        self.styleButton.layer.borderWidth = SeparateLineWidth;
        self.styleButton.layer.borderColor = ColorLine.CGColor;
        self.styleButton.layer.masksToBounds = YES;
        [self.styleButton.titleLabel setFont:Font10];
        [self.contentView addSubview:self.styleButton];
        [self.styleButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.bottom.equalTo(ws.mainImageView.mas_bottom).offset(-margin);
            make.width.mas_equalTo(btnWidth);
            make.height.mas_equalTo(btnHeight);
        }];
    
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(2*margin);
            make.height.mas_equalTo(SeparateLineWidth);
            make.bottom.equalTo(ws.contentView);
        }];
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
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
    self.priceLable.attributedText = strAttr;
    
}

@end
