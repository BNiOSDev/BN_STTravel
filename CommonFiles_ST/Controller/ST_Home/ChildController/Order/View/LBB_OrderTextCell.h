//
//  LBB_OrderTextCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_OrderTextCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UILabel* textLabel1;
@property(nonatomic, retain)UILabel* textLabel2;
@property(nonatomic, retain)UILabel* textLabel3;

@property(nonatomic ,retain)UIView* sepLineView;

-(void)setLineInset:(CGFloat)size andHeight:(CGFloat)height;

@property(nonatomic, retain)id model;

@property(nonatomic, assign)LBBPoohTicketStatus ticketStatus;
@property(nonatomic, retain)NSIndexPath* indexPath;

@end
