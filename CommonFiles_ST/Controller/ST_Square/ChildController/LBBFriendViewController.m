//
//  LBBFriendViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBFriendViewController.h"
#import "LBBFriendTableViewCell.h"
#import "Header.h"
#import "LBBFriendModel.h"

@interface LBBFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView     *mTableView;
@property(nonatomic,strong)NSMutableArray   *dataArray;
@end

@implementation LBBFriendViewController
-(void)viewDidLayoutSubviews {
    
    if ([_mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_mTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_mTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        
        [_mTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友推荐";
    
    [self createTable];
}

- (void)initData
{
    __weak typeof(self) temp = self;

    [self.viewModel.friendArray.loadSupport setDataRefreshblock:^{
        [temp.mTableView reloadData];
    }];
    
    [self.mTableView setTableViewData:self.viewModel.friendArray];
    
    //3.1上拉和下拉的动作
    [self.mTableView setHeaderRefreshDatablock:^{
        [temp.viewModel getFriendArrayClearData:YES];
        [temp.mTableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        [temp.viewModel getFriendArrayClearData:NO];
        [temp.mTableView.mj_footer endRefreshing];
    }];
    
    
}
- (void)createTable
{
    UITableView *mtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64) style:UITableViewStylePlain];
    _mTableView = mtableView;
    [self initData];
    //    _mTableView.backgroundColor = BACKVIEWBACKCOLOR;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self setExtraCellLineHidden:_mTableView];
    [self.view addSubview:_mTableView];
}


#pragma mark TableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.viewModel.friendArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AUTO(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellID = @"zjmFriend";
     LBBFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellID];
    
    if (!cell) {
        cell = [[LBBFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableCellID];
    }
    cell.model = self.viewModel.friendArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPat{
    
    
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell  setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell  setSeparatorInset:UIEdgeInsetsZero];
    }
    
}



@end
