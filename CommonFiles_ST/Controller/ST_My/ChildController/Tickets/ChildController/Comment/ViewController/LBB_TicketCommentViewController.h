//
//  LBB_TicketCommentViewController.h
//  Textdd
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "MineBaseViewController.h"

@interface LBB_TicketCommentViewController : MineBaseViewController

@property(nonatomic,strong) NSDictionary *ticketInfo;

- (void)resetDataSourceWithInfo:(NSDictionary*)info IsNeedReload:(BOOL)needReload;

@end
