//
//  LBB_TicketCommentViewController.h
//  Textdd
//
//  Created by dhxiang on 16/11/1.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "MineBaseViewController.h"

@interface LBB_TicketCommentViewController : MineBaseViewController

@property(nonatomic,strong) NSDictionary *ticketInfo;

- (void)resetDataSourceWithInfo:(NSDictionary*)info IsNeedReload:(BOOL)needReload;

@end
