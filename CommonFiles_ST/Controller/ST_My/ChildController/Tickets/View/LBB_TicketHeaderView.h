//
//  LBB_TicketHeaderView.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_TicketHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *numTipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView  *lineView;

@property(nonatomic,strong) NSDictionary* cellInfo;


@end
