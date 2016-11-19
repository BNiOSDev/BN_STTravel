//
//  LBB_MyVideoViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyVideoViewController.h"
#import "LBB_MyVideoViewCell.h"
#import "Header.h"
 

@interface LBB_MyVideoViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray *arr;
@property(nonatomic,strong) UICollectionView *collectionView;
@end

@implementation LBB_MyVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"视频";
    [self initDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
    horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    horizontalCellLayout.sectionInset = UIEdgeInsetsMake(3, 15, 15, 9);
    horizontalCellLayout.minimumInteritemSpacing = 1;
    horizontalCellLayout.minimumLineSpacing = 1;
    horizontalCellLayout.itemSize = CGSizeMake(AUTO(150), AUTO(170));
    
    if (self.squareType == MySquareVideoViewFravorite) {
        horizontalCellLayout.itemSize = CGSizeMake(AUTO(150), AUTO(150));
    }
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:horizontalCellLayout];
    self.view .autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    if (self.squareType == MySquareVideoViewFravorite) {
        _collectionView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64);
    }
    _collectionView.backgroundColor = ColorBackground;
    _collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceHorizontal = NO;
    
    _collectionView.scrollEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:NSClassFromString(@"LBB_MyVideoViewCell")
        forCellWithReuseIdentifier:@"LBB_MyVideoViewCell"];
}

- (void)initDataSource
{
    self.arr = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        LBB_MyVideoModel  *model = [[LBB_MyVideoModel alloc]init];
        model.imageUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
        model.praiseNum = @"999";
        model.commentNum = @"999";
        [self.arr addObject:model];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LBB_MyVideoViewCell";
    LBB_MyVideoViewCell *cell =  (LBB_MyVideoViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.squareType = _squareType;
    LBB_MyVideoModel *cellInfo = [self.arr objectAtIndex:indexPath.row];
    if (cellInfo) {
        [cell setModel:cellInfo];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
