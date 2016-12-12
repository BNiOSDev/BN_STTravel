//
//  LBB_HostDetailTableViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMHostModel.h"
#import "UIView+SDAutoLayout.h"
#import "LBB_SquareDetailViewModel.h"
#import "Header.h"
@interface LBB_HostDetailTableViewCell : UITableViewCell
@property(nonatomic, strong) LBB_SquareDetailViewModel   *model;
@property(nonatomic,copy)CellBlockVIew  cellBtnBlock;
@end
