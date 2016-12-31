//
//  LBB_HomeTableViewDataSource.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_HomeViewModel.h"

typedef NS_ENUM(NSInteger, LBBHomeSectionType) {
    LBBHomeSectionMenuType = 0,//入口
    LBBHomeSectionVipRecommendType,//达人推荐
    LBBHomeSectionSquareCenterType,//广场中心
    LBBHomeSectionTravelRecommendType,//游记推荐
    LBBHomeSectionHotestType,//热门推荐
    LBBHomeSectionTravelProductType,//旅游产品
};

@interface LBB_HomeTableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

- (id)initWithTableView:(UITableView *)tableView;

@property(nonatomic, weak) UIViewController* parentViewController;
@property(nonatomic, retain)LBB_HomeViewModel* viewModel;//数据模型

@end
