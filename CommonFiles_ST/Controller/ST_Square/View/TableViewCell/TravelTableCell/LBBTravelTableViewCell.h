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

@interface LBBTravelTableViewCell : UITableViewCell
@property(nonatomic,strong)ZJMTravelModel       *model;
@property(nonatomic,strong)CellBlockVIew           cellBlock;
@property(nonatomic,assign)TravelsViewType viewType;


@end
