//
//  LBB_VideoDetailTableViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/7.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMHostModel.h"
#import "UIView+SDAutoLayout.h"
#import "LBB_SquareDetailViewModel.h"
#import "Header.h"
#import "ZFPlayer.h"

@interface LBB_VideoDetailTableViewCell : UITableViewCell
@property(nonatomic, strong) LBB_SquareDetailViewModel   *model;
@property(nonatomic, copy)CellBlockVIew       sendCommentBlock;
@end
