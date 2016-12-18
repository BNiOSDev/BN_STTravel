//
//  LBB_TravelDetailViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDetailViewController.h"
#import "ST_TabBarController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "Header.h"
#import "ZJMTravelModel.h"
#import "LBB_TravelCommentCell.h"
#import "LBB_TravelDetailHeadView.h"
#import "LBB_ToolsBtnView.h"
#import "LBB_TravelDetailViewCell.h"
#import "LBB_Travel_Bill_ViewController.h"

@interface LBB_TravelDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, weak)LBB_TravelDetailHeadView *tabelHead;
@property(nonatomic, weak)UIView *tabelFoot;
@property(nonatomic, strong)LBB_ToolsBtnView *toolsView;
@property(nonatomic, strong)BN_SquareTravelList *viewModel;
@property(nonatomic, strong)NSMutableArray<NSMutableArray *>        *dealDataArray;
@end

@implementation LBB_TravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"游记详情";
    self.view.backgroundColor = WHITECOLOR;
    [self initView];
    [self initNavi];
    [self initData];
}
- (void)initView
{
    LBB_ToolsBtnView *headView = [[LBB_ToolsBtnView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(40))];
    _toolsView = headView;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, - 64,self.view.frame.size.width, self.view.frame.size.height - AUTO(15) + 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = 0;
    [self.tableView registerClass:[LBB_TravelDetailViewCell class] forCellReuseIdentifier:@"LBB_TravelDetailViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell_TravelDetail"];
    [self.tableView setTableHeaderView:self.tabelHead];
    [self.tableView setTableFooterView:self.tabelFoot];
    
}

- (void)initNavi
{
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmshare") style:UIBarButtonItemStylePlain target:self action:@selector(shareFunc)];
    shareBtn.tintColor = WHITECOLOR;
    
    UIBarButtonItem *downBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmdownlaod") style:UIBarButtonItemStylePlain target:self action:@selector(downFunc)];
    downBtn.tintColor = WHITECOLOR;
    
    NSArray *barBtns = @[downBtn,shareBtn];
    self.navigationItem.rightBarButtonItems = barBtns;
}

- (void)shareFunc
{
    NSLog(@"分享");
}

- (void)downFunc
{
    NSLog(@"下载");
}

- (void)initData
{
    _viewModel = [[BN_SquareTravelList alloc]init];
    _viewModel.travelNotesId = _model.travelNotesId;
    __weak typeof(self ) weakSelf =self;
    [_viewModel getTravelDetailModel];
    [_viewModel.travelDetailModel.loadSupport setDataRefreshblock:^{
//        weakSelf.tabelHead.model = weakSelf.viewModel;
        
        NSArray *array = @[[NSString stringWithFormat:@"景点 %d",weakSelf.viewModel.travelDetailModel.totalScenicSpots],[NSString stringWithFormat:@"美食 %d",weakSelf.viewModel.travelDetailModel.totalFood],[NSString stringWithFormat:@"民宿 %d",weakSelf.viewModel.travelDetailModel.totalHomestay],[NSString stringWithFormat:@"购物 %d",weakSelf.viewModel.travelDetailModel.totalShop]];
        
            weakSelf.toolsView.buttonList = array;
            //为空时，不该有footview
            if(weakSelf.viewModel.travelDetailModel.travelNotesDetails.count == 0)
            {
                weakSelf.tableView.tableFooterView = nil;
            }
        
        [weakSelf dealData];
    }];
    [_tableView reloadData];
}

- (void)dealData
{
    if(!_dealDataArray)
    {
        _dealDataArray = [[NSMutableArray alloc]init];
    }else{
        [_dealDataArray removeAllObjects];
    }

    for (__block int i = 1; i <= _model.dayCount; i++) {
        
        NSMutableArray    *elementArray = [[NSMutableArray alloc]init];
        for(TravelNotesDetails *element in _viewModel.travelDetailModel.travelNotesDetails)
        {
            if(i == element.whitchDay)
            {
                [elementArray addObject:element];
            }
        }
        
        [_dealDataArray addObject:elementArray];
    }
      [self.tableView reloadData];
}

