//
//  MineViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/8.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "MineViewController.h"
#import "LBB_MyUserHeaderView.h"
#import "PersonalCenterViewController.h"
#import "ST_TabBarController.h"
#import "ST_TabBarController.h"
#import "MineBaseViewController.h"
#import "LBB_MineViewDataController.h"
#import "LBB_ImagePickerViewController.h"
#import "LBB_DownloadedViewController.h"
#import "LBB_RouteViewController.h"

#define UserHeadViewHegiht (245.f/414.f)
#define MineViewCellHeight  60.f

@interface MineViewController ()<
LBB_MyUserHeaderViewDelegate,
LBB_MySectionHeadViewDelegate
>

@property (strong, nonatomic) IBOutlet LBB_MineViewDataController *dataController;
@property (strong,nonatomic) LBB_ImagePickerViewController *imagePicker;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCustomNavigationButton];
    [self.dataController initDataSource];
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
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

- (void)didClickConverPicture:(id)userInfo
{
    NSString *cameraStr = NSLocalizedString(@"相机", nil);
    NSString *albumStr = NSLocalizedString(@"相册", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更换封面图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *camraAction = [UIAlertAction actionWithTitle:cameraStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerView:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:albumStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self showImagePickerView:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }];
    
    // Add the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    // Add the actions.
    [alertController addAction:camraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showImagePickerView:(UIImagePickerControllerSourceType)sourceType
{
    self.imagePicker = nil;
    self.imagePicker = [[LBB_ImagePickerViewController alloc] initPickerWithType:sourceType Parent:self];
    
    __weak typeof (self) weakSelf = self;
    [self.imagePicker showPicker:^(UIImage *resultImage){
        [weakSelf.dataController replaceUserHeadImage:resultImage];
    }];
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
        {
            LBB_DownloadedViewController *vc = [[LBB_DownloadedViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case eRoute://定制线路
        {
            LBB_RouteViewController *vc = [[LBB_RouteViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
