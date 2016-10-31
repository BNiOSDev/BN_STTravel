//
//  LBB_ScenicDetailOrderConfirmView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailOrderConfirmView.h"
#import "PoohCommon.h"

@implementation LBB_ScenicDetailOrderConfirmView

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
        
        
      /*  UIScrollView* mainScrollView = [UIScrollView new];
        [mainScrollView setBackgroundColor:[UIColor whiteColor]];
        [mainScrollView setContentSize:CGSizeMake(0, DeviceHeight)];
        [mainScrollView setBackgroundColor:[UIColor redColor]];
        [self addSubview:mainScrollView];
        [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws);
            make.bottom.equalTo(ws);
            make.width.centerX.equalTo(ws);
        }];*/

        UIView* bg = [UIView new];
        [bg setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.width.bottom.equalTo(ws);
        //    make.height.equalTo(@300);
        }];
        
        CGFloat margin = 8;
        
        self.imageView = [UIImageView new];
        [bg addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(bg).offset(2*margin);
            make.top.equalTo(bg).offset(2*margin);
            make.height.width.mas_equalTo(AutoSize(190/2));
        }];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];

        
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setText:@"￥120.00"];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.priceLabel setFont:[UIFont systemFontOfSize:20]];
        [bg addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView.mas_right).offset(2*margin);
            make.top.equalTo(ws.imageView).offset(2*margin);
        }];
        
        self.noteLable = [UILabel new];
        [self.noteLable setText:@"请选择门票规格及数量"];
        [self.noteLable setFont:Font13];
        [self.noteLable setTextColor:ColorLightGray];
        [bg addSubview:self.noteLable];
        [self.noteLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.priceLabel);
            make.centerY.equalTo(ws.imageView);
        }];
        
        
        self.closeButton = [UIButton new];
        [self.closeButton setTitleColor:ColorBlack forState:UIControlStateNormal];
        [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
        [self.closeButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [bg addSubview:self.closeButton];
        [self.closeButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.imageView);
            make.right.equalTo(bg).offset(-2*margin);
        }];
        
        UILabel* typeLabel = [UILabel new];
        [typeLabel setText:@"门票类型"];
        [typeLabel setFont:Font15];
        [typeLabel setTextColor:ColorGray];
        [bg addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView);
            make.top.equalTo(ws.imageView.mas_bottom).offset(3*margin);
        }];
        
        UILabel* numLable = [UILabel new];
        [numLable setText:@"选择数量"];
        [numLable setFont:Font15];
        [numLable setTextColor:ColorGray];
        [numLable setTextAlignment:NSTextAlignmentRight];
        [bg addSubview:numLable];
        [numLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.closeButton);
            make.centerY.equalTo(typeLabel);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [bg addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(typeLabel.mas_bottom).offset(2*margin);
            make.left.equalTo(typeLabel);
            make.right.equalTo(numLable);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        self.adultTypeLabel = [UILabel new];
        [self.adultTypeLabel setFont:Font15];
        [self.adultTypeLabel setTextColor:ColorLightGray];
        [self.adultTypeLabel setText:@"成人"];
        [bg addSubview:self.adultTypeLabel];
        
        self.childTypeLabel = [UILabel new];
        [self.childTypeLabel setFont:Font15];
        [self.childTypeLabel setTextColor:ColorLightGray];
        [self.childTypeLabel setText:@"儿童"];
        [bg addSubview:self.childTypeLabel];
        
        self.studenTypeLabel = [UILabel new];
        [self.studenTypeLabel setFont:Font15];
        [self.studenTypeLabel setTextColor:ColorLightGray];
        [self.studenTypeLabel setText:@"学生"];
        [bg addSubview:self.studenTypeLabel];
        
        self.soldierTypeLabel = [UILabel new];
        [self.soldierTypeLabel setFont:Font15];
        [self.soldierTypeLabel setTextColor:ColorLightGray];
        [self.soldierTypeLabel setText:@"残疾/军人"];
        [bg addSubview:self.soldierTypeLabel];
        
        self.adultTextField = [[LBB_PoohPlusMinTextField alloc]init];
        [bg addSubview:self.adultTextField];
        
        self.childTextField = [[LBB_PoohPlusMinTextField alloc]init];
        [bg addSubview:self.childTextField];
        
        self.studenTextField = [[LBB_PoohPlusMinTextField alloc]init];
        [bg addSubview:self.studenTextField];
        
        self.soldierTextField = [[LBB_PoohPlusMinTextField alloc]init];
        [bg addSubview:self.soldierTextField];
        
        [self.adultTextField.textField setUserInteractionEnabled:NO];
        [self.childTextField.textField setUserInteractionEnabled:NO];
        [self.studenTextField.textField setUserInteractionEnabled:NO];
        [self.soldierTextField.textField setUserInteractionEnabled:NO];

        
        [self.adultTypeLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(typeLabel);
            make.top.equalTo(sep.mas_bottom).offset(2*margin);
        }];
        [self.adultTextField mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.adultTypeLabel);
            make.right.equalTo(numLable);
            make.height.mas_equalTo(AutoSize(36/2));
            make.width.mas_equalTo(AutoSize(150/2));
        }];
        
        
        [self.childTypeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.adultTypeLabel);
            make.top.equalTo(ws.adultTypeLabel.mas_bottom).offset(3*margin);
        }];
        [self.childTextField mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.childTypeLabel);
            make.right.width.height.equalTo(ws.adultTextField);
        }];
        
        
        [self.studenTypeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.adultTypeLabel);
            make.top.equalTo(ws.childTypeLabel.mas_bottom).offset(3*margin);
        }];
        [self.studenTextField mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.studenTypeLabel);
            make.right.width.height.equalTo(ws.adultTextField);
        }];
        
        [self.soldierTypeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.adultTypeLabel);
            make.top.equalTo(ws.studenTypeLabel.mas_bottom).offset(3*margin);
        }];
        [self.soldierTextField mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.soldierTypeLabel);
            make.right.width.height.equalTo(ws.adultTextField);
        }];
        
        self.confirmButton = [UIButton new];
        [self.confirmButton setBackgroundColor:ColorBtnYellow];
        [self.confirmButton setTitle:@"确    认" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.confirmButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [bg addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.soldierTypeLabel.mas_bottom).offset(3*margin);
            make.centerX.width.equalTo(bg);
            make.bottom.equalTo(bg);
            make.height.mas_equalTo(AutoSize(90/2));
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
