//
//  LBB_InviteFriendsViewController.h
//  ST_Travel
//
//  Created by dhxiang on 16/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "MineBaseViewController.h"

typedef NS_ENUM(NSInteger,InviteFriendsType)
{
    eWeChatInvite = 0, //微信邀请
    eQQInvite,//QQ 邀请
    eWeiboInvite //微博邀请
};

@interface LBB_InviteFriendsViewController : MineBaseViewController

@end
