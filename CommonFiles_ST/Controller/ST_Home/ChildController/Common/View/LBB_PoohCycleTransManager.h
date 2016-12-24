//
//  LBB_PoohCycleTransManager.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/24.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_HomeViewModel.h"

@interface LBB_PoohCycleTransManager : NSObject

+ (id)sharedInstance;

-(void)transmission:(BN_HomeAdvertisement*)model
        viewController:(UIViewController*)viewController;

@end
