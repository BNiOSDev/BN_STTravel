//
//  TicketViewCell.h
//  LUBABA
//
//  Created by Diana on 16/10/12.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat ticketDetailCellHeight(NSString *nameStr ,NSString *typeStr);

typedef NS_ENUM(NSInteger,TicketStateType)
{
    eAllTicket = 0, //全部
    eWaitPay,  //待付款
    eWaitGetTicket,//待取票
    eWaitComment,//待评价
    eRefund  //退款
};

typedef NS_ENUM(NSInteger,TicketClickType)
{
    eCancelTicket = 0, //取消订单
    eTicketPay,  //立即支付
    eGetTicket,//立即取票
    eComment,//立即评价
    eShowDetail  //查看详情
};

@protocol TicketViewCellDelegate <NSObject>

@optional
- (void)cellBtnClickDelegate:(NSDictionary*)cellInfo
                   StateType:(TicketStateType)type
             TicketClickType:(TicketClickType)clickType;

- (void)ticketDetailDelegate:(NSDictionary*)cellInfo
                   StateType:(TicketStateType)type
             TicketClickType:(TicketClickType)clickType;

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
