//
//  LBB_HostTableViewCell.h
//  ForXiaMen
//
//  Created by dawei che on 2016/10/24.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HostModel.h"

@interface LBB_HostTableViewCell : UITableViewCell
@property(nonatomic, copy)NSString   *setModel;
@property(nonatomic,strong)HostModel    *entity;
@end
