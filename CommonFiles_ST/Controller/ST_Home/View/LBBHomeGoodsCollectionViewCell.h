//
//  LBBHomeGoodsCollectionViewCell.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "KSViewPagerView.h"
#import "HMSegmentedControl.h"
#import "LBB_HomeViewModel.h"


typedef NS_ENUM(NSInteger, LBBHomeHotestTableViewCellType1) {
    LBBHomeHotestTableViewCellHotType1 = 0,//热门推荐
    LBBHomeHotestTableViewCellVipRecommendType1,//达人推荐
    LBBHomeHotestTableViewCellTravelProductType1 ,//旅游产品
    
};
@interface LBBHomeGoodsCollectionViewCell : LBBPoohBaseTableViewCell



@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, retain) HMSegmentedControl* pagerView;
-(void)setPagerViewHidden:(BOOL)isHidden;

@property(nonatomic, assign)LBBHomeHotestTableViewCellType1 type;


//热门推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeHotGoodsObject*> *spotsArray;

//达人景点推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeHotGoodsObject*> *scenicSpotsArray;
//达人美食推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeHotGoodsObject*> *footSpotsArray;
//达人民宿推荐
@property (nonatomic, strong)NSMutableArray<BN_HomeHotGoodsObject*> *liveSpotsArray;

@end
