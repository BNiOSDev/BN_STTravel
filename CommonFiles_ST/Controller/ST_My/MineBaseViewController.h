//
//  MineBaseViewController.h
//  LUBABA
//
//  Created by Dianar on 16/10/9.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "CommonMacro.h"

typedef NS_ENUM(NSInteger,MineBaseViewType) {
    eWallet = 0,//我的钱包
    ePersonalCenter, //个人中心
    eEditUserName, //用户名
    eEditUserSignature,//用户签名
    eBalance, //我的余额
    eBalanceExtract, //余额提现
    eBalanceDetail, //余额明细
    eCard, //我的银行卡
    eAddCard,//添加银行卡
    eCardDetail,//银行卡详情
    ePoints,//我的积分
    ePointConvert ,//积分兑换
    ePointDetail, //积分明细
    eTickets,//我的门票
    eOrder,//我的订单
    eFavorite ,//我的收藏
    eTravels ,//我的游记
    eDownload ,//我的下载
    eFightGroups ,//我的拼团
    eRoute ,//我的线路
    eSetting, //我的设置
    eSettingPush,//推送消息
    eSettingPrivace //隐私
};

@interface MineBaseViewController : Base_BaseViewController
    
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstraint;
@property (assign, nonatomic) MineBaseViewType baseViewType;

@end
