//
//  LBB_SquareTravelViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelViewController.h"
#import "LBB_SquareTravelViewCell.h"
#import "LBB_SquareTravelModel.h"
#import "HMSegmentedControl.h"

@interface LBB_SquareTravelViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (weak,nonatomic) IBOutlet UIView *segmentBgView;
@property (strong,nonatomic) LBB_MessageSquareTravelViewModel *viewModel;

@end

@implementation LBB_SquareTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lineView.backgroundColor = ColorLine;
    self.tableViewTopConstraint.constant = 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    [self initTableview];
    [self initDataSource];
}

- (void)initTableview
{
    UINib *nib = [UINib nibWithNibName:@"LBB_SquareTravelViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_SquareTravelViewCell"];
}


- (void)initDataSource
{
    self.viewModel = [[LBB_MessageSquareTravelViewModel alloc] init];
  
    __weak typeof (self) weakSelf = self;
    [self.tableView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getDataArrayWithType:[self getMsgType] IsClear:YES];
    } footerRefreshDatablock:^{
       [weakSelf.viewModel getDataArrayWithType:[self getMsgType] IsClear:NO];
    }];
    
    //设置绑定数组
    [self.tableView setTableViewData:self.viewModel.dataArray];
    
    
    [self.viewModel.dataArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.tableView loadData:self.viewModel.dataArray];
    
    //刷新数据
    [self.viewModel getDataArrayWithType:[self getMsgType] IsClear:YES];
}

//msgType = 4关注消息 5点赞提醒 6评论提醒 7收藏提醒
- (int)getMsgType
{
    switch (self.messgeType) {
        case eMessageFollow://关注
            return 4;
            break;
        case eMessageLike://点赞
              return 5;
            break;
        case eMessageComment://评论
              return 6;
            break;
        case eMessageCollection://收藏
              return 7;
            break;
        default:
            break;
    }
    
    return 4;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_SquareTravelViewCell"
                                                 configuration:^(LBB_SquareTravelViewCell *cell) {
                                                     if (indexPath.row < self.viewModel.dataArray.count) {
                                                         LBB_MessageSquareTravelModel *cellInfo = [self.viewModel.dataArray objectAtIndex:[indexPath row]];
                                                         [cell setCellInfo:cellInfo];
                                                     }
                                                 }];
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_SquareTravelViewCell";
    LBB_SquareTravelViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_SquareTravelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.messgeType = self.messgeType;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    if (indexPath.row < self.viewModel.dataArray.count) {
        LBB_MessageSquareTravelModel *cellInfo = [self.viewModel.dataArray objectAtIndex:[indexPath row]];
        [cell setCellInfo:cellInfo];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
