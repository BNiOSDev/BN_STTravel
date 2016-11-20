//
//  LBBHomeHotestTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "KSViewPagerView.h"
#import "HMSegmentedControl.h"
#import "LBB_HomeViewModel.h"

@interface LBBHomeHotestTableViewCell : LBBPoohBaseTableViewCell


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, retain) HMSegmentedControl* pagerView;
-(void)setPagerViewHidden:(BOOL)isHidden;

@property(nonatomic, assign)BOOL isMarket;


//热门推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *spotsArray;

//达人景点推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *scenicSpotsArray;
//达人美食推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *footSpotsArray;
//达人民宿推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeSpotsList*> *liveSpotsArray;

@end
