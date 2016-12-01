//
//  LBB_SquareTravelModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine_Common.h"


@interface LBB_MessageSquareTravelModel : BN_BaseDataModel
@property(nonatomic,assign) long userId;//关联用户ID
@property(nonatomic,copy) NSString* userPicUrl;//关联用户头像
@property(nonatomic,copy) NSString* userName;//关联用户名
@property(nonatomic,assign) long  objId;//对象ID
@property(nonatomic,copy) NSString* objName;//对象下划线的名字 (关注不需要)
@property(nonatomic,assign) int  objType;//对象类型
                                         //1美食 2 民宿 3 景点 4 伴手礼 5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略 11 美食专题 12民宿专题 13景点专题 14伴手礼专题 15 用户/导游 16公告
@property(nonatomic,copy) NSString* objTypeName;//类型名称
@property(nonatomic,copy) NSString* createTime;//创建时间

@end


@interface LBB_MessageSquareTravelViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_MessageSquareTravelModel*> *dataArray;

//msgType = 4关注消息 5点赞提醒 6评论提醒 7收藏提醒
- (void)getDataArrayWithType:(int)msgType IsClear:(BOOL)isClear;

@end
