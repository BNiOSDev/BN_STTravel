//
//  LBBVideoViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBVideoViewController.h"
#import "ZJMHostModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "PraiseModel.h"
#import "CommentModel.h"
#import "LBBVideoTableViewCell.h"
#import "LBB_SquareViewModel.h"
#import "Header.h"
#define VideoCell @"zjmVideoCell"
#import "LBBVideoPlayerViewController.h"
#import "LBB_VideoDetailViewController.h"

@interface LBBVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)LBB_SquareViewModel* viewModel;


@end

@implementation LBBVideoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 30 - 64 - 44 - 20)];
    [self initViewModel];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[LBBVideoTableViewCell class] forCellReuseIdentifier:VideoCell];
}


-(void)initViewModel{
    
    self.viewModel = [[LBB_SquareViewModel alloc] init];
    
    /**
     3.4.4	广场-广场主页-图片/视频列表（已测）
     
     @ param type 1主页  视频为单独的2.视频
     @ param clear 清空原数据
     */
    __weak typeof(self) temp = self;

    [self.viewModel getUgcArrayType:2 ClearData:YES];
    [self.viewModel.ugcVideoArray.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.viewModel.ugcVideoArray];
    
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.viewModel getUgcArrayType:2 ClearData:YES];
        
        [temp.tableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        [temp.viewModel getUgcArrayType:2 ClearData:NO];
        [temp.tableView.mj_footer endRefreshing];
    }];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.ugcVideoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBBVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoCell];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.viewModel.ugcVideoArray[indexPath.row];
    __weak typeof (self) weakSelf = self;
    cell.blockBtnFunc = ^(NSInteger tag)
    {
        if(tag == 0)
        {
            LBB_SquareUgc *model = weakSelf.viewModel.ugcVideoArray[indexPath.row];
            LBBVideoPlayerViewController  *vc = [[LBBVideoPlayerViewController alloc]init];
            vc.videoUrl = [NSURL URLWithString:model.videoUrl];
            [self presentViewController:vc animated:YES completion:nil];
//            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LBB_SquareUgc  *model = self.viewModel.ugcVideoArray[indexPath.row];
    NSLog(@"视频链接：%@",model.videoUrl);
    LBB_VideoDetailViewController *Vc = [[LBB_VideoDetailViewController alloc]init];
    Vc.viewModel = self.viewModel.ugcVideoArray[indexPath.row];
     [self.navigationController pushViewController:Vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.viewModel.ugcVideoArray[indexPath.row];
    
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBBVideoTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}




@end
