//
//  LBB_OrderTicketPriceCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_OrderTicketPriceCell : LBBPoohBaseTableViewCell

@property(nonatomic, retain)UILabel* titleLabel1;
@property(nonatomic, retain)UILabel* priceLabel1;

@property(nonatomic, retain)UILabel* titleLabel2;
@property(nonatomic, retain)UILabel* priceLabel2;

@property(nonatomic ,retain)UIView* sepLineView;

-(void)setLineInset:(CGFloat)size andHeight:(CGFloat)height;
@property(nonatomic, retain)id model;

@end
