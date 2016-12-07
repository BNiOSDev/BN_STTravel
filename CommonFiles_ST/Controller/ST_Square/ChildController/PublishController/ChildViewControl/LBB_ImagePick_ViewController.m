//
//  LBB_ImagePick_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ImagePick_ViewController.h"
#import "LBB_ZJMPhotoList.h"
#import "LBBVideoPlayerViewController.h"
#import "Header.h"
#import "ZYCameraViewComtroller.h"
#import "LBBVideoCollectionViewCell.h"
#import "LBB_PublishVideo_Contain_ViewController.h"

@interface LBB_ImagePick_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TransImageDelegate,PHPhotoLibraryChangeObserver>
@property(nonatomic,strong)UICollectionView  *imageList;
@property(nonatomic,strong)NSMutableArray   *videoArray;
@property(nonatomic,strong)PHAsset               *selectVideoAsset;
@property(nonatomic,copy)NSIndexPath          *selectIndexPath;
@end

@implementation LBB_ImagePick_ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerChangeObserver];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
    [self unregisterChangeObserver];
}

#pragma mark - Photo library change observer
- (void)registerChangeObserver
{
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)unregisterChangeObserver
{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"所有视频";
    
    UIBarButtonItem  *rightBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmcorfirm") style:0 target:self action:@selector(checkPulish)];
    rightBrBtn.tintColor = UIColorFromRGB(0xAC793B);
    self.navigationItem.rightBarButtonItem = rightBrBtn;
    
    UIBarButtonItem  *leftBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"back") style:0 target:self action:@selector(backControl)];
    leftBrBtn.tintColor = UIColorFromRGB(0x333333);
    self.navigationItem.leftBarButtonItem = leftBrBtn;
    
    //初始化资源
    _videoArray = [[NSMutableArray alloc]init];
    FZJPhotoTool  *videoGet = [[FZJPhotoTool alloc]init];
    _videoArray = [[videoGet getAllAssetInVideoAblumWithAscending:YES] mutableCopy];
    
    
    
    [self createCollectView];
}

#pragma mark  返回
- (void)backControl
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createCollectView
{
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    _imageList = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 44 - 64) collectionViewLayout:flowLayout];
    _imageList.dataSource=self;
    _imageList.delegate=self;
    _imageList.pagingEnabled = YES;
    [_imageList setBackgroundColor:[UIColor clearColor]];
    _imageList.scrollEnabled = YES;
    //    注册Cell，必须要有
    [_imageList registerClass:[LBBVideoCollectionViewCell class] forCellWithReuseIdentifier:@"LBBVideoCollectionViewCell"];
    [self.view addSubview:_imageList];
}


#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _videoArray.count + 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"LBBVideoCollectionViewCell";
    
    LBBVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LBBVideoCollectionViewCell alloc] init];
        cell.backgroundColor = [UIColor redColor];
    }
    if(indexPath.row == 0)
    {
        UIButton *takePhoto =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, cell.size.width, cell.size.height)];
        [takePhoto setImage:IMAGE(@"zjmpaishiping") forState:0];
        takePhoto.backgroundColor = UIColorFromRGB(0x4E4F50);
        cell.backgroundView = takePhoto;
        cell.pauseImage.hidden = YES;
        cell.selectBtn.hidden = YES;
        cell.contentImage.hidden = YES;
        return cell;
    }else{
        CGSize size = CGSizeMake(cell.size.width, cell.size.height);
        size.height *= [UIScreen mainScreen].scale;
        size.width *= [UIScreen mainScreen].scale;
        PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
        imageOptions.synchronous = NO;//YES 一定是同步    NO不一定是异步
        imageOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        imageOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;//imageOptions.synchronous = NO的情况下最终决定是否是异步
        [[PHImageManager defaultManager] requestImageForAsset:self.videoArray[indexPath.row - 1] targetSize:size contentMode:PHImageContentModeAspectFit options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
                imageView.size = cell.size;
                imageView.image = result;
                cell.contentImage.size = cell.size;
                cell.contentImage.image = result;
        }];
        cell.pauseImage.centerX = cell.size.width / 2;
        cell.pauseImage.centerY = cell.size.height / 2;
        cell.pauseImage.hidden = NO;
        cell.selectBtn.hidden = NO;
        cell.contentImage.hidden = NO;
        cell.selectBtn.tag = indexPath.row;
        if(indexPath == _selectIndexPath)
        {
             [cell.selectBtn setBackgroundImage:IMAGE(@"zjmxuanzhong") forState:0];
        }
        cell._blockVideo = ^(NSInteger index,BOOL select){
            if(select)
            {
                NSLog(@"xuanzhong");
                self.selectIndexPath = indexPath;
                self.selectVideoAsset = self.videoArray[indexPath.row - 1];
            }else{
                NSLog(@"quchuxuanzhong");
                self.selectIndexPath = nil;
                self.selectVideoAsset = nil;
            }
            [self updateSelect:indexPath];
        };
        return cell;
    }
}

