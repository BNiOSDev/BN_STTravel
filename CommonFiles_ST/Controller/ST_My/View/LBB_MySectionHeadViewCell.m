//
//  LBB_MySectionHeadViewCell.m
//  ST_Travel
//
//  Created by Diana on 16/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MySectionHeadViewCell.h"
#import "Base_Common.h"

@implementation LBB_MySectionHeadViewCell

- (void)dealloc
{
    self.userInfo = nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineView.backgroundColor = ColorLine;
    self.titleLabel.font = Font14;
    self.titleLabel.textColor = ColorGray;
    [self.rightBtn.titleLabel setFont:Font14];
    [self.rightBtn setTitleColor:ColorGray forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.rightBtn.hidden = YES;
    self.arrowImgView.hidden = YES;
}

- (IBAction)rightBtnClickAction:(id)sender {
    NSLog(@"\n 点击查看按钮");
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDetailActionDelegate:)]) {
        [self.delegate didClickDetailActionDelegate:self.viewType];
    }
}

@end
