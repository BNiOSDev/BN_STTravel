//
//  PoohBaseTableViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"

@interface PoohBaseTableViewController : PoohBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, assign) BOOL isGroup;


@end