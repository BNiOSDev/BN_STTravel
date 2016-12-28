//
//  LBB_PoohCycleTransManager.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/24.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohCycleTransManager.h"
#import "LBB_ScenicMainViewController.h"
#import "LBB_HostelMainViewController.h"
#import "LBB_FoodsMainViewController.h"
#import "LBB_ScenicDetailSubjectViewController.h"

#import "LBB_ScenicDetailViewController.h"
#import <BN_ShopGoodDetailViewController.h>
#import "BN_ShopSorterViewController.h"
#import <BN_ShopSpecialSubjectViewController.h>

#import "LBB_DiscoveryMainViewController.h"
#import "LBB_DiscoveryDetailViewController.h"
#import "LBBHostDetailViewController.h"
#import "LBB_VideoDetailViewController.h"
#import "LBB_TravelDetailViewController.h"
#import "LBB_SquareSnsFollowViewController.h"
#import "LBB_FootPointDetailController.h"
@implementation LBB_PoohCycleTransManager


+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

-(void)transmission:(BN_HomeAdvertisement*)model
viewController:(UIViewController*)viewController{
    switch (model.classes) {
            case 1://外部链接
        {
            LBB_ToWebViewController *webViewController = [[LBB_ToWebViewController alloc]init];
            webViewController.url = [NSURL URLWithString:model.hrefUrl];
            [viewController.navigationController pushViewController:webViewController animated:YES];
        }
            break;
    /*        case 2://列表
        {
            UIViewController* dest;
            switch (model.type) {
                    case 1://美食
                    dest = [[LBB_FoodsMainViewController alloc] init];
                    break;
                    case 2://民宿
                    dest = [[LBB_HostelMainViewController alloc] init];
                    break;
                    case 3://景点
                    dest = [[LBB_ScenicMainViewController alloc] init];
                    break;
                    case 4://伴手礼
                {
                    BN_ShopSorterViewController *vc = [[BN_ShopSorterViewController alloc]initWith:model.objId];
                    [viewController.navigationController pushViewController:vc animated:YES];
                }
                    break;

                    case 10://攻略
                {
                    LBB_DiscoveryMainViewController* vc = [[LBB_DiscoveryMainViewController alloc] init];
                    [viewController.navigationController pushViewController:vc animated:YES];
                }
                    
                    break;
                case 14://伴手礼
                {
                    BN_ShopSorterViewController *vc = [[BN_ShopSorterViewController alloc]initWith:model.objId];
                    [viewController.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
            if (dest) {
                [viewController.navigationController pushViewController:dest animated:YES];
            }
            
        }
            break;
     */
            case 2://详情
        {
            LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc] init];
            LBB_SpotModel* viewModel = [[LBB_SpotModel alloc]init];
            viewModel.allSpotsId = model.objId;//主键Id
            dest.spotModel = viewModel;
            switch (model.type) {
                    case 1://美食
                    dest.homeType = LBBPoohHomeTypeFoods;
                    [viewController.navigationController pushViewController:dest animated:YES];
                    
                    break;
                    case 2://民宿
                    dest.homeType = LBBPoohHomeTypeHostel;
                    [viewController.navigationController pushViewController:dest animated:YES];
                    
                    break;
                    case 3://景点
                    dest.homeType = LBBPoohHomeTypeScenic;
                    [viewController.navigationController pushViewController:dest animated:YES];
                    
                    break;
                    case 4://伴手礼
                {
                    BN_ShopGoodDetailViewController *shopGoodDetailViewController = [[BN_ShopGoodDetailViewController alloc]initWith:model.objId];
                    [viewController.navigationController pushViewController:shopGoodDetailViewController animated:YES];
                }
                    break;
                    
                case 5://ugc图片
                {
                    LBBHostDetailViewController *vc = [[LBBHostDetailViewController alloc]init];
                    LBB_SquareUgc  *viewModel = [[LBB_SquareUgc alloc] init];
                    viewModel.ugcId = model.objId;
                    vc.viewModel = viewModel;
                    [viewController.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 6://ugc视频
                {
                    LBB_SquareUgc  *viewModel = [[LBB_SquareUgc alloc] init];
                    viewModel.ugcId = model.objId;
                    LBB_VideoDetailViewController *Vc = [[LBB_VideoDetailViewController alloc]init];
                    Vc.viewModel = viewModel;
                    [viewController.navigationController pushViewController:Vc animated:YES];
                }
                    break;
                case 7://游记
                {
                    LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
                    BN_SquareTravelList* viewModel = [[BN_SquareTravelList alloc] init];
                    viewModel.travelNotesId = model.objId;
                    vc.model = viewModel;
                    [viewController.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 8://用户头像
                {
                    
                    LBB_SquareSnsFollowViewController* dest = [[LBB_SquareSnsFollowViewController alloc]init];
                    LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
                    viewModel.userId = model.objId;
                    dest.viewModel = viewModel;
                    [viewController.navigationController pushViewController:dest animated:YES];
                }
                    break;
                case 9://足迹
                {
                    LBB_FootPointDetailController *vC = [[LBB_FootPointDetailController alloc]init];
                    TravelNotesDetails* viewModel = [[TravelNotesDetails alloc] init];
                    viewModel.objId = model.objId;
                    [viewController.navigationController pushViewController:vC animated:YES];
                }
                    break;
                    
                    
                    case 10://攻略
                {
                    LBB_DiscoveryDetailViewController* dest = [[LBB_DiscoveryDetailViewController alloc]init];
                    LBB_DiscoveryModel* viewModel = [[LBB_DiscoveryModel alloc] init];
                    viewModel.lineId = model.objId;
                    dest.viewModel = viewModel;
                    [viewController.navigationController pushViewController:dest animated:YES];
                }
                    break;
                    case 11://美食专题
                {
                    LBB_ScenicDetailSubjectViewController* vc = [[LBB_ScenicDetailSubjectViewController alloc] init];
                    vc.homeType = LBBPoohHomeTypeFoods;
                    LBB_SpotSpecialDetailsViewModel* spotModel = [[LBB_SpotSpecialDetailsViewModel alloc] init];
                    spotModel.specialId = model.objId;
                    vc.spotModel = spotModel;
                    [viewController.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    case 12://民宿专题
                {
                    LBB_ScenicDetailSubjectViewController* vc = [[LBB_ScenicDetailSubjectViewController alloc] init];
                    vc.homeType = LBBPoohHomeTypeHostel;
                    LBB_SpotSpecialDetailsViewModel* spotModel = [[LBB_SpotSpecialDetailsViewModel alloc] init];
                    spotModel.specialId = model.objId;
                    vc.spotModel = spotModel;
                    [viewController.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    case 13://景点专题
                {
                    LBB_ScenicDetailSubjectViewController* vc = [[LBB_ScenicDetailSubjectViewController alloc] init];
                    vc.homeType = LBBPoohHomeTypeScenic;
                    LBB_SpotSpecialDetailsViewModel* spotModel = [[LBB_SpotSpecialDetailsViewModel alloc] init];
                    spotModel.specialId = model.objId;
                    vc.spotModel = spotModel;
                    [viewController.navigationController pushViewController:vc animated:YES];
                    
                }
                case 14://伴手礼专题
                {
                    BN_ShopSpecialSubjectViewController *vc = [[BN_ShopSpecialSubjectViewController alloc]initWith:model.objId];
                    [viewController.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }


}


@end
