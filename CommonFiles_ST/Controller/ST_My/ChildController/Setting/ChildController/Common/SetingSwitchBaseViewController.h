//
//  SetingSwitchBaseViewController.h
//  LUBABA
//
//  Created by 晨曦 on 16/10/10.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "MineBaseViewController.h"

typedef NS_ENUM(NSInteger,SwitchType)
{
    eRemoteShakeWarn = 0,//推送消息震动提醒
    eRemoteVoiceWarn,//聊天提醒
    eHighqualityWarn,//精品内容推荐提醒
    eFollowWarn,//关注提醒
    eChatWarn,//聊天提醒
    eLikeWarn,//点赞提醒
    eCollectWarn,//收藏提醒
    eCommentWarn,//评论提醒
    eNightUnwarn,//夜间提醒
    eRecommendedPhoneFriends,//向我推荐通讯录好友
    eAttentionNeedAudited, //关注需要通过我审核
    eFriendsDynamicRedDot //好友动态红点提示
};


@interface SetingSwitchBaseViewController : MineBaseViewController<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,assign) int isFollowWarn;//关注提醒
@property(nonatomic,assign) int isChatWarn;//聊天提醒
@property(nonatomic,assign) int isLikeWarn;//点赞提醒
@property(nonatomic,assign) int isCollectWarn;//收藏提醒
@property(nonatomic,assign) int isCommentWarn;//评论提醒
@property(nonatomic,assign) int isNightUnwarn;//夜间提醒
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end
