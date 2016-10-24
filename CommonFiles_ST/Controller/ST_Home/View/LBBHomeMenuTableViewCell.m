//
//  LBBHomeMenuTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeMenuTableViewCell.h"
#import "LBBPoohVerticalButton.h"
#import "LBB_DiscoveryMainViewController.h"

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
        NSArray* iconArray = @[@"ST_Home_Strategy",@"ST_Home_Tourism",@"ST_Home_TourGuide",@"ST_Home_Foods",@"ST_Home_HomeStay"];
        
        NSInteger count = [titleArray count];
        CGFloat margineLeft = 20;
        CGFloat width = (DeviceWidth - (count+1)*margineLeft)/count;

        for (int i = 0 ; i<count; i++) {
            
            LBBPoohVerticalButton* btn = [[LBBPoohVerticalButton alloc]init];
            [btn setTag:i];
            [btn.titleLabel setText:[titleArray objectAtIndex:i]];
            [btn.titleLabel setTextColor:[UIColor blackColor]];
            [btn.titleLabel setFont:Font5];
            [btn.imageView setImage:IMAGE([iconArray objectAtIndex:i])];
            [self.contentView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker* make){

                make.left.equalTo(ws.contentView).offset(i*(width+margineLeft)+margineLeft);
                make.width.height.mas_equalTo(width);
                make.centerY.equalTo(ws.contentView);
            }];
            [self.contentView layoutSubviews];//it must to be done to layouts subviews
            [btn bk_addEventHandler:^(LBBPoohVerticalButton* sender){
                
                NSLog(@"touch button %ld",sender.tag);
                
                UIViewController* dest;
                
                switch (sender.tag) {
                    case 0://攻略
                        dest = [[LBB_DiscoveryMainViewController alloc] init];
                        break;
                        
                    default:
                        break;
                }
                [[ws getViewController].navigationController pushViewController:dest animated:YES];
                
            
            } forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    return self;
}



+(CGFloat)getCellHeight{
    
    CGFloat height = AutoSize(116/2);
    return height;
}


@end
