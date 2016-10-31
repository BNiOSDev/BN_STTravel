//
//  LBB_NewOrderTicketTypeInfoView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderTicketTypeInfoView.h"
#import "PoohCommon.h"
@implementation LBB_NewOrderTicketTypeInfoBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    
    WS(ws);
    if (self = [super init]) {
     
        CGFloat margin = 8;
        self.typeLabel = [UILabel new];
        [self.typeLabel setTextColor:ColorGray];
        [self.typeLabel setFont:Font13];
        [self.typeLabel setText:@"成人"];
        [self addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.centerY.equalTo(ws);
        }];
        
        self.textField = [[LBB_PoohPlusMinTextField alloc]init];
        [self.textField setTextNum:2];
        [self.textField.textField setFont:Font13];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws);
            make.left.equalTo(ws.typeLabel.mas_right).offset(2*margin);
            make.height.mas_equalTo(AutoSize(36/2));
            make.width.mas_equalTo(AutoSize(150/2));
        }];
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setTextColor:ColorGray];
        [self.priceLabel setFont:Font13];
        [self.priceLabel setText:@"￥100.00"];
        [self.priceLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.centerY.equalTo(ws);
        }];
        
        
    }
    return self;
}

@end



@implementation LBB_NewOrderTicketTypeInfoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id)init{
    
    WS(ws);
    if (self = [super init]) {
        
        CGFloat margin = 8;
      
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.top.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth*0);
        }];
        
        //描绘门票类型部分的UI
        
        UILabel* ticketTypeLabel = [UILabel new];
        [ticketTypeLabel setText:@"门票类型"];
        [ticketTypeLabel setFont:Font15];
        [self addSubview:ticketTypeLabel];
        [ticketTypeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(2*margin);
            make.top.equalTo(sep.mas_bottom).offset(2*margin);
        }];
        
        UILabel* priceLabel = [UILabel new];
        [priceLabel setText:@"金额"];
        [priceLabel setFont:Font15];
        [self addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws).offset(-2*margin);
            make.centerY.equalTo(ticketTypeLabel);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ticketTypeLabel.mas_bottom).offset(2*margin);
            make.left.equalTo(ticketTypeLabel);
            make.right.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        
        //门票内容view
        UIView* ticketContentView = [UIView new];
        [self addSubview:ticketContentView];
        [ticketContentView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(sep1.mas_bottom);
            make.centerX.width.equalTo(ws);
        }];
        self.ticketContentView = ticketContentView;
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){

            make.left.right.bottom.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ticketContentView.mas_bottom).offset(2*margin);
        }];
        
    }
    return self;
}

-(void)setTicketInfo:(NSArray*)arrayInfo{
    WS(ws);
    UIView* last;
    CGFloat margin = 8;
    NSInteger count = arc4random()%10;
    for (int i = 0; i<count; i++) {
        
        CGFloat height = AutoSize(52/2);
        LBB_NewOrderTicketTypeInfoBaseView* info = [[LBB_NewOrderTicketTypeInfoBaseView alloc]init];
        [self.ticketContentView addSubview:info];
        [info mas_makeConstraints:^(MASConstraintMaker* make){
            
            
            make.left.equalTo(ws.ticketContentView).offset(2*margin);
            make.right.equalTo(ws.ticketContentView).offset(-2*margin);
            make.height.mas_equalTo(height);
            if (last) {
                make.top.equalTo(last.mas_bottom).offset(2*margin);
            }
            else{
                make.top.equalTo(ws.ticketContentView).offset(2*margin);
            }
            if (i == (count-1)) {//最后一个
                make.bottom.equalTo(ws.ticketContentView);
            }
        }];
        
        last = info;
    }
}
@end
