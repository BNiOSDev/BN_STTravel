//
//  LBB_OrderTicketCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_OrderTicketCell : LBBPoohBaseTableViewCell

@property (retain, nonatomic) UIImageView *imgView;
@property (retain, nonatomic) UILabel *nameLabel;
@property (retain, nonatomic) UILabel *typeLabel;
@property (retain, nonatomic) UILabel *priceLabel;
@property (retain, nonatomic) UILabel *numLabel;
@property (retain, nonatomic) UIView *lineView;

@property (retain, nonatomic) id model;

@end
