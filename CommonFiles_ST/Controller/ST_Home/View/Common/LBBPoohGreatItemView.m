//
//  LBBPoohGreatItemView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohGreatItemView.h"

@implementation LBBPoohGreatItemView

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
            
        self.iconView = [UIImageView new];
        [self.iconView setImage:IMAGE(@"poohtest")];
       // [self.iconView setContentMode:UIViewContentModeCenter];
        [self addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.top.bottom.equalTo(ws);
            make.width.equalTo(ws.iconView.mas_height);
        }];
        
        self.desLabel = [UILabel new];
        [self.desLabel setFont:Font2];
        [self.desLabel setTextColor:[UIConstants getSecondaryTitleColor]];
        [self addSubview:self.desLabel];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.iconView.mas_right).offset(5);
            make.centerY.equalTo(ws);
            make.right.equalTo(ws);
        }];
    }
    return self;
}

@end
