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
    self.baseViewType = eSquareTravel;
    self.lineView.backgroundColor = ColorLine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    self.dataSourceArray = [[LBB_SquareTravelModel alloc] getDataWithType:eMessageLike];
    [self initSegmentControll];
    [self initTableview];
}

- (void)initSegmentControll
{
    self.tableViewTopConstraint.constant = self.segmentBgViewHeightConstraint.constant;
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"关注",@"点赞",@"评论",@"收藏"]];
    segmentedControl.selectionIndicatorHeight = 3.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:15.0],
                                             NSForegroundColorAttributeName:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]};
    
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [segmentedControl setFrame:CGRectMake(0, 0, DeviceWidth, self.segmentBgViewHeightConstraint.constant)];
    
    [segmentedControl addTarget:self
                         action:@selector(segmentedControlChangedValue:)
               forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    [self.view bringSubviewToFront:self.lineView];
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

#pragma mark - segmentedControlChangedValue
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentControll
{
    NSInteger selectIndex = segmentControll.selectedSegmentIndex;
    switch (selectIndex) {
        case 0://关注
           self.dataSourceArray = [[LBB_SquareTravelModel alloc] getDataWithType:eMessageFollow];
            break;
        case 1: //点赞
           self.dataSourceArray = [[LBB_SquareTravelModel alloc] getDataWithType:eMessageLike];
            break;
        case 2: //评论
           self.dataSourceArray = [[LBB_SquareTravelModel alloc] getDataWithType:eMessageComment];
            break;
        case 3: //收藏
            self.dataSourceArray = [[LBB_SquareTravelModel alloc] getDataWithType:eMessageCollection];
            break;
            
        default:
            break;
    }
    
    [self.tableView reloadData];
}

@end
