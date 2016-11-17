//
//  LBB_MyPhotoViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyPhotoViewController.h"
#import "LBB_MyPhotoViewCell.h"
#import "Header.h" 
#import "LBB_TravelDetailViewController.h"

@interface LBB_MyPhotoViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) NSMutableArray *arr;
@property(nonatomic,strong) UICollectionView *collectionView;


@end

@implementation LBB_MyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"照片";
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
    horizontalCellLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 9);
    horizontalCellLayout.minimumInteritemSpacing = 1;
    horizontalCellLayout.minimumLineSpacing = 1;
    horizontalCellLayout.itemSize = CGSizeMake(AUTO(150), AUTO(170));
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:horizontalCellLayout];
    self.view .autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    _collectionView.backgroundColor = ColorBackground;
    _collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceHorizontal = NO;
    
    _collectionView.scrollEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
 
    [_collectionView registerClass:NSClassFromString(@"LBB_MyPhotoViewCell")
        forCellWithReuseIdentifier:@"LBB_MyPhotoViewCell"];
}

- (void)initDataSource
{
    self.arr = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        LBB_MyPhotoModel  *model = [[LBB_MyPhotoModel alloc]init];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sgection{
    
   return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LBB_MyPhotoViewCell";
    LBB_MyPhotoViewCell *cell =  (LBB_MyPhotoViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    LBB_MyPhotoModel *cellInfo = [self.arr objectAtIndex:indexPath.row];
    if (cellInfo) {
        [cell setModel:cellInfo];
    }
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
