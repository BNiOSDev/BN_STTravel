//
//  LBB_NewOrderModifyNoteView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderModifyNoteView.h"
#import "PoohCommon.h"
@implementation LBB_NewOrderModifyNoteView

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
     
        UILabel* returnLabel = [UILabel new];
        [returnLabel setText:@"退改说明"];
        [returnLabel setTextColor:ColorBlack];
        [returnLabel setFont:Font14];
        [self addSubview:returnLabel];
        [returnLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(2*margin);
            make.top.equalTo(sep.mas_bottom).offset(2*margin);
        }];
        
        UIButton* scaleButton = [UIButton new];
        [scaleButton setBackgroundImage:IMAGE(@"确认订单_选择HL") forState:UIControlStateNormal];
        [self addSubview:scaleButton];
        [scaleButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws).offset(-2*margin);
            make.centerY.equalTo(returnLabel);
            make.width.height.mas_equalTo(AutoSize(36/2));
        }];
        
        UILabel* returnNoteLabel = [UILabel new];
        [returnNoteLabel setFont:Font12];
        [returnNoteLabel setNumberOfLines:0];
        [returnNoteLabel setTextColor:ColorGray];
        [returnNoteLabel setText:@"大大大大大吧打算你打吧妈的被骂啊什么你不打算你打吧妈的被骂啊什么你不打不骂打算你打吧妈的被骂啊什么你不打不骂打不骂"];
        [self addSubview:returnNoteLabel];
        [returnNoteLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(returnLabel);
            make.right.equalTo(scaleButton);
            make.top.equalTo(returnLabel.mas_bottom).offset(2*margin);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(returnNoteLabel.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws);
        }];
        
        [[scaleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* btn){
        
            self.isOpen = !self.isOpen;
        }];
        
        
        @weakify (self);
        
        [RACObserve(self, isOpen) subscribeNext:^(NSNumber* index) {
            @strongify(self);

            if (self.isOpen) {
                [returnNoteLabel setText:@"大大大大大吧打算你打吧妈的被骂啊什么你不打算你打吧妈的被骂啊什么你不打不骂打算你打吧妈的被骂啊什么你不打不骂打不骂"];
                [returnNoteLabel mas_remakeConstraints:^(MASConstraintMaker* make){
                    make.left.equalTo(returnLabel);
                    make.right.equalTo(scaleButton);
                    make.top.equalTo(returnLabel.mas_bottom).offset(2*margin);
                }];
            }
            else{
                [returnNoteLabel setText:@""];
                [returnNoteLabel mas_remakeConstraints:^(MASConstraintMaker* make){
                    make.left.equalTo(returnLabel);
                    make.right.equalTo(scaleButton);
                    make.top.equalTo(returnLabel.mas_bottom).offset(2*margin*0);
                }];
            }
            
            [self layoutIfNeeded];
        }];
        
    }
    return self;
}

@end
