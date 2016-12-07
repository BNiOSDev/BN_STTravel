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
#import "LBBHostDetailViewController.h"
#import "LBB_TravelCommentController.h"

@interface LBB_MyPhotoViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) LBB_MyPhotoViewModel *viewModel;

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

    horizontalCellLayout.sectionInset = UIEdgeInsetsMake(3,3,10,3);
    horizontalCellLayout.minimumInteritemSpacing = 1;
    horizontalCellLayout.minimumLineSpacing = 10;
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    CGFloat width = mainSize.width/2.0 - 10;
    horizontalCellLayout.itemSize = CGSizeMake(width, width + 25.f);
    
    CGRect mainRect = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64.f);
    _collectionView = [[UICollectionView alloc] initWithFrame:mainRect collectionViewLayout:horizontalCellLayout];
    self.view .autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    if (self.squareType == MySquarePhotoViewFravorite) {
        horizontalCellLayout.itemSize = CGSizeMake(width, width);
        _collectionView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64.f - TopSegmmentControlHeight);
    }
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
    
    self.viewModel = [[LBB_MyPhotoViewModel alloc] init];
    
    __weak typeof(self) weakSelf = self;
    
    [self.collectionView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getMyPhotoList:YES VidewType:weakSelf.squareType];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getMyPhotoList:NO VidewType:weakSelf.squareType];
    }];
    
    //设置绑定数组
    [self.collectionView setCollectionViewData:self.viewModel.photoArray];
    
    //刷新数据
    [self.viewModel getMyPhotoList:YES VidewType:weakSelf.squareType];
    
    [self.viewModel.photoArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.viewModel.photoArray.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        if (remak && [remak length]) {
            [weakSelf showHudPrompt:remak];
        }
    }];
    
    [self.collectionView loadData:self.viewModel.photoArray];
}
//#warning  模拟测试数据
- (void)dataForTest
{
    if (TextEnvironment) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            LBB_MyPhotoModel  *model = [[LBB_MyPhotoModel alloc]init];
            model.coverImageUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
            model.totalComment = 9909;
            model.totalLike = 999;
            [array addObject:model];
        }
        self.viewModel.photoArray = array;
        [self.collectionView reloadData];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sgection{
    
   return self.viewModel.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LBB_MyPhotoViewCell";
    LBB_MyPhotoViewCell *cell = (LBB_MyPhotoViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.squareType = _squareType;
    cell.cellBlock = ^(id info,UICollectionViewCellSignal signal){
        [self dealCellSignal:signal withIndex:indexPath Object:info];
    };
    
    if (self.viewModel.photoArray.count > indexPath.row) {
        [cell setModel:[self.viewModel.photoArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LBBHostDetailViewController *vc = [[LBBHostDetailViewController alloc]init];
    if (self.viewModel.photoArray.count > indexPath.row) {
        LBB_MyPhotoModel *photoModel = [self.viewModel.photoArray objectAtIndex:indexPath.row];
        vc.viewModel = [[LBB_SquareUgc alloc] init];
        vc.viewModel.ugcId = photoModel.ugcId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UICollectionViewCellSignal)signel  withIndex:(NSIndexPath *)indexPath Object:(id)infoObject
{
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    LBB_MyPhotoModel *photoModel = (LBB_MyPhotoModel*)infoObject;
    __weak typeof (self) weakSelf = self;
    __weak typeof (LBB_MyPhotoModel *) weakPhotoModel = photoModel;
    
    [photoModel.loadSupport setDataRefreshblock:^{
        [weakSelf.collectionView reloadData];
    }];
    
    [photoModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        if (remak && [remak length]) {
            [weakSelf showHudPrompt:remak];
        }
    }];
    
    
    switch (signel) {
        case UICollectionViewCellPraise://赞
        {
            [photoModel like];
        }
            break;
        case UICollectionViewCellComment://评论
        {
            LBBHostDetailViewController *vc = [[LBBHostDetailViewController alloc]init];
            vc.viewModel = [[LBB_SquareUgc alloc] init];
            vc.viewModel.ugcId = photoModel.ugcId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UICollectionViewCellDelete://删除
        {
            [photoModel.loadSupport setDataRefreshblock:^{
                for (int i = 0; i < weakSelf.viewModel.photoArray.count; i++) {
                    LBB_MyPhotoModel *tmpModel = weakSelf.viewModel.photoArray[i];
                    if (tmpModel.ugcId == weakPhotoModel.ugcId) {
                        [weakSelf.viewModel.photoArray removeObject:tmpModel];
                        break;
                    }
                }
                [weakSelf.collectionView reloadData];
            }];
            
            [photoModel deleteMyPhoto];
        }
            break;
        case UICollectionViewCellCollection://收藏
        {
            [photoModel collect];
        }
            break;
        default:
            break;
    }
}

@end
