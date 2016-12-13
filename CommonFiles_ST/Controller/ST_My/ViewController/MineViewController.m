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
#import "LBB_MyTravelViewController.h"
#import "LBB_MyPhotoViewController.h"
#import "LBB_MyVideoViewController.h"
#import "LBB_MyFollowViewController.h"
#import "LBB_PoohMyFavoriteViewController.h"
#import "LBB_TicketModuleViewController.h"
#import "LBB_TravelGuideViewController.h"
#import "LBB_MyFavoriteSquareViewController.h"
#import "LBB_LoginViewController.h"
#import "LBB_MyChatViewController.h"
#import "LBB_OrderModuleViewController.h"

#define UserHeadViewHegiht (245.f/414.f)
#define MineViewCellHeight  60.f

@interface MineViewController ()<
LBB_MyUserHeaderViewDelegate,
LBB_MySectionHeadViewDelegate
>

@property (strong, nonatomic) IBOutlet LBB_MineViewDataController *dataController;
@property (strong,nonatomic) LBB_ImagePickerViewController *imagePicker;
@property (nonatomic,assign) BOOL isSeletePhoto;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCustomNavigationButton];
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
    if (!self.isSeletePhoto) {
        [self.dataController initDataSource];
    }
    self.isSeletePhoto = NO;
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

- (void)didClickPersonalCenter:(id)userInfo IsLogin:(BOOL)isLogin
{
    if(!isLogin){
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
        LBB_LoginViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_LoginViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self performSegueWithIdentifier:@"PersonalCenterViewController" sender:nil];
    }
}

- (void)didClickConverPicture:(id)userInfo IsLogin:(BOOL)isLogin
{
    if (!isLogin) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
        LBB_LoginViewController* vc = [main instantiateViewControllerWithIdentifier:@"LBB_LoginViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
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
}

- (void)showImagePickerView:(UIImagePickerControllerSourceType)sourceType
{
    self.imagePicker = nil;
    self.imagePicker = [[LBB_ImagePickerViewController alloc] initPickerWithType:sourceType Parent:self];
    
    __weak typeof (self) weakSelf = self;
    [self.imagePicker showPicker:^(UIImage *resultImage){
        weakSelf.isSeletePhoto = YES;
        [weakSelf.dataController replaceUserHeadImage:resultImage];
    }];
}
#pragma mark - colectionView delegate

- (void)didClickDetailActionDelegate:(NSInteger)viewType
{
    switch (viewType) {
 /* 我的订单 */
        case eOrder: //查看全部-订单
        {
            LBB_OrderModuleViewController *vc = [[LBB_OrderModuleViewController alloc] init];
            vc.baseViewType = eOrderType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case eOrder_WaitPay: //我的订单_待付款
        {
            LBB_OrderModuleViewController *vc = [[LBB_OrderModuleViewController alloc] init];
            vc.baseViewType = eOrderType_WaitPay;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case eOrder_WaitGetTicket: //我的订单_待收货
        {
            LBB_OrderModuleViewController *vc = [[LBB_OrderModuleViewController alloc] init];
            vc.baseViewType = eOrderType_WaitGetTicket;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case eOrder_WaitComment: //我的订单_待评价
        {
            LBB_OrderModuleViewController *vc = [[LBB_OrderModuleViewController alloc] init];
            vc.baseViewType = eOrderType_WaitComment;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case eOrder_AfterAales: //我的订单_售后
        {
            LBB_OrderModuleViewController *vc = [[LBB_OrderModuleViewController alloc] init];
            vc.baseViewType = eOrderType_AfterAales;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
 /* 我的门票 */
        case eTickets://查看全部-门票
        case eTicket_WaitPay: //我的门票_待付款
        case eTicket_WaitGetTicket: //我的门票_待取票
        case eTicket_WaitComment: //我的门票_待评价
        case eTicket_Refund: //我的门票_退款
        {
            LBB_TicketModuleViewController *ticketVC = [[LBB_TicketModuleViewController alloc] init];
            ticketVC.baseViewType = viewType;
            [self.navigationController pushViewController:ticketVC animated:YES];
        } 
            break;
      
/* 我的广场 */
        case  ePhoto: //照片
        {
            LBB_MyPhotoViewController *photoVC = [[LBB_MyPhotoViewController alloc] init];
            photoVC.squareType = MySquarePhotoView;
            [self.navigationController pushViewController:photoVC animated:YES];
        }
            break;
        case   eVideo://视频
        {
            LBB_MyVideoViewController *videoVC = [[LBB_MyVideoViewController alloc] init];
            videoVC.squareType = MySquareVideoView;
            [self.navigationController pushViewController:videoVC animated:YES];
        }
            break;
        case  eTravels://我的游记
        {
            LBB_MyTravelViewController *myTravel = [[LBB_MyTravelViewController alloc] init];
            myTravel.travelviewType = MyTravelsViewFravorite;
            [self.navigationController pushViewController:myTravel animated:YES];
        }
           break;
        case  eRecentChat://聊天
        {
            LBB_MyChatViewController *chatVC = [[LBB_MyChatViewController alloc] init];
            chatVC.baseViewType = eRecentChat;
            [self.navigationController pushViewController:chatVC animated:YES];
        }
            break;
/* 我的收藏 */
        case eSquare://广场
        {
            LBB_MyFavoriteSquareViewController *favoriteSquare = [[LBB_MyFavoriteSquareViewController alloc] init];
            [self.navigationController pushViewController:favoriteSquare animated:YES];
        }
            break;
        case eScenicSpot://景点
        {
            LBB_PoohMyFavoriteViewController *favoriteVC = [[LBB_PoohMyFavoriteViewController alloc] init];
            favoriteVC.favoriteType = LBBPoohSegmCtrlScenicType;
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }
            break;
        case eFood://美食
        {
            LBB_PoohMyFavoriteViewController *favoriteVC = [[LBB_PoohMyFavoriteViewController alloc] init];
            favoriteVC.favoriteType = LBBPoohSegmCtrlFoodsType;
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }
            break;
        case eHalls://民宿
        {
            LBB_PoohMyFavoriteViewController *favoriteVC = [[LBB_PoohMyFavoriteViewController alloc] init];
            favoriteVC.favoriteType = LBBPoohSegmCtrlHostelType;
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }
            break;
        case eGoods://商品
            
            break;
        case eFlashSale://限时抢购
            
            break;
        case eHandSpecial://伴手礼专题
            
            break;
        case eTravelGuide://攻略
        {
            LBB_TravelGuideViewController *travelVC = [[LBB_TravelGuideViewController alloc] init];
            travelVC.travelviewType =  MyTravelsGuideViewFravorite;
            [self.navigationController pushViewController:travelVC animated:YES];
        }
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
        case eMineFollow://关注
        {
            LBB_MyFollowViewController *followVC = [[LBB_MyFollowViewController alloc] init];
            followVC.baseViewType = eMineFollow;
            [self.navigationController pushViewController:followVC animated:YES];
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
