//
//  LBB_ScenicDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailViewController.h"
#import "LBB_ScenicDetailPriceMsgCell.h"

@interface LBB_ScenicDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;

@end

@implementation LBB_ScenicDetailViewController

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
/*
 * setup Navigation UI
 */

-(void)loadCustomNavigationButton{
    WS(ws);
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
      [self.tableView registerClass:[LBB_ScenicDetailPriceMsgCell class] forCellReuseIdentifier:@"LBB_ScenicDetailPriceMsgCell"];
}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AutoSize(10);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    [v setBackgroundColor:[UIColor whiteColor]];
    return v;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"LBB_ScenicDetailPriceMsgCell";
    LBB_ScenicDetailPriceMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicDetailPriceMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicDetailPriceMsgCell nil");
    }
    [cell setModel:nil];
    return cell;

    return nil;
}

@end
