//
//  LBB_NewOrderInputTextField.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderInputTextField.h"
#import "PoohCommon.h"
@implementation LBB_NewOrderInputTextField

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
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font13];
        [self.titleLabel setTextColor:ColorGray];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(sep.mas_bottom).offset(2* margin);
            make.left.equalTo(ws).offset(2*margin);
           // make.width.mas_equalTo(AutoSize(136/2));
        }];
        
        self.textField = [UITextField new];
        [self.textField setFont:Font13];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.titleLabel.mas_right).offset(margin);
            make.centerY.equalTo(ws.titleLabel);
            make.height.equalTo(ws.titleLabel);
        }];
        
        self.rightButton = [UIButton new];
        [self.rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.rightButton setBackgroundColor:ColorGray];
        [self.rightButton.titleLabel setFont:Font15];
        [self addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.textField.mas_right).offset(margin);
            make.centerY.equalTo(ws.titleLabel);
            make.height.mas_equalTo(AutoSize(50/2));
            make.width.mas_equalTo(AutoSize(172/2)*0);
            make.right.equalTo(ws).offset(-2*margin);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth*0);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws);
        }];
        
        [self layoutSubviews];
        
    }
    return self;
}

-(void)showRightButton:(BOOL)show{

    WS(ws);
    CGFloat margin = 8;

    if (show) {
        
        self.rightButton.hidden = NO;
        
        [self.textField mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.titleLabel.mas_right).offset(margin);
            make.centerY.equalTo(ws.titleLabel);
            make.height.equalTo(ws.titleLabel);
        }];
        
        [self.rightButton mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.textField.mas_right).offset(margin);
            make.centerY.equalTo(ws.titleLabel);
            make.height.mas_equalTo(AutoSize(50/2));
            make.width.mas_equalTo(AutoSize(172/2));
            make.right.equalTo(ws).offset(-2*margin);
        }];
    }
    else{
        self.rightButton.hidden = YES;

        [self.textField mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.titleLabel.mas_right).offset(margin);
            make.centerY.equalTo(ws.titleLabel);
            make.height.equalTo(ws.titleLabel);
        }];
        
        [self.rightButton mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.textField.mas_right).offset(margin);
            make.centerY.equalTo(ws.titleLabel);
            make.height.mas_equalTo(AutoSize(50/2));
            make.width.mas_equalTo(AutoSize(172/2)*0);
            make.right.equalTo(ws).offset(-2*margin);
        }];
        
    }
    
}

@end