#pragma mark --UICollectionViewDelegate

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((DeviceWidth - 20)/2.0, (DeviceWidth - 20)/2.0);
}

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 0, 5);
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row = %ld",indexPath.row);
    if(indexPath.row == 0)
    {
        ZYCameraViewComtroller *Vc = [[ZYCameraViewComtroller alloc]init];
        Vc.TransDelegate = self;
        Vc.VideoStyle = YES;
        [self presentViewController:Vc animated:YES completion:nil];
    }else{
        PHAsset *phAsset = _videoArray[indexPath.row - 1];
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *url = urlAsset.URL;
            LBBVideoPlayerViewController  *vc = [[LBBVideoPlayerViewController alloc] init];
            vc.videoUrl = url;
            [self presentViewController:vc animated:NO completion:nil];
        }];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - Photo library changed
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    NSLog(@"跟新资源文件");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *updatedFetchResults = nil;
        updatedFetchResults = [[[[FZJPhotoTool alloc]init]  getAllAssetInPhotoAblumWithAscending:YES] mutableCopy];
        if (updatedFetchResults)
        {
            [_videoArray removeAllObjects];
            FZJPhotoTool  *videoGet = [[FZJPhotoTool alloc]init];
            _videoArray = [[videoGet getAllAssetInVideoAblumWithAscending:YES] mutableCopy];
        }
        [_imageList reloadData];
    });
}

#pragma transCameraVideo
- (void)transCameraVideo:(NSData *)video
{
    NSLog(@"视频回传");
}

- (void)transCameraImage:(UIImage *)image PHAsset:(PHAsset *)imageAsset
{
    NSLog(@"视频回传了");
    _selectVideoAsset = imageAsset;
    if(imageAsset.mediaType == 2)
    {
        [self checkPulish];
    }else{
        [self showHudPrompt:@"这不是视频文件"];
    }
}

- (void)checkPulish
{
    if(self.selectVideoAsset)
    {
        LBB_PublishVideo_Contain_ViewController *vc = [[LBB_PublishVideo_Contain_ViewController alloc]init];
        vc.videoAsset = _selectVideoAsset;
        self._blockJumpControl(vc);
    }else{
        [self showHudPrompt:@"还未选择视频哦！"];
    }
}

#pragma mark 选中展示处理
- (void)updateSelect:(NSIndexPath *)selectIndex;
{
    for(int i = 1; i < _videoArray.count+1;i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        LBBVideoCollectionViewCell  *cell = (LBBVideoCollectionViewCell *)[_imageList cellForItemAtIndexPath:indexPath];
        if(indexPath == _selectIndexPath)
        {
            cell.beSelect = YES;
        }else{
            cell.beSelect = NO;
            [cell.selectBtn setBackgroundImage:IMAGE(@"zjmweixuanzhong") forState:0];
        }
    }
}

@end
