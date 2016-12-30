//
//  LBB_DiscoveryDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryDetailViewController.h"
#import "LBBDiscoveryDetailImageViewCell.h"
#import "LBB_DiscoveryDetailMsgCell.h"
#import "LBB_PoohAttributedTextCell.h"
#import "LBB_Share.h"
#import "LBB_DiscoveryDownLoadManager.h"
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

-(void)initViewModel{

    WS(ws);
    [self.viewModel.discoveryDetail.loadSupport setDataRefreshblock:^{
        NSLog(@"discoveryDetail succ");
        NSLog(@"self.viewModel.discoveryDetail:%@",ws.viewModel.discoveryDetail);
        NSLog(@"self.viewModel.discoveryDetail lineContent:%@",ws.viewModel.discoveryDetail.lineContent);
        NSLog(@"self.viewModel.discoveryDetail lineFeature:%@",ws.viewModel.discoveryDetail.lineFeature);

        
        [ws.tableView reloadData];
    }];

    [self.tableView setHeaderRefreshDatablock:^{
        [ws.viewModel getDiscoveryDetailData];
        [ws.tableView.mj_header endRefreshing];

    } footerRefreshDatablock:^{
    
    }];
    
    [self.viewModel getDiscoveryDetailData];

    
}

-(void)loadCustomNavigationButton{
    [super loadCustomNavigationButton];
    WS(ws);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    UIButton *download = [[UIButton alloc] init];
    [download setImage:IMAGE(@"ST_Discovery_Download") forState:UIControlStateNormal];
    download.frame = CGRectMake(0, 0, 45, 45);
    [download bk_addEventHandler:^(id sender){
        
        if (ws.viewModel.discoveryDetail != nil) {
            [[LBB_DiscoveryDownLoadManager sharedInstance] saveDiscoveryDetail:ws.viewModel.discoveryDetail curVC:ws];
        }
        else{
            [ws showHudPrompt:@"数据存储错误,请刷新"];
        }
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *downloadItem = [[UIBarButtonItem alloc] initWithCustomView:download];
    
    UIButton *share = [[UIButton alloc] init];
    [share setImage:IMAGE(@"导游_分享") forState:UIControlStateNormal];
    share.frame = CGRectMake(0, 0, 45, 45);
    [share bk_addEventHandler:^(id sender){
        
        [[LBB_Share sharedManager] shareTitle:ws.viewModel.discoveryDetail.shareTitle url:ws.viewModel.discoveryDetail.shareUrl text:ws.viewModel.discoveryDetail.shareContent image:IMAGE(PlaceHolderImage) viewController:ws];
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    self.navigationItem.rightBarButtonItems = @[shareItem,downloadItem];
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
    [self initViewModel];

}



-(void)registerTableViewCell{
    //header part

    [self.tableView registerClass:[LBBDiscoveryDetailImageViewCell class] forCellReuseIdentifier:@"LBBDiscoveryDetailImageViewCell"];
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
            return [tableView fd_heightForCellWithIdentifier:@"LBBDiscoveryDetailImageViewCell" cacheByIndexPath:indexPath configuration:^(LBBDiscoveryDetailImageViewCell* cell){
                
                [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.discoveryDetail.coverImagesUrl] placeholderImage:IMAGE(PlaceHolderImage)];
            }];
        }
        else{
            return [tableView fd_heightForCellWithIdentifier:@"LBB_DiscoveryDetailMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_DiscoveryDetailMsgCell* cell){

            }];
        }

    }
    else if(indexPath.section == 1){
        return [tableView fd_heightForCellWithIdentifier:@"LBB_PoohAttributedTextCell" cacheByIndexPath:indexPath configuration:^(LBB_PoohAttributedTextCell* cell){
            [cell setAttributedText:self.viewModel.discoveryDetail.lineContent];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_PoohAttributedTextCell" cacheByIndexPath:indexPath configuration:^(LBB_PoohAttributedTextCell* cell){
            [cell setAttributedText:self.viewModel.discoveryDetail.lineFeature];
        }];
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"LBBDiscoveryDetailImageViewCell";
            LBBDiscoveryDetailImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBBDiscoveryDetailImageViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                NSLog(@"LBBDiscoveryDetailImageViewCell nil");
            }
            [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.discoveryDetail.coverImagesUrl] placeholderImage:IMAGE(PlaceHolderImage)];
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"LBB_DiscoveryDetailMsgCell";
            LBB_DiscoveryDetailMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBB_DiscoveryDetailMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                NSLog(@"LBB_DiscoveryDetailMsgCell nil");
            }
            [cell setModel:self.viewModel.discoveryDetail];
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
        
        if (indexPath.section == 1) {
            [cell setAttributedText:self.viewModel.discoveryDetail.lineContent];
        }
        else{
            [cell setAttributedText:self.viewModel.discoveryDetail.lineFeature];
        }
        return cell;
    }
    
    
}


@end
