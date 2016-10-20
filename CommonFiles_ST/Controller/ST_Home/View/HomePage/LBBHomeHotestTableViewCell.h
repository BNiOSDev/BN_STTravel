//
//  LBBHomeHotestTableViewCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "KSViewPagerView.h"


@interface LBBHomeHotestTableViewCell : LBBPoohBaseTableViewCell


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, retain) KSViewPagerView* pagerView;
-(void)setPagerViewHidden:(BOOL)isHidden;


-(void)setreload;


@end
