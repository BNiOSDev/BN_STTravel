//
//  LBB_MineViewDataController.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_MySectionHeadViewCell.h"
#import "LBB_MyUserHeaderView.h"

@protocol LBB_MineViewDataControllerDelegate <NSObject>

@optional

- (void)didClickDetailActionDelegate:(NSInteger)viewType;

@end

@interface LBB_MineViewDataController : NSObject<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
LBB_MySectionHeadViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *arr;

@property (nonatomic,weak) id<LBB_MineViewDataControllerDelegate> cellDelegate;
@property (nonatomic,weak) id<LBB_MyUserHeaderViewDelegate> userHeaderDelegate;
@property (nonatomic,strong) id userInfo;

- (void)initDataSource;

@end
