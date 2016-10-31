//
//  LBB_TravelDetailHeadView.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMTravelModel.h"
#import "Header.h"

@interface LBB_TravelDetailHeadView : UIView
@property(nonatomic,strong)ZJMTravelModel       *model;
@property(nonatomic,strong)CellBlockVIew           cellBlock;
@end
