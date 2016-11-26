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
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"


@interface LBB_MyVideoViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) LBB_MyVideoViewModel *viewModel;

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
    self.viewModel = [[LBB_MyVideoViewModel alloc] init];
 
    __weak typeof(self) weakSelf = self;
    
    [self.collectionView setHeaderRefreshDatablock:^{
        [weakSelf.viewModel getMyVideoList:YES VidewType:weakSelf.squareType];
    } footerRefreshDatablock:^{
        [weakSelf.viewModel getMyVideoList:NO VidewType:weakSelf.squareType];
    }];
    
    //设置绑定数组
    [self.collectionView setCollectionViewData:self.viewModel.videoArray];
    
    //刷新数据
    [self.viewModel getMyVideoList:YES VidewType:weakSelf.squareType];
    
    [self.viewModel.videoArray.loadSupport setDataRefreshblock:^{
        NSLog(@"数据刷新了");
    }];
    
    [self.viewModel.videoArray.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        if (remak && [remak length]) {
            [weakSelf showHudPrompt:remak];
        }
    }];
    
    [self.collectionView loadData:self.viewModel.videoArray];

}
//#warning  模拟测试数据
//- (void)dataForTest
//{
//    if (TextEnvironment) {
//        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
//        for (int i = 0; i < 10; i++) {
//            LBB_MyVideoModel  *model = [[LBB_MyVideoModel alloc]init];
//            model.videoUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
//            model.totalComment = 9909;
//            model.totalLike = 999;
//            [array addObject:model];
//        }
//        self.viewModel.videoArray = array;
//        [self.collectionView reloadData];
//    }
//}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.viewModel.videoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LBB_MyVideoViewCell";
    LBB_MyVideoViewCell *cell =  (LBB_MyVideoViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.squareType = _squareType;
    cell.cellBlock = ^(id info,UICollectionViewCellSignal signal){
        [self dealCellSignal:signal withIndex:indexPath Object:info];
    };
    if (indexPath.row < self.viewModel.videoArray.count) {
        [cell setModel:self.viewModel.videoArray[indexPath.row]];
    }
   
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UICollectionViewCellSignal)signel  withIndex:(NSIndexPath *)indexPath Object:(id)infoObject
{
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    switch (signel) {
        case UICollectionViewCellPraise://赞
        {
            
        }
            break;
        case UICollectionViewCellComment://评论
        {
            LBB_TravelCommentController *vc = [[LBB_TravelCommentController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UICollectionViewCellDelete://删除
        {
             LBB_MyVideoModel *videoModel = (LBB_MyVideoModel*)infoObject;
            
            __weak typeof (self) weakSelf = self;
            __weak typeof (LBB_MyVideoModel *) weakVideoModel = videoModel;
            [videoModel.loadSupport setDataRefreshblock:^{
                [weakSelf.viewModel.videoArray removeObject:weakVideoModel];
                [weakSelf.collectionView reloadData];
            }];
            
            [videoModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
                if (remak && [remak length]) {
                    [weakSelf showHudPrompt:remak];
                }
            }];
            [videoModel deleteMyVideo];
            
        }
            break;
        case UICollectionViewCellCollection://收藏
        {
            
        }
            break;
        default:
            break;
    }
}

@end
