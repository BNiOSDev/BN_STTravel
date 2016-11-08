//
//  LBB_HomeTableViewDataSource.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LBBHomeSectionType) {
    LBBHomeSectionMenuType = 0,//入口
    LBBHomeSectionHotestType,//热门推荐
    LBBHomeSectionTravelRecommendType,//游记推荐
    LBBHomeSectionVipRecommendType,//达人推荐
    LBBHomeSectionSquareCenterType,//广场中心
    LBBHomeSectionTravelProductType,//旅游产品
};

@interface LBB_HomeTableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

- (id)initWithTableView:(UITableView *)tableView;

@property(nonatomic, weak) UIViewController* parentViewController;

@end