//
//  ZJMHostTableViewCell.h
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_SquareViewModel.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"

@interface ZJMHostTableViewCell : UITableViewCell
@property(nonatomic, strong) LBB_SquareUgc   *model;
@property(nonatomic,copy)CellBlockVIew            btnBlock;
@end
