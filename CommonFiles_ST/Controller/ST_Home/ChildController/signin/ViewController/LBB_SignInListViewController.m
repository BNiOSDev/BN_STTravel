//
//  LBB_SignInListViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SignInListViewController.h"
#import "LBB_SignInListCell.h"
#import "PoohCommon.h"
#import "LBB_NearSign.h"
@interface LBB_SignInListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UILabel* noteLable;
@property(nonatomic, retain)UITableView* tableView;

@end

@implementation LBB_SignInListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initViewModel{

    WS(ws);
    [self.noteLable setText:[NSString stringWithFormat:@"您已完成%ld个景点，目前排名第%d名",self.viewModel.signInNum,self.viewModel.rank]];

    [self.viewModel getNearSignInArrayClearData:YES];
    [self.viewModel.nearSignInArray.loadSupport setDataRefreshblock:^{
        
        [ws.tableView reloadData];
    }];

    //3.0 table view 的数据绑定，刷新，上拉刷新，下拉加载。全部集成在里面
    [self.tableView setTableViewData:self.viewModel.nearSignInArray];
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        
        [ws.viewModel getNearSignInArrayClearData:YES];

    } footerRefreshDatablock:^{
        [ws.viewModel getNearSignInArrayClearData:NO];
         [ws.tableView.mj_footer endRefreshing];
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*
 * setup navigation bar view
 */
-(void)loadCustomNavigationButton{
    [super loadCustomNavigationButton];
    self.title = @"签到列表";
}

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.noteLable = [UILabel new];
    [self.noteLable setText:@"您已完成80个景点，目前排名第12名"];
    [self.noteLable setTextColor:[UIColor whiteColor]];
    [self.noteLable setTextAlignment:NSTextAlignmentCenter];
    [self.noteLable setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
    [self.noteLable setFont:Font15];
    [self.view addSubview:self.noteLable];
    [self.noteLable mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.top.equalTo(ws.view);
        make.height.mas_equalTo(45);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_SignInListCell class] forCellReuseIdentifier:@"LBB_SignInListCell"];
    
    [self initViewModel];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AutoSize(30);
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UILabel* l = [UILabel new];
    [l setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    [l setTextAlignment:NSTextAlignmentCenter];
    [l setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
//    [l setText:@"您已完成80个景点，目前排名第12名"];
    [l setText:[NSString stringWithFormat:@"您已完成%ld个景点，目前排名第%d名",self.viewModel.signInNum,self.viewModel.rank]];

    [l setTextColor:[UIColor whiteColor]];
    [l setFont:Font15];

    return l;
    
};


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.nearSignInArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_SignInListCell" cacheByIndexPath:indexPath configuration:^(LBB_SignInListCell* cell){
        
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"LBB_SignInListCell";
    LBB_SignInListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_SignInListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_SignInListCell nil");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showSigninButton:YES];
    
    
   LBB_NearSignIn* obj = [self.viewModel.nearSignInArray objectAtIndex:indexPath.row];

    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:obj.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [cell.titleLabel setText:obj.allSpotsName];
    [cell.subTitleLabel setText:obj.signInTime];    
    return cell;
    
}

@end
