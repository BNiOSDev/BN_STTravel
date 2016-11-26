//
//  LBB_MyTravelTableViewCell.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_TravelModel.h"
#import "LBB_TravelGuideModel.h"
#import "Header.h"
#import "Mine_Common.h"


@interface LBB_MyTravelTableViewCell : UITableViewCell

@property(nonatomic,strong)LBB_TravelModel       *model;
@property(nonatomic,strong)LBB_TravelGuideModel  *guideModel;

@property(nonatomic,strong)CollectionViewCellBlock  cellBlock;
@property(nonatomic,strong)CollectionViewCellBlock  guideCellBlock;
@property(nonatomic,assign)MyTravelsViewType viewType;
@property(nonatomic,assign)MySquareViewType squareType;

@end
