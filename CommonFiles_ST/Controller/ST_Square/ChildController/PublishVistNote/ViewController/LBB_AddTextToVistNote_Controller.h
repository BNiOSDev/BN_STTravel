//
//  LBB_AddTextToVistNote_Controller.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "Header.h"
#import "LBB_TravelDraftViewModel.h"

@interface LBB_AddTextToVistNote_Controller : Base_BaseViewController
@property(nonatomic,strong)NSArray   *mapPointArray;
@property(nonatomic,copy)Controllerfeedback  blockFeedBack;
@property(nonatomic, strong)LBB_TravelDraftViewModel  *dataModel;//游记模型
@property(nonatomic,strong)TravelNotesDetails                 *model;       //足迹模型
@end
