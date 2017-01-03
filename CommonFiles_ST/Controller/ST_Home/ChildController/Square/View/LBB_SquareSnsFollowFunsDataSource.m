//
//  LBB_GuiderUserFunsDataSource.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareSnsFollowFunsDataSource.h"
#import "LBB_GuiderUserFunsListCell.h"
#import "LBB_SquareSnsFollowViewController.h"

@interface LBB_SquareSnsFollowFunsDataSource()

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation LBB_SquareSnsFollowFunsDataSource


- (id)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self.tableView registerClass:[LBB_GuiderUserFunsListCell class] forCellReuseIdentifier:@"LBB_GuiderUserFunsListCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userFansArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_GuiderUserFunsListCell";
    LBB_GuiderUserFunsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderUserFunsListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderUserFunsListCell nil");
    }
    cell.rightButton.layer.borderColor = ColorBtnYellow.CGColor;
    cell.rightButton.layer.borderWidth = 1;
    [cell.rightButton setBackgroundColor:ColorWhite];
    [cell.rightButton setTitleColor:ColorGray forState:UIControlStateNormal];
    [cell.rightButton setTitle:@"已关注" forState:UIControlStateNormal];
    [cell setModel:self.userFansArray[indexPath.row] isTour:NO show:NO];
    
    WS(ws);
    cell.enableBlock = YES;
    cell.block = ^(NSNumber* num){

        LBB_SquareSnsFollowViewController* dest = [[LBB_SquareSnsFollowViewController alloc]init];
        LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
        LBB_UserOther* userObj = ws.userFansArray[indexPath.row];
        viewModel.userId = userObj.userId;
        dest.viewModel = viewModel;
        [ws.parentController.navigationController pushViewController:dest animated:YES];
    };
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserFunsListCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserFunsListCell *cell) {
        [cell setModel:self.userFansArray[indexPath.row] isTour:NO show:NO];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
