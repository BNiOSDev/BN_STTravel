//
//  LBB_NewOrderInputTextField.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderInputTextField.h"
#import "PoohCommon.h"

@interface LBB_NewOrderInputTextField()

@property(nonatomic, retain)NSTimer* countDownTimer;
@property(nonatomic, assign)NSInteger secondsCountDown;

@end

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
        [self.textField setFont:Font12];
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
        
        [self setRightButtonCountDown];//倒计时的检测
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

-(void)setCutDown:(NSTimeInterval)interval{

    //设置倒计时总时长
    self.secondsCountDown = interval;
    //开始倒计时
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    
    //设置倒计时显示的时间
}
-(void)timeFireMethod{
    //倒计时-1
    self.secondsCountDown--;
    //修改倒计时标签现实内容
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(self.secondsCountDown == 0){
        [self.countDownTimer invalidate];
    }
}

-(void)setRightButtonCountDown{
    
    @weakify (self);
    
    [RACObserve(self, secondsCountDown) subscribeNext:^(NSNumber* index) {
        @strongify(self);
        
        if (self.secondsCountDown <= 0) {

            self.rightButton.enabled = YES;
            [self.rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            
        }
        else{
            self.rightButton.enabled = NO;
            [self.rightButton setTitle:[NSString stringWithFormat:@"%lds",self.secondsCountDown] forState:UIControlStateNormal];
        }
    }];
}

@end
