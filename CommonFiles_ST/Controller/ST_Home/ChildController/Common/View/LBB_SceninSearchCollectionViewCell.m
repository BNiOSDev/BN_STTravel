//
//  LBB_SceninSearchCollectionViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SceninSearchCollectionViewCell.h"
#import "PoohCommon.h"
@implementation LBB_SceninSearchCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    WS(ws);
    if (self) {
        
        self.textLabel = [UILabel new];
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.textLabel setFont:Font4];
        self.textLabel.layer.borderColor = ColorLine.CGColor;
        self.textLabel.layer.borderWidth = SeparateLineWidth;
        [self.textLabel setTextColor:ColorGray];
        [self.contentView addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.width.height.equalTo(ws.contentView);
        }];
        
    }
    return self;
}


@end
