//
//  CardViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/9.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "CardViewController.h"
#import "CardViewCell.h"
#import "CardDetailViewController.h"

@interface CardViewController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.baseViewType =  eCard;
     [self initData];
     [self loadRightBarItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)loadRightBarItem {
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ST_TabImage1"]
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(addCardAction:)];
    
    
    rightBarButton.tintColor = [UIColor colorWithRed:0.0 green:0.1176 blue:0.4549 alpha:1.0];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)initData
{
    UINib *nib = [UINib nibWithNibName:@"CardViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CardViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"CardName": NSLocalizedString(@"中国建设银行",nil),
                                                                     @"CardNum" : @"储蓄卡**** **** **** 1234"},
                                                                    @{@"CardName": NSLocalizedString(@"中国建设银行",nil),
                                                                      @"CardNum" : @"储蓄卡**** **** **** 1234"},
                                                                     @{@"CardName": NSLocalizedString(@"中国建设银行",nil),
                                                                       @"CardNum" : @"储蓄卡**** **** **** 1234"},
                                                                     @{@"CardName": NSLocalizedString(@"中国建设银行",nil),
                                                                       @"CardNum" : @"储蓄卡**** **** **** 1234"},
                                                                     @{@"CardName": NSLocalizedString(@"中国建设银行",nil),
                                                                       @"CardNum" : @"储蓄卡**** **** **** 1234"},
                                                                     @{@"CardName": NSLocalizedString(@"中国建设银行",nil),
                                                                       @"CardNum" : @"储蓄卡**** **** **** 1234"}
                                                                   ]];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CardViewCell";
    CardViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CardViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
     
    cell.cardNameLabel.text = [cellDict objectForKey:@"CardName"];
    cell.cardNumLabel.text = [cellDict objectForKey:@"CardNum"];
    cell.accessoryView =  nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    CardDetailViewController* vc = [main instantiateViewControllerWithIdentifier:@"CardDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UI Action

- (IBAction)addCardAction:(id)sender {
     [self performSegueWithIdentifier:@"AddCardViewController" sender:nil];
}

@end
