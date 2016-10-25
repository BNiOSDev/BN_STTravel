//
//  LBB_ScenicSearchCollectionReusableView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicSearchCollectionReusableView.h"
#import "PoohCommon.h"
@implementation LBB_ScenicSearchCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame{
    WS(ws);
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:ColorBackground];
        
        UIView* v = [UIView new];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.center.equalTo(ws);
            make.height.equalTo(ws);
        }];
        
        self.iconImageView = [UIImageView new];
        [v addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.left.equalTo(v);
            make.width.height.mas_equalTo(20);
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setTextColor:ColorGray];
        [self.titleLabel setFont:Font6];
        [v addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.right.equalTo(v);
            make.left.equalTo(ws.iconImageView.mas_right).offset(8);
        }];
        
    }
    return self;
}

@end
