//
//  LBB_LabelDetailHotDataSource.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_TagsViewModel.h"

@interface LBB_LabelDetailHotDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

- (id)initWithTableView:(UITableView *)tableView;
@property (nonatomic, strong)NSMutableArray<LBB_TagShowViewData *> *showImageArray;//标签图热门排序

@end
