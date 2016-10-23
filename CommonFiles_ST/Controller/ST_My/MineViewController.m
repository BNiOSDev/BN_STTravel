//
//  MineViewController.m
//  LUBABA
//
//  Created by Dianar on 16/10/8.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineViewCell.h"
#import "PersonalCenterViewController.h"
#import "ST_TabBarController.h"
#import "ST_TabBarController.h"
#import "MineBaseViewController.h"

#define UserHeadViewHegiht (245.f/414.f)
#define MineViewCellHeight  60.f

@interface MineViewController ()
<UITableViewDelegate,
UITableViewDataSource,
MineHeaderViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (strong,nonatomic) MineHeaderView *userHeadView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self loadCustomNavigationButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   [self setNavigationBarHidden:YES];
   ST_TabBarController *parentVC = (ST_TabBarController*)self.navigationController.parentViewController;
//    [parentVC showCenterCamereBtn:YES];
}
    
- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}
    
#pragma mark - private
- (void)initData
{
    UINib *nib = [UINib nibWithNibName:@"MineViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MineViewCell"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                  @{@"Title": NSLocalizedString(@"我的钱包",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"WalletViewController"},
                                                                  @{@"Title": NSLocalizedString(@"我的广场",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"publicSquare"},
                                                                  @{@"Title": NSLocalizedString(@"我的门票",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"TicketViewController",
                                                                    @"ViewType" : [NSNumber numberWithInt:eTickets]},
                                                                  @{@"Title": NSLocalizedString(@"我的订单",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"TicketViewController",
                                                                    @"ViewType" : [NSNumber numberWithInt:eOrder]},
                                                                  @{@"Title": NSLocalizedString(@"我的收藏",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"LBB_FavoriteViewController",
                                                                    @"ViewType" : [NSNumber numberWithInt:eFavorite]},
                                                                  @{@"Title": NSLocalizedString(@"我的游记",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"LBB_FavoriteViewController",
                                                                    @"ViewType" : [NSNumber numberWithInt:eTravels]},
                                                                  @{@"Title": NSLocalizedString(@"我的下载",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"LBB_FavoriteViewController",
                                                                    @"ViewType" : [NSNumber numberWithInt:eDownload]},
                                                                  @{@"Title": NSLocalizedString(@"我的拼团",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"LBB_FightGroupViewController"},
                                                                  @{@"Title": NSLocalizedString(@"我的线路",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"LBB_FavoriteViewController",
                                                                    @"ViewType" : [NSNumber numberWithInt:eRoute]},
                                                                  @{@"Title": NSLocalizedString(@"我的设置",nil),
                                                                    @"Image" : @"19.pic.jpg",
                                                                    @"Action":@"SettingViewController"}
                                                                  ]];
 
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MineViewCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DeviceWidth * UserHeadViewHegiht;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!self.userHeadView) {
        UINib *nib = [UINib nibWithNibName:@"MineHeaderView" bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        self.userHeadView = [array lastObject];
        self.userHeadView.delegate = self;
        self.userHeadView.frame = CGRectMake(0, 0, DeviceWidth, DeviceWidth * UserHeadViewHegiht);
    }
    return self.userHeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MineViewCell";
    MineViewCell *cell = nil;
    
    NSDictionary *cellDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MineViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectedBackgroundView.backgroundColor = RGB(240, 240, 240);
  
    cell.label.text = [cellDict objectForKey:@"Title"];
    cell.imgView.image = [UIImage imageNamed:[cellDict objectForKey:@"Image"]];
    cell.accessoryView =  nil;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellInfoDict = [self.dataSourceArray objectAtIndex:[indexPath row]];
    NSString *pushVCIdentifier = [cellInfoDict objectForKey:@"Action"];
    if (!([pushVCIdentifier isEqualToString:@"publicSquare"])) {
        [self performSegueWithIdentifier:pushVCIdentifier
                                  sender:[cellInfoDict objectForKey:@"ViewType"]];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
    
    
#pragma mark - headeView delegate
- (void)didClickSetting:(id)userInfo
{
    [self performSegueWithIdentifier:@"SettingViewController" sender:nil]; 
}

- (void)didClickMessage:(id)userInfo
{
    
}

- (void)didClickPersonalCenter:(id)userInfo
{
    [self performSegueWithIdentifier:@"PersonalCenterViewController" sender:nil];
}

#pragma mark -  perform segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *dstController =   segue.destinationViewController;
    if ([dstController isKindOfClass:NSClassFromString(@"MineBaseViewController")]) {
         MineBaseViewController *baseVC = (MineBaseViewController*)dstController;
        if (sender && [sender isKindOfClass:[NSNumber class]]) {
            baseVC.baseViewType = [(NSNumber *)sender intValue];
        }
    }
}

@end
