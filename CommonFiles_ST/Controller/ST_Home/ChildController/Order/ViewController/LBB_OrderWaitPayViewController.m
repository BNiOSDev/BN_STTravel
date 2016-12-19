//
//  LBB_OrderWaitPayViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderWaitPayViewController.h"
#import "LBB_OrderTextCell.h"
#import "LBB_OrderTicketCell.h"
#import "LBB_OrderTicketPriceCell.h"
#import "LBB_OrderContactCustomerServiceCell.h"
#import "LBB_OrderTicketConfirmCell.h"
#import "LBB_OrderPayWayViewController.h"
#import "LBB_OrderQrCodeCell.h"

@interface LBB_OrderWaitPayViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;


@end

@implementation LBB_OrderWaitPayViewController

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
    self.title = @"门票详情";
}

-(void)buildControls{

    WS(ws);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.tableView registerClass:[LBB_OrderTextCell class] forCellReuseIdentifier:@"LBB_OrderTextCell"];
    [self.tableView registerClass:[LBB_OrderTicketCell class] forCellReuseIdentifier:@"LBB_OrderTicketCell"];
    [self.tableView registerClass:[LBB_OrderTicketPriceCell class] forCellReuseIdentifier:@"LBB_OrderTicketPriceCell"];
    [self.tableView registerClass:[LBB_OrderContactCustomerServiceCell class] forCellReuseIdentifier:@"LBB_OrderContactCustomerServiceCell"];
    [self.tableView registerClass:[LBB_OrderTicketConfirmCell class] forCellReuseIdentifier:@"LBB_OrderTicketConfirmCell"];
    [self.tableView registerClass:[LBB_OrderQrCodeCell class] forCellReuseIdentifier:@"LBB_OrderQrCodeCell"];


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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 7;
            break;
        case 1:
            return 1;
            break;
        case 2:
            if (self.ticketStatus == LBBPoohTicketStatusWaitCollect) {
                return 2;
            }
            return 1;
            break;
            
        default:
            break;
    }
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            case 1:
            case 2:
                return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderTextCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderTextCell *cell) {
                    
                    [cell setModel:nil];
                }];
                
                break;
            case 3:
            case 4:
                return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderTicketCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderTicketCell *cell) {
                    [cell setModel:nil];
                }];
                break;
            case 5:

                return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderTicketPriceCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderTicketPriceCell *cell) {
                    [cell setModel:nil];
                }];
                break;
            case 6:
                return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderTextCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderTextCell *cell) {
                    
                    [cell.textLabel1 setText:@"订单总价"];
                    cell.textLabel2.hidden = YES;
                    [cell.textLabel3 setText:@"$800.00"];
                    [cell.textLabel3 setFont:Font16];
                }];
                break;
                
            default:
                return 0;
                break;
        }
    }
    else if (indexPath.section == 1){
        
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderContactCustomerServiceCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderContactCustomerServiceCell *cell) {
            

        }];
    }
    
    else{
        
        if ((self.ticketStatus == LBBPoohTicketStatusWaitCollect)
            &&(indexPath.row == 0)) {
            return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderQrCodeCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderQrCodeCell *cell) {
                
            }];
        }
        else{
            return [tableView fd_heightForCellWithIdentifier:@"LBB_OrderTicketConfirmCell" cacheByIndexPath:indexPath configuration:^(LBB_OrderTicketConfirmCell *cell) {
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.001f;
    }
    
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
        
        if (indexPath.row < 3) {
            static NSString *CellIdentifier = @"LBB_OrderTextCell";
            LBB_OrderTextCell *cell = nil;
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[LBB_OrderTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.ticketStatus = self.ticketStatus;
            cell.indexPath = indexPath;
            [cell setModel:nil];
            return cell;
        }
        else if(indexPath.row < 5){
            static NSString *CellIdentifier = @"LBB_OrderTicketCell";
            LBB_OrderTicketCell *cell = nil;
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[LBB_OrderTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell setModel:nil];
            return cell;
        }
        else if(indexPath.row < 6){
        
            static NSString *CellIdentifier = @"LBB_OrderTicketPriceCell";
            LBB_OrderTicketPriceCell *cell = nil;
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[LBB_OrderTicketPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell setModel:nil];
            return cell;
        }
        else{
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
    }
    else if(indexPath.section == 1){
        
        static NSString *CellIdentifier = @"LBB_OrderContactCustomerServiceCell";
        LBB_OrderContactCustomerServiceCell *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LBB_OrderContactCustomerServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        return cell;
        
    }
    
    if ((self.ticketStatus == LBBPoohTicketStatusWaitCollect)
        &&(indexPath.row == 0)) {
        static NSString *CellIdentifier = @"LBB_OrderQrCodeCell";
        LBB_OrderQrCodeCell *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LBB_OrderQrCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setModel:nil];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"LBB_OrderTicketConfirmCell";
        LBB_OrderTicketConfirmCell *cell = nil;
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[LBB_OrderTicketConfirmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.ticketStatus = self.ticketStatus;
        [cell setModel:nil];
        return cell;
    }
    

}

@end
