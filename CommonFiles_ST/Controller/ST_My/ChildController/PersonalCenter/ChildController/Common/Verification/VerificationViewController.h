//
//  VerificationViewController.h
//  ST_Travel
//  获取验证码
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "MineBaseViewController.h"
#import "LBB_PersonalModel.h"

@interface VerificationViewController : MineBaseViewController

@property(nonatomic,copy) NSString *userToken;
@property(nonatomic,strong) LBB_PersonalModel *mainPersonModel;


@end
