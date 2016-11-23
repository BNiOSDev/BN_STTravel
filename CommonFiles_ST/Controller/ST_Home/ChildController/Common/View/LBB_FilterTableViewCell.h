//
//  LBB_FilterTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_FilterTableViewCell : LBBPoohBaseTableViewCell

-(void)configContentView:(NSArray*)array;
@property(nonatomic, assign)CGFloat bottomMargin;
 
    
@property (nonatomic, retain) UIColor* borderColor;
@property (nonatomic, retain) UIColor* titleColor;
@property (nonatomic, retain) UIColor* buttonBgColor;

@property (nonatomic, retain) UIColor* selectBorderColor;
@property (nonatomic, retain) UIColor* selectTitleColor;
@property (nonatomic, retain) UIColor* selectButtonBgColor;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, retain) UIFont* buttonFont;
  
@property (nonatomic, strong) ClickBlock click;
@property (nonatomic, assign) NSInteger selectIndex;
  
+(CGFloat)getCellHeight:(NSArray*)array;
    
@end
