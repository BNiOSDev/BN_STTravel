//
//  LBB_DiscoveryCustomizedSelectView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryCustomizedSelectView.h"
#import "PoohCommon.h"

@implementation LBB_DiscoveryCustomizedSelectView
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
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font14];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws);
            make.left.equalTo(ws);
            make.width.mas_equalTo(100);
        }];
        
        self.bgCtrlView = [UITextField new];
        self.bgCtrlView.layer.borderColor = ColorLine.CGColor;
        self.bgCtrlView.layer.borderWidth = 1;
        self.bgCtrlView.layer.masksToBounds = YES;
        [self.bgCtrlView setPlaceholder:@"请选择"];
        [self.bgCtrlView setValue:Font14 forKeyPath:@"_placeholderLabel.font"];

        [self.bgCtrlView setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.bgCtrlView];
        [self.bgCtrlView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.titleLabel.mas_right);
            make.centerY.top.bottom.equalTo(ws);
            make.right.equalTo(ws).offset(-2*margin);
        }];
        
        self.contentLable = [UILabel new];
        self.contentLable.hidden = YES;
        [self.contentLable setText:@"请选择"];
        [self.contentLable setFont:Font10];
        [self.contentLable setTextColor:ColorLightGray];
        [self.bgCtrlView addSubview:self.contentLable];
        [self.contentLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.bgCtrlView);
            make.left.equalTo(ws.bgCtrlView).offset(margin);
        }];
        
        self.rightButton = [UIButton new];
        [self.rightButton setImage:IMAGE(@"ST_Home_Arrow") forState:UIControlStateNormal];
        [self addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.bgCtrlView);
            make.right.equalTo(ws.bgCtrlView).offset(-margin);
          //  make.width.mas_equalTo(10);
          //  make.height.equalTo(@15);
        }];
        
        self.addMoreView = [[UIButton alloc]init];
        [self.addMoreView setImage:IMAGE(@"ST_Discovery_Add") forState:UIControlStateNormal];
        [self.addMoreView setTitle:@"添加更多景点" forState:UIControlStateNormal];
        [self.addMoreView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.addMoreView.titleLabel setFont:Font13];
        [self.addMoreView setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        [self.bgCtrlView addSubview:self.addMoreView];
        [self.addMoreView mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.equalTo(ws.bgCtrlView);
           // make.height.equalTo(@20);
        }];
        self.addMoreView.hidden = YES;
        self.addMoreView.userInteractionEnabled = NO;
    }
    
    return self;
}


-(void)setContentLableText:(NSString *)content{
    
    [self.contentLable setTextColor:[UIColor blackColor]];
    [self.contentLable setText:content];
}

-(void)showAddMoreView:(BOOL)show{
    
    if (show) {
        self.addMoreView.hidden = NO;
        self.rightButton.hidden = YES;
        self.contentLable.hidden = YES;
    }
}

-(void)showDeleteImageView:(BOOL)show{
    if (show) {
        self.addMoreView.hidden = YES;
        self.rightButton.hidden = NO;
        self.contentLable.hidden = YES;
        [self.rightButton setImage:IMAGE(@"ST_Discovery_Delete") forState:UIControlStateNormal];
        self.bgCtrlView.userInteractionEnabled = NO;
    }
}


@end
