//
//  LBB_GuiderUserViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserViewController.h"

#import "LBB_GuiderUserHeaderCell.h"

@interface LBB_GuiderUserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;

@end

@implementation LBB_GuiderUserViewController

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
    
    
}


/*
 *  setup UI
 */
-(void)buildControls{
    
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_GuiderUserHeaderCell class] forCellReuseIdentifier:@"LBB_GuiderUserHeaderCell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.equalTo(ws.view);
        make.top.equalTo(ws.view.mas_top);
        make.bottom.equalTo(ws.view);
    }];
    
    
    
}



#pragma tableView Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self tableView:tableView headerSectionCellForRowAtIndexPath:indexPath];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self tableView:tableView heightForHeaderSectionRowAtIndexPath:indexPath];
}


#pragma tableViewCell getter
-(UITableViewCell*)tableView:(UITableView *)tableView headerSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_GuiderUserHeaderCell";
    LBB_GuiderUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderUserHeaderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderUserHeaderCell nil");
        
    }
    [cell setModel:nil];
    return cell;
  
}

#pragma 周边推荐
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserHeaderCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserHeaderCell* cell){
        
        [cell setModel:nil];
    }];
}

@end
