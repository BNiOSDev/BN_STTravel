//
//  LBB_PurchaseNotificationViewController.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PurchaseNotificationViewController.h"
#import "LBB_SquareNotificationViewCell.h"
#import "HMSegmentedControl.h"
#import "CommonFunc.h"

@interface LBB_PurchaseNotificationViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (weak,nonatomic) IBOutlet UIView *segmentBgView;

@end

@implementation LBB_PurchaseNotificationViewController

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

#pragma mark -  private 

- (void)buildControls
{
    [self initSegmentControll];
    [self setTableViewNib];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@{@"Image":@"19.pic.jpg",
                                                                     @"Title":@"优惠促销标题",
                                                                     @"Content":@"喜迎国庆,全场8折优惠（最新活动）喜迎国庆,全场8折优惠（最新活动）喜迎国庆,全场8折优惠（最新活动）喜迎国庆,全场8折优惠（最新活动）",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"Image":@"19.pic.jpg",
                                                                     @"Title":@"优惠促销标题",
                                                                     @"Content":@"点击查看您的最新客服会话记录",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"Image":@"19.pic.jpg",
                                                                     @"Title":@"优惠促销标题",
                                                                     @"Content":@"已发货，您2016-07-16购买黑蒜...",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"Image":@"19.pic.jpg",
                                                                     @"Title":@"优惠促销标题",
                                                                     @"Content":@"提现成功，您2016-07-12申请100...",
                                                                     @"Date":@"07-17"
                                                                     },
                                                                   @{@"Image":@"19.pic.jpg",
                                                                     @"Title":@"优惠促销标题",
                                                                     @"Content":@"您发布的游记XX被点赞了，快去看...",
                                                                     @"Date":@"07-17"
                                                                     }
                                                                   ]];
}

- (void)initSegmentControll
{
    self.segmentBgViewHeightConstraint.constant = 30.f;
    self.tableViewTopConstraint.constant = self.segmentBgViewHeightConstraint.constant;
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[NSLocalizedString(@"商城通知", nil),
                                                                                               NSLocalizedString(@"门票通知", nil)]];
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

- (void)setTableViewNib
{
    UINib *nib = [UINib nibWithNibName:@"LBB_SquareNotificationViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_SquareNotificationViewCell"];
}


#pragma mark - segmentedControlChangedValue
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentControll
{
    NSInteger selectIndex = segmentControll.selectedSegmentIndex;
    if (selectIndex == 1) {
        self.tableView.hidden = YES;//门票通知
    }else {
        self.tableView.hidden = NO; //商城通知
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   CGFloat height = 106.f;
   NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
    NSString *contentStr =  [cellDict objectForKey:@"Content"];
    CGSize conentSize = sizeOfString(contentStr, CGSizeMake(DeviceWidth - 70 - 60, 9999), Font15);
    if (conentSize.height > 40.f) {
        height += conentSize.height - 40.f;
    }
    return height;
    
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,DeviceWidth, 30.f)];
    timeLabel.textColor = ColorLightGray;
    timeLabel.font = Font12;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:section];
    timeLabel.text = [cellDict objectForKey:@"Date"];
    timeLabel.backgroundColor = [UIColor clearColor];
    
    return timeLabel;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_SquareNotificationViewCell";
    LBB_SquareNotificationViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath section]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_SquareNotificationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    [self configCell:cell Model:cellDict];
    
    return cell;
}

- (void)configCell:(LBB_SquareNotificationViewCell*)cell Model:(NSDictionary*)cellDict
{
    cell.iconImgView.image = IMAGE([cellDict objectForKey:@"Image"]);
    cell.titleLabel.text = [cellDict objectForKey:@"Title"];
    cell.contentLabel.text = [cellDict objectForKey:@"Content"];
    cell.dateLabel.text = [cellDict objectForKey:@"Date"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
