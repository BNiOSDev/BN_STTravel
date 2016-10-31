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

@interface LBB_TravelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSMutableArray  *dataArray;
@property(nonatomic, weak)LBB_TravelDetailHeadView *tabelHead;
@property(nonatomic, weak)UIView *tabelFoot;
@property(nonatomic, weak)LBB_ToolsBtnView *toolsView;
@end

@implementation LBB_TravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = BACKVIEWCOLOR;
    [self initData];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - AUTO(15))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = 0;
    [self.tableView registerClass:[LBB_TravelDetailViewCell class] forCellReuseIdentifier:@"LBB_TravelDetailViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell_TravelDetail"];
    [self.tableView setTableHeaderView:self.tabelHead];
    [self.tableView setTableFooterView:self.tabelFoot];
    
}

- (void)initData
{
    _dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 9; i++) {
        ZJMTravelModel  *model = [[ZJMTravelModel alloc]init];
        model.iconName = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.imageUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.name = @"钟爱SD的男人";
        model.msgContent = @"开启说走就走的旅行吧";
        model.timeStr = @"2016-09-09";
        model.daysStr = @"5 days";
        model.vistNum = @"1080";
        model.praiseNum = @"999";
        model.commentNum = @"999";
        model.collectNum = @"9999";
        [_dataArray addObject:model];
    }

}

-  (LBB_TravelDetailHeadView *)tabelHead
{
    if(_tabelHead == nil)
    {
        LBB_TravelDetailHeadView *headView = [[LBB_TravelDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
        headView.model = _dataArray[0];
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

- (LBB_ToolsBtnView *)toolsView
{
    if(_toolsView == nil)
    {
        LBB_ToolsBtnView *headView = [[LBB_ToolsBtnView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(40))];
//        headView.model = _dataArray[0];
        NSArray *array = @[@"景点 5",@"美食 12",@"民宿 13",@"购物 7"];
        headView.buttonList = array;
        return headView;
    }
    return _toolsView;
}

#pragma mark -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    return self.dataArray.count;
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
            sectionLabel.text = @"第一天 2016-09-10";
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
        cell.textLabel.text = @"查看线路及路费清单";
        return cell;
    }else{
        LBB_TravelDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_TravelDetailViewCell"];
        cell.accessoryType = 0;
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
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
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    if(indexPath.section == 0)
    {
        return AUTO(45);
    }
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



@end
