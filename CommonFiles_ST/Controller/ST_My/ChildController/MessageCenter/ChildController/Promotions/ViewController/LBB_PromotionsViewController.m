//
//  LBB_PromotionsViewController.m
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PromotionsViewController.h"
#import "LBB_PromotionsViewCell.h"


@interface LBB_PromotionsViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;

@end

@implementation LBB_PromotionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UINib *nib = [UINib nibWithNibName:@"LBB_PromotionsViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"LBB_PromotionsViewCell"];
    
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[@{@"Image":@"19.pic.jpg",
                                                                     @"Title":@"优惠促销标题",
                                                                     @"Content":@"喜迎国庆,全场8折优惠（最新活动）",
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
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_PromotionsViewCell"
                                                 configuration:^(LBB_PromotionsViewCell *cell) {
                                                     NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
                                                     [self configCell:cell Model:cellDict];
                                                 }];
    return height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LBB_PromotionsViewCell";
    LBB_PromotionsViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[LBB_PromotionsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
    [self configCell:cell Model:cellDict];
    
    return cell;
}

- (void)configCell:(LBB_PromotionsViewCell*)cell Model:(NSDictionary*)cellDict
{
    cell.iconImgView.image = [cellDict objectForKey:@"Image"];
    cell.titleLabel.text = [cellDict objectForKey:@"Title"];
    cell.contentLabel.text = [cellDict objectForKey:@"Content"];
    cell.stateLabel.text = [cellDict objectForKey:@"State"];//活动状态
    cell.dateLabel.text = [cellDict objectForKey:@"Date"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
