//
//  LBB_PoohPlusMinTextField.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohPlusMinTextField.h"
#import "PoohCommon.h"
@implementation LBB_PoohPlusMinTextField

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
        
        
        self.minButton = [UIButton new];
        [self.minButton setTitle:@"-" forState:UIControlStateNormal];
        [self.minButton setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.minButton setTitleColor:ColorLightGray forState:UIControlStateDisabled];
        [self addSubview:self.minButton];
        [self.minButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.top.bottom.equalTo(ws);
            make.width.mas_equalTo(ws.minButton.mas_height).offset(5);
            make.left.equalTo(ws);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorGray];
        [self addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.equalTo(ws.minButton);
            make.width.mas_equalTo(0.3);
            make.left.equalTo(ws.minButton.mas_right);
        }];
        self.sep1 = sep;
        
        self.textField = [UITextField new];
        [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
        [self.textField setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(sep.mas_right);
            make.centerY.height.equalTo(ws.minButton);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorGray];
        [self addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.equalTo(ws.minButton);
            make.width.equalTo(sep);
            make.left.equalTo(ws.textField.mas_right);
        }];
        self.sep2 = sep2;
        
        self.plusButton = [UIButton new];
        [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
        [self.plusButton setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.plusButton setTitleColor:ColorLightGray forState:UIControlStateDisabled];
        [self addSubview:self.plusButton];
        [self.plusButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.top.bottom.equalTo(ws);
            make.width.equalTo(ws.minButton);
            make.right.equalTo(ws);
            make.left.equalTo(sep2.mas_right);
        }];
        
        self.layer.cornerRadius = 3;
        self.layer.borderColor = ColorGray.CGColor;
        self.layer.borderWidth = 0.6;
        self.layer.masksToBounds = YES;
        
        [self layoutSubviews];
        
        @weakify(self);
        [RACObserve(self, inputNum) subscribeNext:^(NSNumber *num) {
            @strongify(self);

            if ([num integerValue] <= 0) {
                self.minButton.enabled = NO;
            }
            else{
                self.minButton.enabled = YES;
            }
            if (self.maxNum > 0) {
                
                if ([num integerValue] >= self.maxNum) {
                    self.plusButton.enabled = NO;
                }
                else{
                    self.plusButton.enabled = YES;
                }
            }

            
            [self.textField setText:[NSString stringWithFormat:@"%ld",[num integerValue]]];
        }];
        
        [self.plusButton bk_addEventHandler:^(id sender){
        
            ws.inputNum = ws.inputNum  + 1;
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.minButton bk_addEventHandler:^(id sender){
            
            ws.inputNum = ws.inputNum  - 1;
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.textField.rac_textSignal subscribeNext:^(NSString* text){
            @strongify(self);

            if (self.maxNum > 0) {
                
                if (text.integerValue < self.maxNum) {
                    self.inputNum = [text integerValue];
                } else {
                    self.inputNum = self.maxNum;
                }
            }
            else{
                self.inputNum = [text integerValue];
            }
            
        }];
        
    }
    return self;
}

@end
