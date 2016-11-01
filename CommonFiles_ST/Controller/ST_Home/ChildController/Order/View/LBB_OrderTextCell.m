//
//  LBB_OrderTextCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderTextCell.h"

@implementation LBB_OrderTextCell

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
        
        self.textLabel1 = [UILabel new];
        [self.textLabel1 setFont:Font15];
        [self.textLabel1 setTextColor:ColorGray];
        [self.contentView addSubview:self.textLabel1];
        [self.textLabel1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.width.mas_greaterThanOrEqualTo(70);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);

        }];
        
        self.textLabel2 = [UILabel new];
        [self.textLabel2 setFont:Font15];
        [self.textLabel2 setTextColor:ColorGray];
        [self.contentView addSubview:self.textLabel2];
        [self.textLabel2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.textLabel1.mas_right).offset(2*margin);
        }];
        
      
        self.textLabel3 = [UILabel new];
        [self.textLabel3 setFont:Font15];
        [self.textLabel3 setTextColor:ColorBtnYellow];
        [self.textLabel3 setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.textLabel3];
        [self.textLabel3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
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

    
    switch (self.ticketStatus) {
        case LBBPoohTicketStatusWaitPay:
            [self.textLabel3 setText:@"待支付"];
            
            break;
        case LBBPoohTicketStatusWaitCollect:
            [self.textLabel3 setText:@"待取票"];
            
            break;
        case LBBPoohTicketStatusCollected:
            [self.textLabel3 setText:@"已取票"];
            
            break;
        case LBBPoohTicketStatusRefunded:
            [self.textLabel3 setText:@"已退款"];
            break;
        case LBBPoohTicketStatusWaitEvaluation:
            [self.textLabel3 setText:@"待评价"];
            break;
    }
    
    switch (self.indexPath.row) {
        case 0:
        {
            [self.textLabel1 setText:@"门票编号"];
            [self.textLabel2 setText:@"123456789"];
        }
            break;
        case 1:
        {
            [self.textLabel1 setText:@"取票人信息"];
            [self.textLabel2 setText:@""];
            [self.textLabel3 setText:@""];
        }
            
            break;
        case 2:
        {
            [self.textLabel1 setText:@"王大锤"];
            [self.textLabel2 setText:@"186***12736"];
            [self.textLabel3 setText:@""];
        }
            
            break;
    }
}

@end
