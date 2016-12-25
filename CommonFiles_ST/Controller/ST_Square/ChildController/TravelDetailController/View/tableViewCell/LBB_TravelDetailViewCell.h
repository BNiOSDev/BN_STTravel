//
//  LBB_TravelDetailViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMHostModel.h"
#import "BN_SquareTravelNotesModel.h"
#import "Header.h"

@interface LBB_TravelDetailViewCell : UITableViewCell
@property(nonatomic,strong)TravelNotesDetails   *model;
@property(nonatomic,copy)CellBlockVIew   cellBlock;
@end
