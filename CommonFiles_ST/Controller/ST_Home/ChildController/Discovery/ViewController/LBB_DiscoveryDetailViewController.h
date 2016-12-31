//
//  LBB_DiscoveryDetailViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_DiscoveryViewModel.h"
@interface LBB_DiscoveryDetailViewController : Base_BaseViewController

@property(nonatomic, retain)LBB_DiscoveryModel* viewModel;

-(id)initWithDetailModel:(LBB_DiscoveryDetailModel*)detailModel;

@end
