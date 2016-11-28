//
//  LBB_FollowViewController.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "MineBaseViewController.h"
typedef NS_ENUM(NSInteger, FollowViewType)
{
    eFanFollowType = 1, //我的-广场 粉丝列表
    eSquareFollowType = 2, //3.5.9 我的-广场 关注列表
};

@interface LBB_FollowViewController : MineBaseViewController

@property(nonatomic,assign) FollowViewType followType;

@end
