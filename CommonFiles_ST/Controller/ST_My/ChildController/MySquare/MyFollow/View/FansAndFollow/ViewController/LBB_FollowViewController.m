//
//  LBB_FollowViewController.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FollowViewController.h"
#import "LBB_FollowModel.h"
#import "LBB_FollowViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Header.h"

#define FllowTableViewCell @"FllowTableViewCell"


@interface LBB_FollowViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong)NSMutableArray   *dataArray;

@end

@implementation LBB_FollowViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++) {
        LBB_FollowModel  *model = [[LBB_FollowModel alloc]init];
        model.userImageURL = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.userName = @"钟爱SD的男人钟";
        model.userSignature = @"开启说走就走的旅行吧";
        model.certified = (i%2) ? YES: NO;
        model.lvLevel = 99;
        model.isFollow = (i%2) ? NO: YES;
        [_dataArray addObject:model];
    }
    [self createTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)createTable
{
    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:0];
    _mTableView.height = _mTableView.height - 40 - 64;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = ColorBackground;
    
    UINib *nib = [UINib nibWithNibName:@"LBB_FollowViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:FllowTableViewCell];
    
    [self.view  addSubview:_mTableView];
    
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:FllowTableViewCell configuration:^(LBB_FollowViewCell *cell) {
        cell.model = self.dataArray[indexPath.row];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_FollowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FllowTableViewCell];
   
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
