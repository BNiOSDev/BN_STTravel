//
//  LBB_SigninPopView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SigninPopView.h"
#import "PoohCommon.h"

@implementation LBB_SigninPopView

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
        
        [self setFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)];
        self.windowLevel = UIWindowLevelAlert+1;
        [self setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        
        UIView* bg = [UIView new];
        bg.layer.cornerRadius = 10;
        [bg setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.equalTo(ws);
            make.width.equalTo(@250);
            //make.height.equalTo(@300);
        }];

        UIImageView* img = [UIImageView new];
        [img setImage:IMAGE(@"ST_Sign_PopSigninIcon")];
        [bg addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(bg).offset(16);
            make.top.equalTo(bg).offset(30);
            make.width.height.equalTo(@100);
        }];
        
        self.locationLabel = [UILabel new];
        [self.locationLabel setText:@"鼓浪屿日光岩"];
        [self.locationLabel setTextAlignment:NSTextAlignmentCenter];
        [self.locationLabel setFont:Font5];
        [bg addSubview:self.locationLabel];
        [self.locationLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(bg);
            make.top.equalTo(img.mas_bottom).offset(20);
            make.width.equalTo(bg);
        }];
        
        
        self.signinButton = [UIButton new];
        [self.signinButton setTitle:@"签到" forState:UIControlStateNormal];
        [self.signinButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.signinButton.titleLabel setFont:Font6];
        self.signinButton.layer.borderWidth = 0.8;
        self.signinButton.layer.borderColor = ColorLine.CGColor;

        CGFloat height = 40;
        self.signinButton.layer.cornerRadius = height/2;
        [bg addSubview:self.signinButton];
        [self.signinButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(bg);
            make.height.mas_equalTo(height);
            make.top.equalTo(ws.locationLabel.mas_bottom).offset(20);
            make.width.mas_equalTo(height*4);
        }];
        
        UILabel* note = [UILabel new];
        [note setText:@"请确认定位是否准确"];
        [note setFont:Font2];
        [bg addSubview:note];
        [note mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(bg);
            make.top.equalTo(ws.signinButton.mas_bottom).offset(20);
            make.bottom.equalTo(bg).offset(-20);
        }];
        
        
    }
    
    return self;
}

-(void)showPopView{

    [self makeKeyAndVisible];//关键语句,显示window

}

-(void)dismissPopView{
    
    NSLog(@"dismissPopView");
    
    [self resignKeyWindow];
    
}

-(void)setSigninStatus:(BOOL)signin{

    if (signin) {
        self.signinButton.layer.borderColor = ColorBtnYellow.CGColor;
        [self.signinButton setTitle:@"已签到" forState:UIControlStateNormal];
        [self.signinButton setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        [self.signinButton setUserInteractionEnabled:NO];
    }
    else{
        self.signinButton.layer.borderColor = ColorLine.CGColor;
        [self.signinButton setTitle:@"签到" forState:UIControlStateNormal];
        [self.signinButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
    }
    
}




@end
