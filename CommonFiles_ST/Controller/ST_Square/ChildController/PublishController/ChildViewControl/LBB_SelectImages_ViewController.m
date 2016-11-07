//
//  LBB_SelectImages_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//
#define COLLECTWH  (DeviceWidth - 20) / 3.0

#import "LBB_SelectImages_ViewController.h"
#import "LBB_ZJMPhotoList.h"
#import "FZJSmallPhotoCell.h"
#import "UIButtonExt.h"
#import "Header.h"
#import "LBB_ImageCollect_TableViewCell.h"

@interface LBB_SelectImages_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
     BOOL        showList;
}
@property(nonatomic,strong)UITableView     *imageCollect;
@property(nonatomic,strong)UICollectionView  *imageList;
@property(nonatomic,strong)NSMutableArray   *imageArray;
@property(nonatomic,strong)NSMutableArray   *imageCollectArray;
@property (nonatomic, strong)  UIButton           *centerBtn;
@property (nonatomic, weak)UITableView         *mTableView;
/**
 *  存放已经选择的照片
 */
@property(nonatomic,strong)NSMutableArray * selectedPhoto;
@end

@implementation LBB_SelectImages_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKVIEWCOLOR;
    [self initNav];
    
    showList = NO;
    
    _imageCollectArray = [NSMutableArray array];
    _imageCollectArray = [[[FZJPhotoTool defaultFZJPhotoTool] getAllPhotoList] mutableCopy];
    
    if(_imageCollectArray.count)
    {
        _listModel = _imageCollectArray[0];
    }
    _fetchResult = [[FZJPhotoTool defaultFZJPhotoTool] getAssetsInAssetCollection:_listModel.assetCollection ascending:YES];
    
    [_imageList reloadData];
    [self createCollectView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.mTableView];
}

- (void)initNav{
    _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AUTO(100), 44)];
    _centerBtn.backgroundColor = [UIColor whiteColor];
    [_centerBtn setTitleColor:ColorBlack forState:0];
    [_centerBtn setTitle:@"所有照片" forState:0];
    [_centerBtn setImage:IMAGE(@"") forState:0];
    [_centerBtn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _centerBtn;
}


- (void)createCollectView
{
    _selectedPhoto = [NSMutableArray array];
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.itemSize = CGSizeMake(COLLECTWH - 4, COLLECTWH);
//    //        self.headerReferenceSize = CGSizeMake(ScreenW, PaddingV);
//    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5,0, 5);
    _imageList = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 44 - 64) collectionViewLayout:flowLayout];
    _imageList.dataSource=self;
    _imageList.delegate=self;
    _imageList.pagingEnabled = YES;
    [_imageList setBackgroundColor:[UIColor clearColor]];
    _imageList.scrollEnabled = YES;
    //    注册Cell，必须要有
    [_imageList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:_imageList];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }
    __block  UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, COLLECTWH, COLLECTWH)];
    image.contentMode = UIViewContentModeScaleToFill;
    image.clipsToBounds = YES;
    CGSize size = cell.size;
    size.width *= [UIScreen mainScreen].scale;
    size.height *= [UIScreen mainScreen].scale;
    [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:self.fetchResult[indexPath.row] makeSize:size makeResizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *AssetImage) {
        image.image = AssetImage;
    }];
    cell.backgroundView = image;
    return cell;
}

-(UITableView *)mTableView
{
    if(!_mTableView)
    {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -DeviceHeight, DeviceWidth, DeviceHeight) style:0];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [BLACKCOLOR colorWithAlphaComponent:0.3];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [tableView setTableFooterView:view];
        _mTableView = tableView;
        return tableView;
    }
    return _mTableView;
}

- (void)showPicker
{
    if(!showList)
    {
        [UIView animateWithDuration:0.5 animations:^{
            _mTableView.top = 0;
        } completion:^(BOOL finished) {
            showList = !showList;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _mTableView.top = -DeviceHeight;
        } completion:^(BOOL finished) {
            showList = !showList;
        }];
    }
}

#pragma mark --UICollectionViewDelegate

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DeviceWidth - 20)/3.0, (DeviceWidth - 20)/3.0);
}

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imageCollectArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"photoCell";
    LBB_ImageCollect_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[LBB_ImageCollect_TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    CGSize size = CGSizeMake(105, 70);
    size.height *= [UIScreen mainScreen].scale;
    size.width *= [UIScreen mainScreen].scale;
    
    LBB_ZJMPhotoList *list = _imageCollectArray[indexPath.row];
    
    [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:list.firstAsset makeSize:size makeResizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *AssetImage) {
        if (AssetImage) {
            cell.image.image = AssetImage;
        }
    }];
    cell.collectName.text = list.title;
    cell.number.text = [NSString stringWithFormat:@"%d 张照片",(int)list.photoNum];
    
    cell.backgroundColor = WHITECOLOR;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _listModel = _imageCollectArray[indexPath.row];
    _fetchResult = [[FZJPhotoTool defaultFZJPhotoTool] getAssetsInAssetCollection:_listModel.assetCollection ascending:YES];
    [_imageList reloadData];
    [UIView animateWithDuration:0.5 animations:^{
        tableView.top = -DeviceHeight;
    }];
}
#pragma mark --  判断对相册和相机的使用权限
/**
 *  相册的使用权限
 *
 *  @return 是否
 */
-(BOOL)FZJhaveAlbumAuthority{
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
    
}
/**
 *  相机的使用权限
 *
 *  @return 是否
 */
-(BOOL)FZJhaveCameraAuthority{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}



@end
