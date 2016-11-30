//
//  LBB_GuiderUserFavoriteDataSource.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_SquareViewModel.h"

@interface LBB_SquareSnsFollowFavoriteDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

- (id)initWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)NSMutableArray<LBB_UserOther *> *userAttentionArray;

@end
