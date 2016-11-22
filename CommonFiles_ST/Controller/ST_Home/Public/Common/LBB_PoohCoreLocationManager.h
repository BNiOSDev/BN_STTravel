//
//  LBB_PoohCoreLocationManager.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LBB_PoohCoreLocationManager : NSObject<CLLocationManagerDelegate>

@property(nonatomic, strong)CLLocationManager* locManager;

@property(nonatomic, copy)NSString* latitude;//纬度
@property(nonatomic, copy)NSString* longitude;//经度


@end
