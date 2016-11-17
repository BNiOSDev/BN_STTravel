//
//  LBB_MyTravelTableViewCell.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMTravelModel.h"
#import "Header.h"
#import "Mine_Common.h"


@interface LBB_MyTravelTableViewCell : UITableViewCell

@property(nonatomic,strong)ZJMTravelModel       *model;
@property(nonatomic,strong)CellBlockVIew     cellBlock;
@property(nonatomic,assign)MyTravelsViewType viewType;

@end
