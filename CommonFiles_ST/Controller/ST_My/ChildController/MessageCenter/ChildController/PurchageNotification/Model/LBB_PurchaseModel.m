//
//  LBB_PurchaseModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PurchaseModel.h"

@implementation LBB_PurchaseModel

@end


@implementation LBB_PurchaseDataModel

- (NSMutableArray<LBB_PurchaseModel*>*)getData
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        LBB_PurchaseModel *model = [[LBB_PurchaseModel alloc] init];
        model.ID = [NSString stringWithFormat:@"%@",@(i)];
        model.title = @"优惠促销标题";
        model.content = @"欢迎国庆欢迎国庆欢迎国庆欢迎国庆欢迎国庆欢迎国庆欢迎国庆欢迎国庆欢迎国庆";
        model.dateStr = @"08-09";
        model.imageURL = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        [array addObject:model];
    }
    
    return array;
}

@end
