//
//  LBB_GuiderUserFavoriteDataSource.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserFavoriteDataSource.h"
#import "LBB_GuiderUserFunsListCell.h"


@interface LBB_GuiderUserFavoriteDataSource()

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation LBB_GuiderUserFavoriteDataSource


- (id)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self.tableView registerClass:[LBB_GuiderUserFunsListCell class] forCellReuseIdentifier:@"LBB_GuiderUserFavoriteListCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userAttentionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_GuiderUserFavoriteListCell";
    LBB_GuiderUserFunsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderUserFunsListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderUserFavoriteListCell nil");
    }
    [cell setModel:self.userAttentionArray[indexPath.row] isTour:YES show:NO];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserFavoriteListCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserFunsListCell *cell) {
        
        [cell setModel:ws.userAttentionArray[indexPath.row] isTour:YES show:NO];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
