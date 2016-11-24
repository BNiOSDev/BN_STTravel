//
//  LBB_UserNameViewController.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "MineBaseViewController.h"
#import "LBB_PersonalModel.h"
@interface LBB_UserNameViewController : MineBaseViewController<
UITextFieldDelegate
>
@property(nonatomic,strong) LBB_PersonalModel *personModel;
@property(nonatomic,copy) NSString *userToken;

@end
