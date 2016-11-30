//
//  LBBTravelTableViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMTravelModel.h"
#import "Header.h"
#import "LBB_SquareTravelListViewModel.h"
@interface LBBTravelTableViewCell : UITableViewCell
@property(nonatomic,strong)BN_SquareTravelList       *model;
@property(nonatomic,strong)CellBlockVIew           cellBlock;
@end
