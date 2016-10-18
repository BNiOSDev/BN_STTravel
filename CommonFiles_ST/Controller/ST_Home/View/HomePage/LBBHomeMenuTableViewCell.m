//
//  LBBHomeMenuTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeMenuTableViewCell.h"
#import "LBBPoohVerticalButton.h"

@implementation LBBHomeMenuTableViewCell

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
        
        NSArray* titleArray = @[@"攻略", @"景点",@"导游",@"美食",@"民宿",];
        NSArray* iconArray = @[@"poohtest",@"poohtest",@"poohtest",@"poohtest",@"poohtest"];
        
        NSInteger count = [titleArray count];
        CGFloat margineLeft = 16;
        CGFloat margineTop = 8;
        CGFloat width = (UISCREEN_WIDTH - (count+1)*margineLeft)/count;
        NSLog(@"width:%f",width);
        NSLog(@"UISCREEN_WIDTH:%f",UISCREEN_WIDTH);

        for (int i = 0 ; i<count; i++) {
            
            LBBPoohVerticalButton* btn = [[LBBPoohVerticalButton alloc]init];
            [btn setTag:i];
            [btn.titleLabel setText:[titleArray objectAtIndex:i]];
            [btn.titleLabel setTextColor:[UIColor blackColor]];
            [btn.imageView setImage:IMAGE([iconArray objectAtIndex:i])];
            [self.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker* make){

                make.top.equalTo(ws.contentView).offset(margineTop);
                make.left.equalTo(ws.contentView).offset(i*(width+margineLeft)+margineLeft);
                make.width.mas_equalTo(width);
                make.bottom.equalTo(ws.contentView).offset(-margineTop);

            }];
            [self.contentView layoutSubviews];//it must to be done to layouts subviews
            [btn bk_addEventHandler:^(LBBPoohVerticalButton* sender){
                
                NSLog(@"%@ touch button %ld",[self class],sender.tag);
            
            } forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    return self;
}



-(CGFloat)getCellHeight{
    
    CGFloat height = 80;
    NSLog(@"%@ height:%f",[self class],height);
    return height;
}


@end
