//
//  LBB_PoohCoreLocationManager.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohCoreLocationManager.h"

@implementation LBB_PoohCoreLocationManager

-(id)init{
    
    if (self = [super init]) {
        self.longitude = @"-1";
        self.latitude = @"-1";
        self.locManager = [[CLLocationManager alloc] init];
        self.locManager.delegate = self;
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locManager.distanceFilter = 5.0;
        [self.locManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
        [self.locManager requestWhenInUseAuthorization];//这句话ios8以上版本使用。
        [self.locManager startUpdatingLocation];
        

        NSLog(@"[CLLocationManager authorizationStatus]:%d", [CLLocationManager authorizationStatus]);
    }
    return self;
}

// 代理方法实现
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"locationManager didUpdateToLocation %f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    
    self.longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];

    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"locationManager didFailWithError%@",error);
}
@end
