//
//  LBB_GuiderUserDynamicDataSource.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareSnsFollowDynamicDataSource.h"
#import "LBB_GuiderUserDynamicCell.h"
#import "LBB_TravelDetailViewController.h"

@interface LBB_SquareSnsFollowDynamicDataSource()

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation LBB_SquareSnsFollowDynamicDataSource


- (id)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self.tableView registerClass:[LBB_GuiderUserDynamicCell class] forCellReuseIdentifier:@"LBB_GuiderUserDynamicCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return ceil(self.userActionArray.count/2.0);

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_GuiderUserDynamicCell";
    LBB_GuiderUserDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderUserDynamicCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderUserDynamicCell nil");
    }
    NSInteger idx1 = indexPath.row * 2;
    NSInteger idx2 = indexPath.row * 2+1;
    
    LBB_UserAction *obj1 = [self.userActionArray objectAtIndex:idx1];
    [cell setModel1:obj1];
    cell.enableBlock = YES;
    
    
    if (idx2 < self.userActionArray.count) {
        LBB_UserAction *obj2 = [self.userActionArray objectAtIndex:idx2];
        [cell setModel2:obj2];
        cell.item2.hidden = NO;
    }
    else{
        cell.item2.hidden = YES;
    }
    
    cell.tag = indexPath.row;

    WS(ws);
    cell.block = ^(NSNumber* num){
        
        NSInteger index = cell.tag*2 + [num integerValue];
        NSLog(@"需跳转到老郑的游记详情页面");
        LBB_TravelDetailViewController* dest = [[LBB_TravelDetailViewController alloc] init];
        BN_SquareTravelList *model = [[BN_SquareTravelList alloc] init];
        
        LBB_UserAction* user = ws.userActionArray[index];
        model.travelNotesId = user.objId;
        dest.model = model;
        [ws.parentController.navigationController pushViewController:dest animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger idx1 = indexPath.row * 2;
    LBB_UserAction *obj1 = [self.userActionArray objectAtIndex:idx1];
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserDynamicCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserDynamicCell *cell) {

        [cell setModel1:obj1];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
