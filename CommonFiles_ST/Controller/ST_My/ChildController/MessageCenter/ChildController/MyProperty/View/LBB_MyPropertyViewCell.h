//
//  LBB_MyPropertyViewCell.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_MyPropertyViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topTimeLabel;

@property (nonatomic,weak) IBOutlet UILabel *stateLabel;
@property (nonatomic,weak) IBOutlet UILabel *stateDateLabel;

@property (nonatomic,weak) IBOutlet UILabel *monyeNumLabel;
@property (nonatomic,weak) IBOutlet UILabel *extractBankLabel;
@property (nonatomic,weak) IBOutlet UILabel *extractBeginDateLabel;
@property (nonatomic,weak) IBOutlet UILabel *extractEndDateLabel;


@property (weak, nonatomic) IBOutlet UILabel *moneyTipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
