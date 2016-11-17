//
//  LBB_NoticeModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NoticeModel.h"

@implementation LBB_NoticeDetailModel


@end


@implementation LBB_NoticeModel

- (NSArray<LBB_NoticeDetailModel*>*)getData
{
    NSMutableArray *detailArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 9; i++) {
        LBB_NoticeDetailModel *detailModel = [[LBB_NoticeDetailModel alloc] init];
        detailModel.detailID = @"11";
        detailModel.detailDateStr = @"12:21";
        detailModel.title = @"公告标题";
        detailModel.dateStr =  @"7月7日 12:21";
        detailModel.detailURL = @"https://www.baidu.com/";
        if (i%2 == 0) {
            detailModel.content = @"公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容，公告内容";
        }else {
            detailModel.content = @"公告内容，公告内容，公告内容，公告内容";
        }
        [detailArray addObject:detailModel];
        
    }
    return detailArray;
}

@end
