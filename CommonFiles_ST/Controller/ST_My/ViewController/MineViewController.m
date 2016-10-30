//
//  MineViewController.m
//  LUBABA
//
//  Created by Dianar on 16/10/8.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "MineViewController.h"
#import "LBB_MyUserHeaderView.h"
#import "PersonalCenterViewController.h"
#import "ST_TabBarController.h"
#import "ST_TabBarController.h"
#import "MineBaseViewController.h"
#import "LBB_MineViewDataController.h"

#define UserHeadViewHegiht (245.f/414.f)
#define MineViewCellHeight  60.f

@interface MineViewController ()<
LBB_MyUserHeaderViewDelegate,
LBB_MineViewDataControllerDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceArray;
@property (strong, nonatomic) IBOutlet LBB_MineViewDataController *dataController;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self loadCustomNavigationButton];
    [self.dataController initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   [self setNavigationBarHidden:YES];
}
    
- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];
}
    
#pragma mark - private
- (void)buildControls
{
    self.dataController.cellDelegate = self;
    self.dataController.userHeaderDelegate = self;
}

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
  
    
#pragma mark - headeView delegate
- (void)didClickSetting:(id)userInfo
{
    [self performSegueWithIdentifier:@"SettingViewController" sender:nil]; 
}

- (void)didClickMessage:(id)userInfo
{
     [self performSegueWithIdentifier:@"LBB_MessageCenterViewController" sender:nil];
}

- (void)didClickPersonalCenter:(id)userInfo
{
    [self performSegueWithIdentifier:@"PersonalCenterViewController" sender:nil];
}

#pragma mark - colectionView delegate

- (void)didClickDetailActionDelegate:(NSInteger)viewType
{
    switch (viewType) {
 /* 我的订单 */
        case eOrder: //查看全部-订单
            break;
        case eOrder_WaitPay: //我的订单_待付款
            
            break;
        case eOrder_WaitGetTicket: //我的订单_待取票
            
            break;
        case eOrder_WaitComment: //我的订单_待评价
            
            break;
 /* 我的门票 */
        case eTickets://查看全部-门票
        case eTicket_WaitPay: //我的门票_待付款
        case eTicket_WaitGetTicket: //我的门票_待取票
        case eTicket_WaitComment: //我的门票_待评价
        case eTicket_Refund: //我的门票_退款
             [self performSegueWithIdentifier:@"TicketViewController" sender:[NSNumber numberWithInteger:viewType]];
            break;
      
/* 我的广场 */
        case  ePhoto: //照片
            
            break;
        case   eVideo://视频
            
            break;
        case  eTravels://我的游记
            
           break;
        case  eLove://关注
            
            break;
/* 我的收藏 */
        case eSquare://广场
            
            break;
        case eScenicSpot://景点
            
            break;
        case eFood://美食
            
            break;
        case eHalls://民宿
            
            break;
        case eGoods://商品
            
            break;
        case eFlashSale://限时抢购
            
            break;
        case eHandSpecial://伴手礼专题
            
            break;
        case eTravelGuide://攻略
            
            break;
/* 我的积分 */
        case ePoints://积分
             [self performSegueWithIdentifier:@"PointsViewController" sender:[NSNumber numberWithInteger:viewType]];
            break;
        case eDownload://我的下载
           
            break;
        case eRoute://定制线路
            
            break;
        case eSetting: //我的设置
             [self performSegueWithIdentifier:@"SettingViewController" sender:[NSNumber numberWithInteger:viewType]];
            break;
            
        default:
            break;
    }
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
