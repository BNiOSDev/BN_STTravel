//
//  LBB_NoticeViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NoticeViewController.h"
#import "LBB_NoticeViewCell.h"
#import "LBB_NoticeModel.h"
#import "LBB_WebViewController.h"

@interface LBB_NoticeViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *dataSourceArray;
@property (strong,nonatomic) LBB_NoticeModel *noticeModel;

@end

@implementation LBB_NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorBackground;
    self.tableView.backgroundColor = ColorBackground;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_NoticeViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_NoticeViewCell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    if (!self.noticeModel) {
        self.noticeModel = [[LBB_NoticeModel alloc] init];
    }
    self.dataSourceArray = [self.noticeModel getData];
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_NoticeViewCell"
                                                 configuration:^(LBB_NoticeViewCell *cell) {
                                                     LBB_NoticeDetailModel *detailModel = [self.dataSourceArray objectAtIndex:[indexPath section]];
                                                     [self configCell:cell Model:detailModel];
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
    LBB_NoticeDetailModel *detailModel = [self.dataSourceArray objectAtIndex:section];
    timeLabel.text = detailModel.detailDateStr;
    timeLabel.backgroundColor = [UIColor clearColor];
    
    return timeLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_NoticeViewCell";
    LBB_NoticeViewCell *cell = nil;
    
    LBB_NoticeDetailModel *detailModel = [self.dataSourceArray objectAtIndex:[indexPath section]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_NoticeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    [self configCell:cell Model:detailModel];
    
    return cell;
}

- (void)configCell:(LBB_NoticeViewCell*)cell Model:(LBB_NoticeDetailModel*)detailModel
{
    cell.titleLabel.text = detailModel.title;
    cell.dateLabel.text = detailModel.dateStr;
    cell.contentLabel.text = detailModel.content;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LBB_NoticeDetailModel *detailModel = [self.dataSourceArray objectAtIndex:[indexPath section]];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    LBB_WebViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_WebViewController"];
    vc.baseViewType = eNoticeDetail;
    vc.webViewURL = detailModel.detailURL;
    [self.navigationController pushViewController:vc animated:YES];
 
}



@end
