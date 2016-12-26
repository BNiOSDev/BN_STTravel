//
//  LBB_FootPointDetailController.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LBB_SquareTravelListViewModel.h"

@interface LBB_FootPointDetailController : Base_BaseViewController
@property(nonatomic,strong)BN_SquareTravelList  *viewModel;
@property(nonatomic,strong)TravelNotesDetails      *notesDataModel;
@end
