//
//  LBBPoohBaseTableSectionHeaderView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableSectionHeaderView.h"
#import "PoohCommon.h"

@implementation LBBPoohBaseTableSectionHeaderView

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
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIView* sub = [UIView new];
        [self addSubview: sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.center.equalTo(ws);
        }];
        
        self.iconView = [UIImageView new];
        [self.iconView setImage:IMAGE(@"poohtest")];
        [sub addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(sub);
            make.centerY.equalTo(sub);
            make.width.height.equalTo(@25);
            
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setText:@"test title"];
        [self.titleLabel setFont:Font4];
        [sub addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.iconView.mas_right).offset(2);
            make.centerY.equalTo(ws.iconView);
            make.right.equalTo(sub);
        }];
        
        
        self.markButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.markButton setImage:IMAGE(@"poohArrow") forState:UIControlStateNormal];
        [self addSubview:self.markButton];
        [self.markButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws);
            make.right.equalTo(ws).offset(-8);
            make.width.height.equalTo(ws.iconView);
        }];
    
    }
    return self;
}

@end
