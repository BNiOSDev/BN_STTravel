//
//  LBBVideoTableViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMHostModel.h"
#import "UIView+SDAutoLayout.h"
#import "LBB_SquareViewModel.h"
#import "Header.h"
#import "LBB_SearchViewModel.h"

@interface LBB_HomeSearchSquareVideoCell : UITableViewCell
@property(nonatomic, strong) LBB_SearchSquareUgc   *model;
@property(nonatomic, copy)BtnFuncTion             blockBtnFunc;
@end
