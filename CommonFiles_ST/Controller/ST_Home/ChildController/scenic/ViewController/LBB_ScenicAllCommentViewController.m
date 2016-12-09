//
//  LBB_ScenicAllCommentViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicAllCommentViewController.h"
#import "LBB_ScenicAllCommentCell.h"

@interface LBB_ScenicAllCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;


@end

@implementation LBB_ScenicAllCommentViewController

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
    [self.spotDetailModel getSpotAllRecommendsType:YES];
    [self.spotDetailModel.allCommentsRecord.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.spotDetailModel.allCommentsRecord];
    
    [self.tableView setHeaderRefreshDatablock:^{
    
        [ws.tableView.mj_header endRefreshing];
        
        [ws.spotDetailModel getSpotAllRecommendsType:YES];
        
    } footerRefreshDatablock:^{
        [ws.tableView.mj_footer endRefreshing];
        [ws.spotDetailModel getSpotAllRecommendsType:NO];

    }];

}

/*
 * setup Navigation UI
 */

-(void)loadCustomNavigationButton{
    
    self.title = @"全部评论";
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    [self.tableView registerClass:[LBB_ScenicAllCommentCell class] forCellReuseIdentifier:@"LBB_ScenicAllCommentCell."];
    [self initViewModel];
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



#pragma tableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.spotDetailModel.allCommentsRecord.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicAllCommentCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicAllCommentCell *cell) {
        [cell setCommentsRecord:ws.spotDetailModel.allCommentsRecord[indexPath.row]];

    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_ScenicAllCommentCell";
    LBB_ScenicAllCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicAllCommentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_ScenicAllCommentCell nil");
    }
    
    
    [cell setCommentsRecord:self.spotDetailModel.allCommentsRecord[indexPath.row]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}
@end
