//
//  LBB_ScenicDetailSubjectViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"
#import "LBB_SpotDetailsViewModel.h"

@interface LBB_ScenicDetailSubjectViewController : PoohBaseViewController

@property(nonatomic, assign)LBBPoohHomeType homeType;
@property(nonatomic, strong)LBB_SpotSpecialDetailsViewModel* spotModel;

@end
