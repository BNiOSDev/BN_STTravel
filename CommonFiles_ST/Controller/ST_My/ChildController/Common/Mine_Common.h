//
//  Mine_Common.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#ifndef Mine_Common_h
#define Mine_Common_h

//屏幕适配
#define FB_FIX_SIZE_WIDTH(w) (((w) / 320.0) * DeviceWidth)
//获取当前app版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
//获取适配后的数据大小
#define AutoSize(num)  num * (DeviceWidth /320.0)
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

typedef NS_ENUM(NSInteger,MineBaseViewType) {
    eTypeNone = 0, //
    eWallet,//我的钱包
    ePersonalCenter, //个人中心
    eEditUserName, //用户名
    eEditUserSignature,//用户签名
    eChangePhoneNum,//修改手机号
    eCheckPhoneNum,//验证手机号
    eAddress, //收货地址
    eAddAddress, //新建收货地址
    eLogin ,//登录
    eResgister,//注册
    eFindPassword,//找回密码
    eResetPassword,//设置密码
    
    eBalance, //我的余额
    eBalanceExtract, //余额提现
    eExtractVerification,//提现验证
    eBalanceDetail, //余额明细
    eCard, //我的银行卡
    eAddCard,//添加银行卡
    eCardDetail,//银行卡详情
    eFavorite ,//我的收藏
    eFightGroups ,//我的拼团
    
    eTickets,//我的门票
    eTicket_WaitPay,  //我的门票_待付款
    eTicket_WaitGetTicket,//我的门票_待取票
    eTicket_WaitComment,//我的门票_待评价
    eTicket_Refund,  //我的门票_退款
    eTicket_Coment,//我的门票-待评价门票详情-立即评价
    eOrder,//我的订单
    eOrder_WaitPay,  //我的订单_待付款
    eOrder_WaitGetTicket,//我的订单_待取票
    eOrder_WaitComment,//我的订单_待评价
    eOrder_AfterAales,  //我的订单_售后
    /* 我的广场 */
    ePhoto, //照片
    eVideo,//视频
    eTravels ,//我的游记
    eLove,//关注
    /* 我的收藏 */
    eSquare,//广场
    eScenicSpot,//景点
    eFood,//美食
    eHalls,//民宿
    eGoods,//商品
    eFlashSale,//限时抢购
    eHandSpecial,//伴手礼专题
    eTravelGuide,//攻略
    /* 我的积分 */
    ePoints,//我的积分
    eDownload ,//我的下载
    eRoute ,//定制线路
    eSetting, //我的设置
    ePointConvert ,//积分兑换
    ePointDetail, //积分明细
    
    
    eSettingPush,//推送消息
    eSettingPrivace, //隐私
    
    /* 消息中心 */
    eMessageCenter,//消息中心
    ePromotions,// 优惠促销（消息中心）
    eCustomer,//我的客服（消息中心）
    ePurchageNotifion,//购买通知（消息中心）
    eNotice,//鹭爸公告
    eNoticeDetail,//公告详情
    eMyProperty,//我的资产（消息中心）
    eSquareTravel, //广场游记（消息中心）
};

typedef NS_ENUM(NSInteger,TicketClickType)
{
    eCancelTicket = 0, //取消订单
    eTicketPay,  //立即支付
    eGetTicket,//立即取票
    eComment,//立即评价
    eShowDetail  //查看详情
};

typedef NS_ENUM(NSInteger,MessageCenterSquareTravelType)
{
    eMessageFollow = 0,//关注
    eMessageLike,//点赞
    eMessageComment,//评论
    eMessageCollection //收藏
};

#endif /* Mine_Common_h */
