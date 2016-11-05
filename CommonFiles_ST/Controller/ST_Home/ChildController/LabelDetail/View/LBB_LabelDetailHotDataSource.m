//
//  LBB_LabelDetailHotDataSource.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailHotDataSource.h"
#import "LBB_LabelDetailHotCell.h"

@interface LBB_LabelDetailHotDataSource()

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation LBB_LabelDetailHotDataSource


- (id)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self.tableView registerClass:[LBB_LabelDetailHotCell class] forCellReuseIdentifier:@"LBB_LabelDetailHotCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_LabelDetailHotCell";
    LBB_LabelDetailHotCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_LabelDetailHotCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_LabelDetailHotCell nil");
    }
    [cell setModel:nil];

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return [tableView fd_heightForCellWithIdentifier:@"LBB_LabelDetailHotCell" cacheByIndexPath:indexPath configuration:^(LBB_LabelDetailHotCell *cell) {
        
        [cell setModel:nil];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
