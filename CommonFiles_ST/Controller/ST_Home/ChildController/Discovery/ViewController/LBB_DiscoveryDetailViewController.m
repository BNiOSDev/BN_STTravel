//
//  LBB_DiscoveryDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryDetailViewController.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBB_DiscoveryDetailMsgCell.h"
#import "LBB_PoohAttributedTextCell.h"

@interface LBB_DiscoveryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;

@end

@implementation LBB_DiscoveryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loadCustomNavigationButton{
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    UIButton *share = [[UIButton alloc] init];
    [share setBackgroundImage:IMAGE(@"景点详情_分享") forState:UIControlStateNormal];
    share.frame = CGRectMake(0, 0, 27, 27);
    [share bk_addEventHandler:^(id sender){
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    UIButton *favorite = [[UIButton alloc] init];
    [favorite setBackgroundImage:IMAGE(@"景点详情_收藏") forState:UIControlStateNormal];
    favorite.frame = CGRectMake(0, 0, 27, 27);
    [favorite bk_addEventHandler:^(id sender){
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:favorite];
    
    self.navigationItem.rightBarButtonItems = @[searchItem,favoriteItem];
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerTableViewCell];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
}


-(void)registerTableViewCell{
    //header part

    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBB_DiscoveryDetailMsgCell class] forCellReuseIdentifier:@"LBB_DiscoveryDetailMsgCell"];
    [self.tableView registerClass:[LBB_PoohAttributedTextCell class] forCellReuseIdentifier:@"LBB_PoohAttributedTextCell"];

}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }
    if (section == 1) {
        return SeparateLineWidth;
    }
    return AutoSize(10);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    [v setBackgroundColor:ColorLine];
    return v;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0://header部分
            return 2;
            break;
        case 1://达人秒拍
            return 1;
            break;
        case 2://推荐理由
            return 1;
            break;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
                [cell setCycleScrollViewHeight:AutoSize(344/2)];
                [cell setCycleScrollViewUrls:nil];
            }];
        }
        else{
            return [tableView fd_heightForCellWithIdentifier:@"LBB_DiscoveryDetailMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_DiscoveryDetailMsgCell* cell){

            }];
        }

    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_PoohAttributedTextCell" cacheByIndexPath:indexPath configuration:^(LBB_PoohAttributedTextCell* cell){
            [cell setAttributedText:nil];
        }];
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
            LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                NSLog(@"LBBPoohCycleScrollCell nil");
            }
            [cell setCycleScrollViewHeight:AutoSize(344/2)];
            [cell setCycleScrollViewUrls:nil];
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"LBB_DiscoveryDetailMsgCell";
            LBB_DiscoveryDetailMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBB_DiscoveryDetailMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                NSLog(@"LBB_DiscoveryDetailMsgCell nil");
            }
            return cell;
        }
        

    }
    else{
        static NSString *cellIdentifier = @"LBB_PoohAttributedTextCell";
        LBB_PoohAttributedTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_PoohAttributedTextCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_PoohAttributedTextCell nil");
        }
        [cell setAttributedText:nil];
        return cell;
    }
    
    
}


@end
