//
//  LBB_LabelDetailUserDataSource.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_TagsViewModel.h"

@interface LBB_LabelDetailUserDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

- (id)initWithTableView:(UITableView *)tableView;

@property(nonatomic, weak) UIViewController* parentViewController;
@property (nonatomic, strong)NSMutableArray<LBB_TagShowViewUsers *> *showViewUsersArray;//用户数据

@end
