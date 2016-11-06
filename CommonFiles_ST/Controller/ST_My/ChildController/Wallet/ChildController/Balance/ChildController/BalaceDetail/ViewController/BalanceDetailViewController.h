//
//  BalanceDetailViewController.h
//  LUBABA
//  余额明细/积分明细
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "MineBaseViewController.h"

typedef NS_ENUM(NSInteger,MineShowType) {
    BalanceDetailType = 0,     /**< 余额明细*/
    PointsDetailType           /**< 积分明细*/
};

@interface BalanceDetailViewController : MineBaseViewController

@property(nonatomic,assign)MineShowType showType;

@end
