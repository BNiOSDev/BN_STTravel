//
//  LBB_HomeSearchDefaultCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeSearchKeyWordCell.h"

@implementation LBB_HomeSearchKeyWordCell

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
        [self.contentView setBackgroundColor:ColorLine];
        self.labelButton1 = [UIButton new];
        [self.labelButton1 setBackgroundColor:ColorWhite];
        [self.labelButton1 setTitleColor:ColorGray forState:UIControlStateNormal];
        self.labelButton1.layer.borderColor = [UIColor colorWithRGB:0xdfdfdf].CGColor;
        self.labelButton1.layer.borderWidth = 2/2;
        self.labelButton1.layer.masksToBounds = YES;
        [self.labelButton1.titleLabel setFont:Font13];
        [self.contentView addSubview:self.labelButton1];
        
        
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setBackgroundColor:ColorWhite];
        [self.labelButton2 setTitleColor:ColorGray forState:UIControlStateNormal];
        self.labelButton2.layer.borderColor = [UIColor colorWithRGB:0xdfdfdf].CGColor;
        self.labelButton2.layer.borderWidth = 2/2;
        self.labelButton2.layer.masksToBounds = YES;
        [self.labelButton2.titleLabel setFont:Font13];
        [self.contentView addSubview:self.labelButton2];
        
        self.labelButton3 = [UIButton new];
        [self.labelButton3 setBackgroundColor:ColorWhite];
        [self.labelButton3 setTitleColor:ColorGray forState:UIControlStateNormal];
        self.labelButton3.layer.borderColor = [UIColor colorWithRGB:0xdfdfdf].CGColor;
        self.labelButton3.layer.borderWidth = 2/2;
        self.labelButton3.layer.masksToBounds = YES;
        [self.labelButton3.titleLabel setFont:Font13];
        [self.contentView addSubview:self.labelButton3];
        
        [self.labelButton1 setTitle:@"拍照圣地" forState:UIControlStateNormal];
        [self.labelButton2 setTitle:@"舒适" forState:UIControlStateNormal];
        [self.labelButton3 setTitle:@"小清新" forState:UIControlStateNormal];
        
        [self.labelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.contentView).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-0);
            make.height.mas_equalTo(AutoSize(28));
        }];
        
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.width.height.equalTo(ws.labelButton1);
            make.left.equalTo(ws.labelButton1.mas_right).offset(margin);
        }];
        
        [self.labelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.width.height.equalTo(ws.labelButton1);
            make.left.equalTo(ws.labelButton2.mas_right).offset(margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        [self.labelButton1 bk_whenTapped:^{
            
            ws.click(@0);
        }];
        
        [self.labelButton2 bk_whenTapped:^{
            
            ws.click(@1);
        }];
        
        [self.labelButton3 bk_whenTapped:^{
            
            ws.click(@2);
        }];
        
    }
    return self;
}


@end
