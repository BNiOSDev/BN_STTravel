//
//  LBB_SquareTravelModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelModel.h"

@implementation LBB_SquareTravelModelDetail

@end

@implementation LBB_SquareTravelModel

- (NSArray*)getDataWithType:(MessageCenterSquareTravelType)type;
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 5; i++) {
        LBB_SquareTravelModelDetail *detailInfo = [[LBB_SquareTravelModelDetail alloc] init];
        detailInfo.imagePath = @"19.pic.jpg";
        detailInfo.ID = [NSString stringWithFormat:@"%@",@(i)];
        detailInfo.dateStr = [self stringFromDate:[NSDate date]];
        switch (type) {
            case eMessageFollow:
                 detailInfo.content = @"马云关注了你,很开心很高兴很激动吧";
                break;
            case eMessageLike:
            {
              detailInfo.content = @"马云点赞了你发布的照片，千万不要说出来，打死也不要说出来";
              detailInfo.underLineContent = @"照片";
            }
                break;
            case eMessageComment:
            {
                detailInfo.content = @"李彦宏评论了你发布的视频，打死也不要说出来";
                detailInfo.underLineContent = @"视频";
            }
                break;
            case eMessageCollection:
            {
                detailInfo.content = @"本大侠收藏了了你发布的游记梦幻西游，很开心很高兴很激动吧，不用说，千万不要说出来，打死也不要说出来";
                detailInfo.underLineContent = @"梦幻西游";
            }
                break;
            default:
                break;
        }
        [array addObject:detailInfo];
    }
    
    return array;
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

@end
