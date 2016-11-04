//
//  LBBPoohCycleScrollCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBBPoohCycleScrollCell : LBBPoohBaseTableViewCell

-(void)setCycleScrollViewUrls:(NSArray*)urlArray;


-(void)setCycleScrollViewHeight:(CGFloat)height;

@property(nonatomic,strong)ClickBlock click;

@property(nonatomic,assign)BOOL enableBlock;

@end
