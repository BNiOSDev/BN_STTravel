//
//  LBB_PointsModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/10.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PointsModel.h"

@implementation LBB_PointsDetailModel

@end

@implementation LBB_PointsModel

- (LBB_PointsDetailModel*)getData
{
    LBB_PointsDetailModel *model = [[LBB_PointsDetailModel alloc] init];
    model.myPoints = 1000;
    model.convertiblePoints = 200;
    model.haveConvertedPoints = 300;
    model.totalPoints = 3000;
    model.descURL = @"http://www.baidu.com/";
    return model;
}

@end
