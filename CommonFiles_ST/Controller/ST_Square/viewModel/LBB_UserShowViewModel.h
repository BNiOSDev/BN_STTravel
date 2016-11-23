//
//  LBB_UserShowViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/11/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <BN_BaseDataModel.h>

@interface LBB_UserShowViewModel : BN_BaseDataModel

@property (nonatomic, strong)NSString *chatId ;// 聊天ID
@property (nonatomic, strong)NSString *shareUrl ;// 分享URL
@property (nonatomic, strong)NSString *shareTitle ;// 分享标题
@property (nonatomic, strong)NSString *shareContent ;// 分享内容
@property (nonatomic, assign)int isFollow ;// 是否关注 0否 1是
@property (nonatomic, strong)NSString *coverImg ;// 封面图片
@property (nonatomic, assign)int gender ;// 0女  1男  2未知（保密)
@property (nonatomic, assign)long userId ;// 用户ID
@property (nonatomic, strong)NSString *area ;// 地址区域名称
@property (nonatomic, assign)int photoNum ;// 照片数量
@property (nonatomic, strong)NSString *userName ;// 用户名称
@property (nonatomic, strong)NSString *userPicUrl ;// 用户头像
@property (nonatomic, assign)int auditState ;// 0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property (nonatomic, assign)int level ;// 级别
@property (nonatomic, assign)int isLiked ;// 是否点赞
@property (nonatomic, assign)int likeNum ;// 点赞数
@property (nonatomic, assign)int actionNum ;// 动态数量
@property (nonatomic, assign)int followNum ;// 关注数
@property (nonatomic, assign)int fansNum ;// 粉丝数
@property (nonatomic, assign)int isTour ;// 是否导游 0否 1是
@property (nonatomic, strong)NSString *tourIdCard ;// 导游证号
@property (nonatomic, strong)NSString *tourStartTime ;// 从业时间
@property (nonatomic, strong)NSString *phoneNum ;// 联系电话
@property (nonatomic, strong)NSString *provName ;// 省份
@property (nonatomic, strong)NSString *cityName ;// 城市
@property (nonatomic, strong)NSString *districtName ;// 地区名
@property (nonatomic, strong)NSString *tourAWords ;// 导游简介
@property (nonatomic, strong)NSString *tourDetails ;// 导游介绍


@end
