//
//  LBB_TravelDetailViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LBB_SquareTravelListViewModel.h"

@interface LBB_TravelDetailViewController : Base_BaseViewController
//游记列表进入必传
@property(nonatomic,strong)BN_SquareTravelList   *model;
//下载游记进入，必传。model必不可传
@property(nonatomic,strong)BN_SquareTravelNotesModel   *travelDetailModel;
@end
