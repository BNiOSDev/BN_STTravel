//
//  LBB_HomeSearchGoodsCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeSearchGoodsCell.h"

@implementation LBB_HomeSearchGoodsCell

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
        CGFloat margin = 8;

        self.goodImageView = [UIImageView new];
        self.goodImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.goodImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.goodImageView];
        [self.goodImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.contentView).offset(margin/2);
            make.bottom.equalTo(ws.contentView).offset(-margin/2);
            make.height.width.mas_equalTo(AutoSize(100));
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setTextColor:ColorGray];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setText:@"啊大大大科技活动大家客户端"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.goodImageView.mas_right).offset(margin);
            make.top.equalTo(ws.goodImageView).offset(margin);
        }];
        
        self.weightLable = [UILabel new];
        [self.weightLable setTextColor:ColorGray];
        [self.weightLable setFont:Font15];
        [self.weightLable setText:@"约179-190g"];
        [self.contentView addSubview:self.weightLable];
        [self.weightLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(0.5*margin);
        }];
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setTextColor:ColorGray];
        [self.priceLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self.priceLabel setText:@"￥41.00"];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.goodImageView.mas_centerY).offset(margin);
        }];
        
        self.originalPriceLabel = [UILabel new];
        [self.originalPriceLabel setTextColor:ColorLightGray];
        [self.originalPriceLabel setFont:Font10];
        [self.originalPriceLabel setText:@"￥19"];
        [self.contentView addSubview:self.originalPriceLabel];
        [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.priceLabel.mas_right).offset(margin);
            make.bottom.equalTo(ws.priceLabel);
        }];
        
        self.evaluateLabel = [UILabel new];
        [self.evaluateLabel setTextColor:ColorLightGray];
        [self.evaluateLabel setFont:Font10];
        [self.evaluateLabel setText:@"98条评价"];
        [self.contentView addSubview:self.evaluateLabel];
        [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.priceLabel.mas_bottom).offset(0.5*margin);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel);
            make.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.right.equalTo(ws.contentView).offset(-margin);
        }];
    }
    return self;
}

-(void)setModel:(id)model{

    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/h%3D200/sign=5c00db24cd95d143c576e32343f18296/03087bf40ad162d9ec74553b14dfa9ec8a13cd7a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    
    
    //删除的价格设置
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"￥19"
                                                                 attributes:
                                   @{NSFontAttributeName:Font10,
                                     NSForegroundColorAttributeName:ColorLightGray,
                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                     NSStrikethroughColorAttributeName:[UIColor blackColor]}];
    self.originalPriceLabel.attributedText = attrStr;
}

@end
