//
//  LBB_TravelCommentCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMHostModel.h"
#import "Header.h"
#import "LBB_SquareTravelListViewModel.h"

@interface LBB_TravelCommentCell : UITableViewCell
@property(nonatomic,strong)BN_SquareTravelComments  *model;
@property(nonatomic,copy)CellBlockVIew   commentBlock;
@end
