//
//  TicketViewCell.h
//  LUBABA
//
//  Created by Diana on 16/10/12.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,StateType)
{
    eHavePayState = 0,// 已支付
    eWaitPayState, //待支付
    eWaitReceiveState,//待收货
    eWaitCommentState, //待评价
    eSureGetState   //确定收货
};


@protocol TicketViewCellDelegate <NSObject>

@optional
- (void)cellBtnClickDelegate:(NSDictionary*)cellInfo StateType:(StateType)type;


@end


@interface TicketViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *goodNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *topLine;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;

@property(nonatomic,strong) NSDictionary* cellInfo;

@property (weak, nonatomic) id<TicketViewCellDelegate> mDelegate;

@end
