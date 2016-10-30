//
//  LBB_PromotionsViewCell.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_PromotionsViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *iconImgView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property(nonatomic,strong) id cellInfo;

@end