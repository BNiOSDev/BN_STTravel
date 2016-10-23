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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友推荐";
    [self initData];
    
    [self createTable];
}

- (void)initData
{
    _dataArray = [[NSMutableArray alloc]init];
    for(int i = 0;i < 9;i++)
    {
        LBBFriendModel *model = [[LBBFriendModel alloc]init];
        model.iconUrl = @"http://c.hiphotos.baidu.com/image/pic/item/6c224f4a20a446230b10a7179a22720e0df3d7e8.jpg";
        model.userName = @"帅哥老郑";
        model.content = @"嗯嗯，确实是个帅哥";
        [_dataArray addObject:model];
    }
}
- (void)createTable
{
    UITableView *mtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64 - 49) style:UITableViewStylePlain];
    _mTableView = mtableView;
    //    _mTableView.backgroundColor = BACKVIEWBACKCOLOR;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self setExtraCellLineHidden:_mTableView];
    [self.view addSubview:_mTableView];
}


#pragma mark TableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
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
    cell.model = _dataArray[indexPath.row];
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
