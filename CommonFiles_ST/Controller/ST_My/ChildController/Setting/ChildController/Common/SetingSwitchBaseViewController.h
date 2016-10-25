//
//  SetingSwitchBaseViewController.h
//  LUBABA
//
//  Created by Diana on 16/10/10.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "MineBaseViewController.h"

@interface SetingSwitchBaseViewController : MineBaseViewController<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end
