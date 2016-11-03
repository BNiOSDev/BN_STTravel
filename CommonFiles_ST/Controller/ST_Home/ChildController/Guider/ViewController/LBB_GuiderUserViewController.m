//
//  LBB_GuiderUserViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserViewController.h"

#import "LBB_GuiderUserHeaderCell.h"
#import "LBB_GuiderUserMsgCell.h"
#import "LBB_GuiderUserDeatilMsgCell.h"

@interface LBB_GuiderUserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* menuArray;
@property(nonatomic, assign)BOOL isOpen;

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
    
    
    self.menuArray = @[
                        @[@"导游_导游证号",@"导游证号",@"D-100-003256"],
                        @[@"导游_从业时间",@"从业时间",@"2012-09-09"],
                        @[@"导游_电话",@"联系电话",@"1856249542"],
                        @[@"导游_地址",@"地址",@"厦门湖里区"],
                        @[@"导游_简介",@"简介",@"厦门知名品牌导游第一名"],
                        ];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_GuiderUserHeaderCell class] forCellReuseIdentifier:@"LBB_GuiderUserHeaderCell"];
    [self.tableView registerClass:[LBB_GuiderUserMsgCell class] forCellReuseIdentifier:@"LBB_GuiderUserMsgCell"];
    [self.tableView registerClass:[LBB_GuiderUserDeatilMsgCell class] forCellReuseIdentifier:@"LBB_GuiderUserDeatilMsgCell"];

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
    
    if (section == 0) {
        return self.menuArray.count + 1;
    }
    
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
    
    WS(ws);
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"LBB_GuiderUserHeaderCell";
        LBB_GuiderUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_GuiderUserHeaderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_GuiderUserHeaderCell nil");
            
        }
        [cell setModel:nil];
        return cell;
    }
    else if (indexPath.row == self.menuArray.count){
        static NSString *cellIdentifier = @"LBB_GuiderUserDeatilMsgCell";
        LBB_GuiderUserDeatilMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_GuiderUserDeatilMsgCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_GuiderUserDeatilMsgCell nil");
        }
        
        NSInteger row = indexPath.row - 1;
        cell.detailString = @"作为一名学院派的导游，丰富的工作经验累积和人生体验，很赞。作为一名学院派的导游，丰富的工作经验累积和人生体验，很赞。";
        
        
        [cell.rightButton bk_whenTapped:^{
            
            ws.isOpen = !ws.isOpen;
            [ws.tableView reloadData];
            
        }];
        if (self.isOpen) {
            [cell.rightButton setImage:IMAGE(@"导游_上拉箭头") forState:UIControlStateNormal];
            [cell.detailLabel setText:cell.detailString];
            [cell.detailLabel setLineSpace:5];
        }
        else{
            [cell.rightButton setImage:IMAGE(@"导游_下拉箭头") forState:UIControlStateNormal];
            [cell.detailLabel setText:@""];
        }
        
        [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
        [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
        [cell.textField setText:[[self.menuArray objectAtIndex:row] objectAtIndex:2]];
        [cell setModel:nil];

        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_GuiderUserMsgCell";
        LBB_GuiderUserMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_GuiderUserMsgCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_GuiderUserMsgCell nil");
        }
        
        NSInteger row = indexPath.row - 1;
        [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
        [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
        [cell.textField setText:[[self.menuArray objectAtIndex:row] objectAtIndex:2]];
        
        return cell;
    }
    

  
}

#pragma 周边推荐
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserHeaderCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserHeaderCell* cell){
            
            [cell setModel:nil];
        }];
    }
    else if (indexPath.row == self.menuArray.count){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserDeatilMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserDeatilMsgCell* cell){
            NSInteger row = indexPath.row - 1;
            
            cell.detailString = @"作为一名学院派的导游，丰富的工作经验累积和人生体验，很赞。作为一名学院派的导游，丰富的工作经验累积和人生体验，很赞。";
            if (self.isOpen) {
                [cell.rightButton setImage:IMAGE(@"导游_上拉箭头") forState:UIControlStateNormal];
                [cell.detailLabel setText:cell.detailString];
                [cell.detailLabel setLineSpace:5];
            }
            else{
                [cell.rightButton setImage:IMAGE(@"导游_下拉箭头") forState:UIControlStateNormal];
                [cell.detailLabel setText:@""];
            }
            [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
            [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
            [cell.textField setText:[[self.menuArray objectAtIndex:row] objectAtIndex:2]];
            [cell setModel:nil];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserMsgCell* cell){
            NSInteger row = indexPath.row - 1;

            [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
            [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
            [cell.textField setText:[[self.menuArray objectAtIndex:row] objectAtIndex:2]];
            
        }];
    }

}

@end
