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

@interface LBBVideoTableViewCell : UITableViewCell
@property(nonatomic, strong) LBB_SquareUgc   *model;
@property(nonatomic, copy)BtnFuncTion             blockBtnFunc;
@property(nonatomic, copy)CellBlockVIew          sendCommentBolck;

@property(nonatomic,strong)UIImageView      *contentImage;//主图，内容图
@end
