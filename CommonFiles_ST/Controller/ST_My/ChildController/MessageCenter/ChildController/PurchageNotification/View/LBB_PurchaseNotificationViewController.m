//
//  LBB_PurchaseNotificationViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PurchaseNotificationViewController.h"
#import "UIImageView+WebCache.h"
#import "LBB_SquareNotificationViewCell.h"
#import "HMSegmentedControl.h"
#import "CommonFunc.h"
#import "LBB_PurchaseModel.h"

@interface LBB_PurchaseNotificationViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray; 
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (nonatomic,strong) LBB_PurchaseDataModel *dataModel;

@end

@implementation LBB_PurchaseNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorBackground;
    self.tableView.backgroundColor = ColorBackground;
    self.tableViewTopConstraint.constant = 0.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  private 

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_SquareNotificationViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_SquareNotificationViewCell"];
    
    if (!self.dataModel) {
        self.dataModel = [[LBB_PurchaseDataModel alloc] init];
    }
    self.dataSourceArray = [self.dataModel getData];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_SquareNotificationViewCell"
                                                 configuration:^(LBB_SquareNotificationViewCell *cell) {
                                                     LBB_PurchaseModel *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
                                                     [self configCell:cell Model:cellDict];
                                                 }];
    return height;
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,DeviceWidth, 30.f)];
    timeLabel.textColor = ColorLightGray;
    timeLabel.font = Font12;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    LBB_PurchaseModel *cellDict = [self.dataSourceArray objectAtIndex:section];
    timeLabel.text = cellDict.dateStr;
    timeLabel.backgroundColor = [UIColor clearColor];
    
    return timeLabel;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_SquareNotificationViewCell";
    LBB_SquareNotificationViewCell *cell = nil;
    
    LBB_PurchaseModel *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_SquareNotificationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    [self configCell:cell Model:cellDict];
    
    return cell;
}

- (void)configCell:(LBB_SquareNotificationViewCell*)cell Model:(LBB_PurchaseModel*)cellDict
{
   [cell.iconImgView  sd_setImageWithURL:[NSURL URLWithString:cellDict.imageURL] placeholderImage:nil];;
    cell.titleLabel.text = cellDict.title;
    cell.contentLabel.text = cellDict.content;
    cell.dateLabel.text = cellDict.dateStr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
