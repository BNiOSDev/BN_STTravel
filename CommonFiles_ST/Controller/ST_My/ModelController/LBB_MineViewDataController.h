//
//  LBB_MineViewDataController.h
//  ST_Travel
//
//  Created by Diana on 16/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBB_MySectionHeadViewCell.h"
#import "LBB_MyUserHeaderView.h"


@interface LBB_MineViewDataController : NSObject<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
LBB_MySectionHeadViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableArray *arr;

@property (nonatomic,weak) id<LBB_MySectionHeadViewDelegate> cellDelegate;
@property (nonatomic,weak) id<LBB_MyUserHeaderViewDelegate> userHeaderDelegate;
@property (nonatomic,strong) id userInfo;

- (void)initDataSource;

- (void)replaceUserHeadImage:(UIImage*)converPicture;

@end
