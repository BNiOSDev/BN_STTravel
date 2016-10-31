//
//  LBB_FoodsMainMenuCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FoodsMainMenuCell.h"
#import "LBBPoohVerticalButton.h"

@implementation LBB_FoodsMainMenuCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray* iconArray  = @[@"美食首页_台湾小吃", @"美食首页_厦门小吃",@"美食首页_福建小吃",@"美食首页_海鲜"];
        NSArray* titleArray = @[@"台湾小吃",@"厦门小吃",@"福建小吃",@"海鲜"];
        
        NSInteger count = [titleArray count];
        CGFloat margineLeft = 25;
        CGFloat width = (DeviceWidth - (count+1)*margineLeft)/count;
        
        UIView *sub = [UIView new];
        [self.contentView addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(16);
           // make.bottom.equalTo(ws.contentView).offset(-8);
         //   make.centerY.equalTo(ws.contentView);
        }];
        
        for (int i = 0 ; i<count; i++) {
            
            LBBPoohVerticalButton* btn = [[LBBPoohVerticalButton alloc]init];
            [btn setTag:i];
            [btn.titleLabel setText:[titleArray objectAtIndex:i]];
            [btn.titleLabel setTextColor:[UIColor blackColor]];
            [btn.titleLabel setFont:Font14];
            [btn.imageView setImage:IMAGE([iconArray objectAtIndex:i])];
            [sub addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker* make){
                make.top.equalTo(sub);
                make.left.equalTo(sub).offset(i*(width+margineLeft)+margineLeft);
                make.width.mas_equalTo(width);
                make.bottom.equalTo(sub);
            }];
            [btn bk_addEventHandler:^(LBBPoohVerticalButton* sender){
                
                NSLog(@"touch button %ld",sender.tag);
                
            } forControlEvents:UIControlEventTouchUpInside];
        }
        
         UIView* sep = [UIView new];
         [sep setBackgroundColor:ColorLine];
         [self.contentView addSubview:sep];
         [sep mas_makeConstraints:^(MASConstraintMaker* make){
             make.top.equalTo(sub.mas_bottom).offset(16);
             make.left.right.equalTo(ws.contentView);
             make.height.mas_equalTo(SeparateLineWidth/2);
             make.bottom.equalTo(ws.contentView);
         }];
    }
    return self;
}


@end
