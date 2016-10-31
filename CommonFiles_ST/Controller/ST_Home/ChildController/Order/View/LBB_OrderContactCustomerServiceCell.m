//
//  LBB_OrderContactCustomerServiceCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderContactCustomerServiceCell.h"

@implementation LBB_OrderContactCustomerServiceCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat margin = 8;
        
        self.telButton = [UIButton new];
        
        [self.telButton setTitle:@"联系客服" forState:UIControlStateNormal];
        [self.telButton setImage:IMAGE(@"景点详情_电话") forState:UIControlStateNormal];
        [self.telButton setTitleColor:ColorBlack forState:UIControlStateNormal];
        [self.telButton.titleLabel setFont:Font15];
        [self.telButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        [self.contentView addSubview:self.telButton];
        [self.telButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.width.height.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(35));
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
    }
    return self;
}

@end
