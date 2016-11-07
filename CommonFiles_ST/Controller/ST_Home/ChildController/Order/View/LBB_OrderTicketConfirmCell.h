//
//  LBB_OrderTicketConfirmCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_OrderTicketConfirmCell : LBBPoohBaseTableViewCell


@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UILabel* timeLabel;

@property(nonatomic, retain)UIButton* leftButton;

@property(nonatomic, retain)UIButton* rightButton;

@property(nonatomic, assign)LBBPoohTicketStatus ticketStatus;

@property(nonatomic, retain)id model;

@end
