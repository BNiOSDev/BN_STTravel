//
//  LBB_PromotionsViewCell.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_MyContentImgView.h"

@interface LBB_PromotionsViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet LBB_MyContentImgView *iconImgView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property(nonatomic,strong) id cellInfo;

@end
