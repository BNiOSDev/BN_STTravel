//
//  LBB_SquareTravelViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelViewController.h"
#import "LBB_SquareTravelViewCell.h"
#import "LBB_SquareTravelModel.h"
#import "HMSegmentedControl.h"

@interface LBB_SquareTravelViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (weak,nonatomic) IBOutlet UIView *segmentBgView;

@property (strong,nonatomic) NSArray *dataSourceArray;

@end

@implementation LBB_SquareTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lineView.backgroundColor = ColorLine;
    self.tableViewTopConstraint.constant = 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    self.dataSourceArray = [[LBB_SquareTravelModel alloc] getDataWithType:self.messgeType];
    [self initTableview];
}

- (void)initTableview
{
    UINib *nib = [UINib nibWithNibName:@"LBB_SquareTravelViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_SquareTravelViewCell"];
}


#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_SquareTravelViewCell"
                                                 configuration:^(LBB_SquareTravelViewCell *cell) {
                                                     LBB_SquareTravelModelDetail *cellInfo = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [cell setCellInfo:cellInfo];
                                                 }];
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_SquareTravelViewCell";
    LBB_SquareTravelViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_SquareTravelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView =  nil;
    LBB_SquareTravelModelDetail *cellInfo = [self.dataSourceArray objectAtIndex:[indexPath row]];
    [cell setCellInfo:cellInfo];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
