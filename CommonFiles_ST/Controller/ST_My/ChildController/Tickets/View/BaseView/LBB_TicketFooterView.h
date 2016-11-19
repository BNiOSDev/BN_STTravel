//
//  LBB_TicketFooterView.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mine_Common.h"
#import "LBB_TicketModel.h"

@protocol TicketFooterViewDelegate <NSObject>

@optional
- (void)cellBtnClickDelegate:(NSDictionary*)cellInfo
                   StateType:(MineBaseViewType)type
             TicketClickType:(TicketClickType)clickType;

@end

@interface LBB_TicketFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *goodNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *totoalTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bgLine1;
@property (weak, nonatomic) IBOutlet UIView *bgLine2;

@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) id<TicketFooterViewDelegate> mDelegate;

@property(nonatomic,strong) LBB_TicketModelData* cellInfo;

@end
