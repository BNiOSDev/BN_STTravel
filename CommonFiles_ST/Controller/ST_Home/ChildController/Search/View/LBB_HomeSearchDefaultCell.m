//
//  LBB_HomeSearchDefaultCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeSearchDefaultCell.h"

@implementation LBB_HomeSearchDefaultCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        CGFloat margin = 8;
        
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:Font15];
        [self.contentLabel setTextColor:ColorGray];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
          //  make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.bottom.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.width.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
    }
    return self;
}

@end
