//
//  LBB_EditShopRecoder_Controller.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "BN_SquareTravelNotesBillModel.h"
#import "BN_SquareTravelNotesModel.h"

@interface LBB_EditShopRecoder_Controller : Base_BaseViewController
@property(nonatomic,strong)BN_SquareTravelNotesconsumeDetails *model;
@property(nonatomic,strong)TravelNotesDetails  *footPointNote;
@end
