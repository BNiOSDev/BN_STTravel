//
//  LBB_OrderPayWayViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderPayWayViewController.h"
#import "LBB_OrderPayWayCell.h"
#import "LBB_OrderTextCell.h"
@interface LBB_OrderPayWayViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *dataSourceArray;

@end

@implementation LBB_OrderPayWayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)loadCustomNavigationButton{
    [super loadCustomNavigationButton];
    self.title = @"确认支付";
}

-(void)buildControls{
    
    WS(ws);
    
    
    self.dataSourceArray = @[
                            @[@"确认支付_微信支付",@"微信支付",@"微信安全支付"],
                             @[@"确认支付_银联支付",@"支付宝支付",@"支付宝安全支付"],
                             @[@"确认支付_支付宝支付",@"银联支付",@"银联快捷支付"]
                             ];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.tableView registerClass:[LBB_OrderPayWayCell class] forCellReuseIdentifier:@"LBB_OrderPayWayCell"];
    [self.tableView registerClass:[LBB_OrderTextCell class] forCellReuseIdentifier:@"LBB_OrderTextCell"];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
    
    
}


#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSourceArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderTextCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderTextCell *cell) {
            [cell.textLabel1 setText:@"订单总价"];
            cell.textLabel2.hidden = YES;
            [cell.textLabel3 setText:@"$800.00"];
            [cell.textLabel3 setFont:Font16];
            [cell.textLabel3 setTextColor:[UIColor redColor]];
        }];
    }
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderPayWayCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderPayWayCell *cell) {
        NSString* img = [[self.dataSourceArray objectAtIndex:indexPath.row] objectAtIndex:0];
        NSString* title = [[self.dataSourceArray objectAtIndex:indexPath.row] objectAtIndex:1];
        NSString* subTitle = [[self.dataSourceArray objectAtIndex:indexPath.row] objectAtIndex:2];
        [cell.portraitImageView setImage:IMAGE(img)];
        [cell.titleLabel setText:title];
        [cell.subTitleLabel setText:subTitle];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return AutoSize(15);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    UIView* v = [UIView new];
    [v setBackgroundColor:ColorBackground];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    return v;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"LBB_OrderTextCell";
        LBB_OrderTextCell *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LBB_OrderTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell.textLabel1 setText:@"订单总价"];
        cell.textLabel2.hidden = YES;
        [cell.textLabel3 setText:@"$800.00"];
        [cell.textLabel3 setFont:Font16];
        [cell.textLabel3 setTextColor:[UIColor redColor]];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"LBB_OrderPayWayCell";
        LBB_OrderPayWayCell *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LBB_OrderPayWayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSString* img = [[self.dataSourceArray objectAtIndex:indexPath.row] objectAtIndex:0];
        NSString* title = [[self.dataSourceArray objectAtIndex:indexPath.row] objectAtIndex:1];
        NSString* subTitle = [[self.dataSourceArray objectAtIndex:indexPath.row] objectAtIndex:2];
        [cell.portraitImageView setImage:IMAGE(img)];
        [cell.titleLabel setText:title];
        [cell.subTitleLabel setText:subTitle];
        return cell;
    }
}

@end
