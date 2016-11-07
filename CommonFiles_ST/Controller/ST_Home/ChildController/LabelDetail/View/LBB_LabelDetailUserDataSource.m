//
//  LBB_LabelDetailUserDataSource.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailUserDataSource.h"
#import "LBB_LabelDetailUserCell.h"

@interface LBB_LabelDetailUserDataSource()

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation LBB_LabelDetailUserDataSource


- (id)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self.tableView registerClass:[LBB_LabelDetailUserCell class] forCellReuseIdentifier:@"LBB_LabelDetailUserCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_LabelDetailUserCell";
    LBB_LabelDetailUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_LabelDetailUserCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_LabelDetailUserCell nil");
    }
    [cell setModel:nil];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_LabelDetailUserCell" cacheByIndexPath:indexPath configuration:^(LBB_LabelDetailUserCell *cell) {
        
        [cell setModel:nil];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
