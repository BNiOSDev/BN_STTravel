//
//  LBBPoohVerticalButton.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohVerticalButton.h"
#import "PoohCommon.h"

@implementation LBBPoohVerticalButton

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
        
        self.imageView = [UIImageView new];
        self.imageView.contentMode = UIViewContentModeCenter; //原比例，多余部分被裁减

        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws);
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font10];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.imageView.mas_bottom).offset(3);
            make.bottom.equalTo(ws);
           // make.left.right.equalTo(ws);
            make.centerX.equalTo(ws);
        }];
    }
    return self;
}

@end
