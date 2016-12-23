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
            case 2://列表
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
                    break;
                default:
                    break;
            }
            if (dest) {
                [viewController.navigationController pushViewController:dest animated:YES];
            }
            
        }
            break;
            case 3://详情
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
