//
//  LBB_NewOrderIntegralView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderIntegralView.h"
#import "PoohCommon.h"
@implementation LBB_NewOrderIntegralView

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
        
        UILabel* deductInfoLabel = [UILabel new];
        [deductInfoLabel setFont:Font13];
        [deductInfoLabel setText:@"可用60积分抵￥0.60"];
        [self addSubview:deductInfoLabel];
        [deductInfoLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(2*margin);
            make.top.equalTo(ws).offset(2*margin);
        }];
        self.deductInfoLabel = deductInfoLabel;
        
        self.checkButton = [UIButton new];
        [self.checkButton setBackgroundImage:IMAGE(@"确认订单_选择") forState:UIControlStateNormal];
        [self addSubview:self.checkButton];
        [self.checkButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(deductInfoLabel);
            make.right.equalTo(ws).offset(-2*margin);
            make.width.height.mas_equalTo(AutoSize(14));
        }];
        
        UILabel* noteLabel = [UILabel new];
        [noteLabel setText:@"可使用积分抵扣"];
        [noteLabel setFont:Font13];
        [noteLabel setTextColor:ColorLightGray];
        [self addSubview:noteLabel];
        [noteLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(deductInfoLabel);
            make.right.equalTo(ws.checkButton.mas_left).offset(-2*margin);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(deductInfoLabel.mas_bottom).offset(2*margin);
        }];
        
        
        //商品总额
        UILabel* goodsLabel = [UILabel new];
        [goodsLabel setText:@"商品总额"];
        [noteLabel setFont:Font13];
        [goodsLabel setTextColor:ColorGray];
        [self addSubview:goodsLabel];
        [goodsLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(sep1.mas_bottom).offset(2*margin);
            make.left.equalTo(deductInfoLabel);
        }];
        
        self.goodPriceLabel = [UILabel new];
        [self.goodPriceLabel setText:@"￥800.00"];
        [self.goodPriceLabel setFont:Font13];
        [self.goodPriceLabel setTextColor:ColorRed];
        [self addSubview:self.goodPriceLabel];
        [self.goodPriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(goodsLabel);
            make.right.equalTo(ws.checkButton).offset(-2*margin);
        }];
        
        //积分抵扣
        UILabel* deductLabel = [UILabel new];
        [deductLabel setText:@"积分抵扣"];
        [deductLabel setFont:Font13];
        [deductLabel setTextColor:ColorGray];
        [self addSubview:deductLabel];
        [deductLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(goodsLabel.mas_bottom).offset(2*margin);
            make.left.equalTo(goodsLabel);
        }];
        
        self.deductPriceLabel = [UILabel new];
        [self.deductPriceLabel setText:@"-￥80.00"];
        [self.deductPriceLabel setFont:Font13];
        [self.deductPriceLabel setTextColor:ColorRed];
        [self addSubview:self.deductPriceLabel];
        [self.deductPriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(deductLabel);
            make.right.equalTo(ws.checkButton).offset(-2*margin);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(deductLabel.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws);
        }];
        
        
        //绑定数据
        [self configIntegralInfo];
    }
    return self;
}

//绑定数据
-(void)configIntegralInfo{

    self.rate = 0.1;
    self.integralNum = arc4random()%200;//随机产生积分
    self.goodPrice = (CGFloat)(arc4random()%1000);//随机产生总价格
    

    
    @weakify (self);
    
    [RACObserve(self, integralNum) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        self.deductPrice = self.integralNum * self.rate;
        
    }];

    [RACObserve(self, rate) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        self.deductPrice = self.integralNum * self.rate;
    }];
    
    [RACObserve(self, deductPrice) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        [self.deductInfoLabel setText:[NSString stringWithFormat:@"可用%ld积分抵￥%0.2f",self.integralNum,self.deductPrice]];
    }];

    [RACObserve(self, goodPrice) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        [self.goodPriceLabel setText:[NSString stringWithFormat:@"￥%0.2f",self.goodPrice]];
    }];
    
    
    [RACObserve(self, isCheck) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        if (self.isCheck) {
            [self.checkButton setBackgroundImage:IMAGE(@"确认订单_选择HL") forState:UIControlStateNormal];
            [self.deductPriceLabel setText:[NSString stringWithFormat:@"-￥%0.2f",self.deductPrice]];

        }
        else{
            [self.checkButton setBackgroundImage:IMAGE(@"确认订单_选择") forState:UIControlStateNormal];
            [self.deductPriceLabel setText:[NSString stringWithFormat:@"-￥0.00"]];
        }
    }];

    [[self.checkButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton* btn){
         @strongify(self);
         self.isCheck = !self.isCheck;
        // [self configIntegralInfo];
         
     }];
    
}

@end
