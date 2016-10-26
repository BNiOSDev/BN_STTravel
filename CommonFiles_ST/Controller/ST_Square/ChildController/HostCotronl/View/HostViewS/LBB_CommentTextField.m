//
//  LBB_CommentTextField.m
//  ForXiaMen
//
//  Created by dawei che on 2016/10/25.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import "LBB_CommentTextField.h"

@implementation LBB_CommentTextField
{
    UITextField     *textField;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)layoutSubviews
{
    textField = [UITextField new];
    [self addSubview:textField];
    textField.textColor = [UIColor darkTextColor];
    textField.font = [UIFont systemFontOfSize:14.0];
    textField.backgroundColor = [UIColor orangeColor];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5.0);
        make.left.equalTo(self.mas_left).offset(5.0);
        make.right.equalTo(self.mas_right).offset(-40);
        make.bottom.equalTo(self.mas_bottom).offset(-5.0);
    }];
    
    UIView  *line = [UIView new];
    line.backgroundColor = [UIColor redColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height).with.multipliedBy(0.5);
        make.left.equalTo(textField.mas_right);
        make.width.equalTo(@1.0);
    }];
    
    UIButton *pushBtn = [UIButton new];
    [pushBtn setTitle:@"评论" forState:0];
    [pushBtn setTitleColor:[UIColor grayColor] forState:0];
    pushBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:pushBtn];
    
    [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(-40);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
