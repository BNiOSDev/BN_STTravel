//
//  LBBHomeAnnouncementTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeAnnouncementTableViewCell.h"
#import "GYChangeTextView.h"

@interface LBBHomeAnnouncementTableViewCell()<GYChangeTextViewDelegate>{

    UILabel* label;
    
    GYChangeTextView *tView;

}

@end

@implementation LBBHomeAnnouncementTableViewCell

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
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:[UIConstants getSeperatorLineColor]];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(1.5);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:[UIConstants getSeperatorLineColor]];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.equalTo(sep);
        }];
        
        UIView* leftBg = [UIView new];
        [leftBg setBackgroundColor:[UIConstants getProminentFillColor]];
        [self.contentView addSubview:leftBg];
        [leftBg mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView);
            make.width.mas_equalTo(3);
            make.top.equalTo(ws.contentView).offset(8);
            make.bottom.equalTo(ws.contentView).offset(-8);
        }];
        
        UILabel* title = [UILabel new];
        [title setText:@"鹭爸公告"];
        [title setTextColor:[UIColor blackColor]];
        [title setFont:Font6];
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(leftBg.mas_right).offset(20);
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:[UIConstants getSeperatorLineColor]];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.equalTo(leftBg);
            make.width.mas_equalTo(1.2);
            make.left.equalTo(title.mas_right).offset(20);
        }];
        
        CGFloat x = 3 + 20 + 20 + title.frame.size.width + 25;

        tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(x+40, 0, UISCREEN_WIDTH-40-x, 50)];
        tView.delegate = self;
        [self.contentView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(sep2.mas_right).offset(5);
            make.right.equalTo(ws.contentView).offset(-2);
            make.top.bottom.equalTo(ws.contentView);
        }];
        
    }
    return self;
}


-(void)setScrollTextArray:(NSArray*)array{

    [tView animationWithTexts:[NSArray arrayWithObjects:@"这是第1条",@"这是第2条",@"这是第3条", nil]];

}


-(CGFloat)getCellHeight{
    
    CGFloat height = 50;
    NSLog(@"getCellHeight:%f",height);
    return height;
}

#pragma GYChangeTextView delegate

- (void)gyChangeTextView:(GYChangeTextView *)textView didTapedAtIndex:(NSInteger)index {
    NSLog(@"%@ select: %ld",[textView class],index);
}

@end
