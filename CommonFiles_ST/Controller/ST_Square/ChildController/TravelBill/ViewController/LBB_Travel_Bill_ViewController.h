//
//  LBB_Travel_Bill_ViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "BN_SquareTravelNotesModel.h"

@interface LBB_Travel_Bill_ViewController : Base_BaseViewController
@property(nonatomic,strong)BN_SquareTravelNotesBillModel  *model;
@property(nonatomic)NSInteger   travelNotesId;//游记id
@property(nonatomic)BOOL          edit;
@end