-  (LBB_TravelDetailHeadView *)tabelHead
{
    if(_tabelHead == nil)
    {
        LBB_TravelDetailHeadView *headView = [[LBB_TravelDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
        headView.model = _model;
        return headView;
    }
    return _tabelHead;
}

- (UIView *)tabelFoot
{
    if(!_tabelFoot)
    {
        UIView *tableFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(30))];
        tableFoot.backgroundColor = WHITECOLOR;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 1.0, tableFoot.height)];
        line.backgroundColor = BLACKCOLOR;
        [tableFoot addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(line.right + 15, 5, DeviceWidth - 56, AUTO(20))];
        label.text = @"游记到此结束哦！";
        label.textColor = MORELESSBLACKCOLOR;
        label.font = FONT(AUTO(15.0));
        [tableFoot addSubview:label];
        return tableFoot;
    }
    return _tabelFoot;
}

#pragma mark -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.dayCount + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    return _dealDataArray[section-1].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return AUTO(40);
    }else{
        return AUTO(25);
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return AUTO(20);
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(20))];
//    footView.backgroundColor = WHITECOLOR;
//    
//    if(section != 0)
//    {
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 1.0, AUTO(20))];
//        line.backgroundColor = BLACKCOLOR;
//        [footView addSubview:line];
//    }
//    
//    return footView;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.toolsView;
    }else{
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(25))];
        headView.backgroundColor = WHITECOLOR;

            UIView *ballView = [[UIView alloc]initWithFrame:CGRectMake(14, 0, AUTO(12.0), AUTO(12.0))];
            LRViewBorderRadius(ballView, ballView.height / 2.0, 0, [UIColor clearColor]);
            ballView.backgroundColor = BLACKCOLOR;
            [headView addSubview:ballView];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, ballView.bottom, 1.0, AUTO(13.0))];
            line.backgroundColor = BLACKCOLOR;
            [headView addSubview:line];
            
            ballView.centerX = line.centerX;
        
            UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(ballView.right + 5, 0, DeviceWidth - (ballView.right + 5), AUTO(15))];
            sectionLabel.font = FONT(AUTO(13.0));
            sectionLabel.text = [NSString stringWithFormat:@"第 %ld 天",section];
            sectionLabel.centerY = ballView.centerY;
            [headView addSubview:sectionLabel];
            return headView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell_TravelDetail"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = 0;
        cell.textLabel.text = @"查看线路及路费清单";
        return cell;
    }else{
        LBB_TravelDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_TravelDetailViewCell"];
        if(!cell)
        {
            NSLog(@"不要啊");
        }
        cell.accessoryType = 0;
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        cell.selectionStyle = 0;
        cell.model = _dealDataArray[indexPath.section - 1][indexPath.row];
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"xuanzhong");
    if(indexPath.section == 0)
    {
        LBB_Travel_Bill_ViewController *vc = [[LBB_Travel_Bill_ViewController alloc]init];
        vc.travelNotesId = _model.travelNotesId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>

    if(indexPath.section == 0)
    {
        return AUTO(45);
    }
    if(indexPath.row > _dealDataArray[indexPath.section - 1].count)
    {
        return 0;
    }
    id model = _dealDataArray[indexPath.section - 1][indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_TravelDetailViewCell class] contentViewWidth:[self cellContentViewWith]];
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

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     NSLog(@"偏移量=%f",scrollView.contentOffset.y);
    
    if(scrollView.contentOffset.y >= 0.00 && scrollView.contentOffset.y <= 64.00)
    {
        NSLog(@"透明度比例 %f",scrollView.contentOffset.y / 64.00);
          [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = scrollView.contentOffset.y / 64.00;
    }

    
}



@end
