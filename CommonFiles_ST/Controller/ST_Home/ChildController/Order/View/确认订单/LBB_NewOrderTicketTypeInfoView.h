//
//  LBB_NewOrderTicketTypeInfoView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_PoohPlusMinTextField.h"

@interface LBB_NewOrderTicketTypeInfoBaseView : UIView

@property(nonatomic, retain)UILabel* typeLabel;
@property(nonatomic, retain)LBB_PoohPlusMinTextField* textField;
@property(nonatomic, retain)UILabel* priceLabel;


@end


@interface LBB_NewOrderTicketTypeInfoView : UIView

@property(nonatomic, retain)UIView* ticketContentView;
-(void)setTicketInfo:(NSArray*)arrayInfo;


@end
