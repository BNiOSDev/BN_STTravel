//
//  LBB_DiscoveryCustomizedPopView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryCustomizedPopView.h"
#import "PoohCommon.h"

@implementation LBB_DiscoveryCustomizedPopView

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
            make.width.mas_equalTo(AutoSize(425/2));
            //make.height.equalTo(@300);
        }];
        
        
        UILabel* note = [UILabel new];
        note.numberOfLines = 0;
        [note setText:@"您的线路定制成功\n请点击确定查看"];
        [note setFont:Font16];
        [note setTextAlignment:NSTextAlignmentCenter];
        [bg addSubview:note];
        [note mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(bg);
            make.top.equalTo(bg).offset(AutoSize(25));
            make.left.equalTo(bg).offset(16);
            make.right.equalTo(bg).offset(-16);

            
        }];
        self.noteLabel = note;
        
        self.confirmButton = [UIButton new];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        [self.confirmButton.titleLabel setFont:Font15];
        self.confirmButton.layer.borderWidth = 0.8;
        self.confirmButton.layer.borderColor = ColorBtnYellow.CGColor;
        
        CGFloat height = AutoSize(70/2);
        self.confirmButton.layer.cornerRadius = height/2;
        [bg addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(bg);
            make.height.mas_equalTo(AutoSize(70/2));
            make.width.mas_equalTo(AutoSize(286/2));
            make.top.equalTo(ws.noteLabel.mas_bottom).offset(AutoSize(25));
            make.bottom.equalTo(bg).offset(-AutoSize(15));
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



@end
