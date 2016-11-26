//
//  LBB_SetPushViewModel.h
//  ST_Travel
//
//  Created by dhxiang on 16/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_SetPushViewModel : BN_BaseDataModel

@property(nonatomic,assign) int isFollowWarn;//关注提醒:
@property(nonatomic,assign) int isChatWarn;//聊天提醒:
@property(nonatomic,assign) int isLikeWarn;//点赞提醒
@property(nonatomic,assign) int isCollectWarn;//收藏提醒:
@property(nonatomic,assign) int isCommentWarn;//评论提醒
@property(nonatomic,assign) int isNightUnwarn;//夜间提醒

/**
 *3.5.37 我的-查看设置（已测）
 */
- (void)getSettingData;

/**
 *3.5.38 我的-设置（已测）
 */
- (void)updateSettingData:(NSString*)settingName settingValue:(int)settingValue;

@end
