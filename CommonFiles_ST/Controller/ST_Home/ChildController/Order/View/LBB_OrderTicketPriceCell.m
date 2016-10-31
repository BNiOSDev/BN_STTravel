//
//  LBB_OrderTicketPriceCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderTicketPriceCell.h"

@implementation LBB_OrderTicketPriceCell

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
        
        self.titleLabel1 = [UILabel new];
        [self.titleLabel1 setFont:Font13];
        [self.titleLabel1 setTextColor:ColorGray];
        [self.contentView addSubview:self.titleLabel1];
        [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.width.mas_greaterThanOrEqualTo(70);
            make.top.equalTo(ws.contentView).offset(2*margin);
            
        }];
        
        self.priceLabel1 = [UILabel new];
        [self.priceLabel1 setFont:Font13];
        [self.priceLabel1 setTextColor:[UIColor redColor]];
        [self.contentView addSubview:self.priceLabel1];
        [self.priceLabel1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.titleLabel1);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        
        self.titleLabel2 = [UILabel new];
        [self.titleLabel2 setTextColor:ColorGray];
        [self.titleLabel2 setFont:Font13];
        [self.contentView addSubview:self.titleLabel2];
        [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel1);
            make.width.mas_greaterThanOrEqualTo(70);
            make.top.equalTo(ws.titleLabel1.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);
            
        }];
        
        self.priceLabel2 = [UILabel new];
        [self.priceLabel2 setFont:Font13];
        [self.priceLabel2 setTextColor:[UIColor redColor]];
        [self.contentView addSubview:self.priceLabel2];
        [self.priceLabel2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.titleLabel2);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        self.sepLineView = sep2;
        
    }
    return self;
}

-(void)setLineInset:(CGFloat)size andHeight:(CGFloat)height{
    WS(ws);
    [self.sepLineView mas_remakeConstraints:^(MASConstraintMaker* make){
        make.bottom.centerX.equalTo(ws.contentView);
        make.height.mas_equalTo(height);
        make.left.equalTo(ws.contentView).offset(size);
        make.right.equalTo(ws.contentView).offset(-size);
        
    }];
    [self.contentView layoutSubviews];
}

-(void)setModel:(id)model{
    
    [self.titleLabel1 setText:@"门票金额"];
    [self.priceLabel1 setText:@"￥800.00"];
    [self.titleLabel2 setText:@"积分抵扣"];
    [self.priceLabel2 setText:@"-￥10.00"];

    
}

@end
