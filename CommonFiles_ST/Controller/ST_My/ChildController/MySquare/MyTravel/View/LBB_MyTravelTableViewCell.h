//
//  LBB_MyTravelTableViewCell.h
//  ST_Travel
//
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMTravelModel.h"
#import "Header.h"


@interface LBB_MyTravelTableViewCell : UITableViewCell

@property(nonatomic,strong)ZJMTravelModel       *model;
@property(nonatomic,strong)CellBlockVIew         cellBlock;
@property(nonatomic,assign)TravelsViewType viewType;

@end
