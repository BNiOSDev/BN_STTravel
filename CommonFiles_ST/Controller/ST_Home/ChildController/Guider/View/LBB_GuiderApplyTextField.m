//
//  LBB_GuiderApplyTextField.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderApplyTextField.h"
#import "PoohCommon.h"
@implementation LBB_GuiderApplyTextField

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
        
        UIView* sub = [UIView new];
        [self addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            make.width.mas_equalTo(AutoSize(75));
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws).offset(1.5*margin);
            make.height.mas_equalTo(AutoSize(50/2));
        }];
        
        UILabel* mark = [UILabel new];
        [mark setTextColor:ColorRed];
        [mark setFont:Font15];
        [mark setText:@"*"];
        [sub addSubview:mark];
        [mark mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(sub);
            make.left.equalTo(sub);
            make.width.mas_equalTo(AutoSize(6));
        }];
        [mark sizeToFit];
        self.mark = mark;
        
        self.titleLable = [UILabel new];
        [self.titleLable setTextColor:ColorGray];
        [self.titleLable setFont:Font15];
        [self.titleLable setText:@"身份证号"];
        [sub addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(sub);
            make.left.equalTo(mark.mas_right).offset(3);
            make.top.bottom.equalTo(sub);
            make.right.equalTo(sub);
        }];
        
        self.rightTextField = [UITextField new];
        [self.rightTextField setTextColor:ColorGray];
        [self.rightTextField setFont:Font15];
        [self.rightTextField setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.rightTextField];
        [self.rightTextField mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(sub);
            make.left.equalTo(sub.mas_right).offset(margin);
            make.right.equalTo(ws).offset(-margin);
          //  make.top.equalTo(ws).offset(margin);
           // make.bottom.equalTo(ws).offset(-margin);
            make.height.equalTo(ws.titleLable);
        }];
        
        
        self.bottomTextField = [UITextView new];
        [self.bottomTextField setTextColor:ColorGray];
        [self.bottomTextField setFont:Font15];
        [self.bottomTextField setPlaceholder:@"请输入您的详细介绍"];
        [self.bottomTextField setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.bottomTextField];
        [self.bottomTextField mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLable);
            make.right.equalTo(ws.rightTextField);
            make.top.equalTo(ws.titleLable.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        self.sepLine = [UIView new];
        [self.sepLine setBackgroundColor:ColorLine];
        [self addSubview:self.sepLine];
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.titleLable.mas_bottom).offset(1.5*margin);
        }];
    }
    return self;
}

-(void)showBottomTextField:(BOOL)show{
    CGFloat margin = 8;

    WS(ws);
    if (show) {
        
        [self.rightTextField setUserInteractionEnabled:NO];
        
        [self.bottomTextField mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLable);
            make.right.equalTo(ws.rightTextField);
            make.top.equalTo(ws.titleLable.mas_bottom).offset(margin);
            make.height.mas_equalTo(AutoSize(70));
            make.bottom.equalTo(ws).offset(-margin);
        }];
        
        [self.sepLine mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
    }
    else{
        [self.rightTextField setUserInteractionEnabled:YES];

        [self.bottomTextField mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLable);
            make.right.equalTo(ws.rightTextField);
            make.top.equalTo(ws.titleLable.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        [self.sepLine mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.titleLable.mas_bottom).offset(2*margin);
        }];
    }
    [self layoutIfNeeded];
}

@end
