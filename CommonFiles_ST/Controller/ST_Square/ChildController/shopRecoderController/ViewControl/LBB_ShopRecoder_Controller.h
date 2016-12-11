//
//  LBB_ShopRecoder_Controller.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "BN_SquareTravelNotesBillModel.h"

@interface LBB_ShopRecoder_Controller : Base_BaseViewController
@property(nonatomic,strong)BN_SquareTravelNotesBillModel  *dataModel;
@property(nonatomic)BOOL       edit;
@end
