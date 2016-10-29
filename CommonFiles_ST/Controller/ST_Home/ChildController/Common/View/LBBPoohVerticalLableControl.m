//
//  LBBPoohVerticalLableControl.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohVerticalLableControl.h"
#import "PoohCommon.h"

@implementation LBBPoohVerticalLableControl

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
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font13];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws).offset(3);
            make.left.right.equalTo(ws);
        }];


        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font13];
        [self.subTitleLabel setTextColor:[UIColor blackColor]];
        [self.subTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.titleLabel.mas_bottom);
            make.bottom.equalTo(ws).offset(-3);
            make.height.equalTo(ws.titleLabel);
            make.left.right.equalTo(ws);
        }];
        
        
        self.layer.borderColor = ColorLine.CGColor;
        self.layer.borderWidth = SeparateLineWidth;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
    }
    return self;
}


@end
