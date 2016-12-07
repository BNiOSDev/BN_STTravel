//
//  LBB_StarRatingViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"

@interface LBB_StarRatingViewController : Base_BaseViewController

@property(nonatomic, retain)NSString* themeTitle;

@property (nonatomic,assign)long allSpotsId ;// 场景ID
@property (nonatomic,assign)int allSpotsType ;// 场景类型 1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记9足迹  10 线路攻略11 美食专题 12民宿专题
@property (nonatomic,assign)long parentId ;// 父评论

@end
