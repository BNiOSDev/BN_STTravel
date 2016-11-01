//
//  LBB_SquareNotificationViewCell.h
//  ST_Travel
//  消息中心-购买通知-商场通知cell
//  Created by Diana on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_SquareNotificationViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *iconImgView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property(nonatomic,strong) id cellInfo;

@end
