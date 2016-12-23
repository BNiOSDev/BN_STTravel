//
//  LBB_TravelSet_ViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "Header.h"

@interface LBB_TravelSet_ViewController : Base_BaseViewController
@property(nonatomic)BOOL                                autoSync;
@property(nonatomic,copy)BtnFuncTion             blockBtnFunc;
@property(nonatomic,copy)Controllerfeedback   blockFeedBack;

@end
