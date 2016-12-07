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
#import "FZJBigPhotoController.h"
#import "ZYCameraViewComtroller.h"
#import "LBB_PulishContain_ViewController.h"

@interface LBB_SelectImages_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,TransImageDelegate,PHPhotoLibraryChangeObserver>
{
     BOOL        showList;
    BOOL        TAKEPHOTO;
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
    
    showList = NO;//控制tableview
    
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];

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
    TAKEPHOTO = NO;
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    [self.view addSubview:self.mTableView];
    [self registerChangeObserver];
    if(_fatherNum > 0)
    {
        _imageList.height = DeviceHeight - 64;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
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

- (void)initNav{
    _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AUTO(100), 44)];
    _centerBtn.backgroundColor = [UIColor whiteColor];
    [_centerBtn setTitleColor:ColorBlack forState:0];
    [_centerBtn setTitle:@"所有照片" forState:0];
//    [_centerBtn setImage:IMAGE(@"zjmcorfirm") forState:0];
    [_centerBtn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _centerBtn;
    
    UIBarButtonItem  *leftBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"back") style:0 target:self action:@selector(notifiTionBaseControl)];
    leftBrBtn.tintColor = UIColorFromRGB(0x333333);
    self.navigationItem.leftBarButtonItem = leftBrBtn;
    
    UIBarButtonItem  *rightBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmcorfirm") style:0 target:self action:@selector(checkPulish)];
    rightBrBtn.tintColor = UIColorFromRGB(0xAC793B);
    self.navigationItem.rightBarButtonItem = rightBrBtn;
}


- (void)createCollectView
{
    _selectedPhoto = [[NSMutableArray alloc]init];
    
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
//    [_imageList registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_imageList registerNib:[UINib nibWithNibName:@"FZJSmallPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"SmallPhotoCell"];
    [self.view addSubview:_imageList];
}

//通知根控制器做返回操作
- (void)notifiTionBaseControl
{
    if(_fatherNum > 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    self._blockHideControl(nil);
}

- (void)checkPulish
{
    if(_selectedPhoto.count == 0)
    {
        [self showHudPrompt:@"您未选择任何照片"];
        return;
    }
    
    if(_fatherNum > 0)
    {
        [self.navigationController popViewControllerAnimated:NO];
        self.returnBlock(_selectedPhoto);
        return;
    }

    LBB_PulishContain_ViewController *Vc = [[LBB_PulishContain_ViewController alloc]init];
    Vc.selectImageArray = self.selectedPhoto.copy;
    self._blockJumpControl(Vc);
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fetchResult.count + 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString * CellIdentifier = @"UICollectionViewCell";
//    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[UICollectionViewCell alloc] init];
//    }
//    __block  UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, COLLECTWH, COLLECTWH)];
//    image.contentMode = UIViewContentModeScaleToFill;
//    image.clipsToBounds = YES;
//    CGSize size = cell.size;
//    size.width *= [UIScreen mainScreen].scale;
//    size.height *= [UIScreen mainScreen].scale;
//    [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:self.fetchResult[indexPath.row] makeSize:size makeResizeMode:PHImageRequestOptionsResizeModeExact completion:^(UIImage *AssetImage) {
//        image.image = AssetImage;
//    }];
//    cell.backgroundView = image;
    
    FZJSmallPhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallPhotoCell" forIndexPath:indexPath];
    cell.ImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.clipsToBounds = YES;
    
    if (indexPath.row == 0) {
        UIButton *takePhoto =  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, cell.size.width, cell.size.height)];
        [takePhoto setImage:IMAGE(@"zjmpaizhao") forState:0];
        takePhoto.backgroundColor = UIColorFromRGB(0x4E4F50);
        cell.backgroundView = takePhoto;
        cell.ChooseBtn.hidden = YES;
        cell.ImageView.hidden = YES;
        return cell;
    }else{
        CGSize size = cell.size;
        size.width *= [UIScreen mainScreen].scale;
        size.height *= [UIScreen mainScreen].scale;
        [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:self.fetchResult[indexPath.row - 1] makeSize:size makeResizeMode:           PHImageRequestOptionsResizeModeExact completion:^(UIImage *    AssetImage) {
            cell.ImageView.image = AssetImage;
        }];
        cell.ChooseBtn.index = indexPath.row - 1;
        cell.ChooseBtn.selected = NO;
        cell.ChooseBtn.hidden = NO;
        cell.ImageView.hidden = NO;
        [cell.ChooseBtn addTarget:self action:@selector(smallCellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
        for (FZJPhotoModel * model  in _selectedPhoto) {
            if ([model.imageName isEqualToString:[_fetchResult[indexPath.row - 1]   valueForKey:@"filename"]]) {
                cell.ChooseBtn.selected = YES;
            }
        }
        return cell;
    }
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

#pragma mark --- cell的照片选择事件
-(void)smallCellBtnClicked:(UIButtonExt *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {//为1 则直接加进数组
        if (_selectedPhoto.count == self.addNum) {
            [self showHudPrompt:[NSString stringWithFormat:@"最多选择%ld张照片",self.addNum]];
            btn.selected = NO;
        }else{
            FZJPhotoModel * model = [[FZJPhotoModel alloc]init];
            model.asset = _fetchResult[btn.index];
            model.imageName = [_fetchResult[btn.index] valueForKey:@"filename"];
           
            [_selectedPhoto addObject:model];
            NSLog(@"imageName = %@",model.imageName);
            NSLog(@"arrayNum = %ld",_selectedPhoto.count);
        }
    }else{//为0 从数组中删除
        //在遍历数组的时候尽量避免对数组的内容进行操作。
        [_selectedPhoto enumerateObjectsUsingBlock:^(FZJPhotoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj.imageName isEqualToString:[_fetchResult[btn.index] valueForKey:@"filename"]])
            {
                *stop = YES;//停止遍历数组
                if(*stop)
                {
                    [_selectedPhoto removeObject:obj];//删除图片哈
                }
            }
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
    if(indexPath.row == 0)
    {
        TAKEPHOTO = YES;
        ZYCameraViewComtroller *Vc = [[ZYCameraViewComtroller alloc]init];
        Vc.TransDelegate = self;
        [self presentViewController:Vc animated:YES completion:nil];
    }else{
        NSLog(@"选中的照片位置 = %ld",indexPath.row);
        FZJBigPhotoController * bigPhoto = [[FZJBigPhotoController alloc]init];
        bigPhoto.fetchResult = self.fetchResult;
        bigPhoto.addNum = 9;
        bigPhoto.ChooseArr = self.selectedPhoto;
        bigPhoto.clickNum = indexPath.row - 1;
        bigPhoto.returnBlock = self.returnBlock;
    
        __weak __typeof(self) weakSelf = self;
        [bigPhoto returnBack:^(id data) {
            weakSelf.selectedPhoto = [NSMutableArray arrayWithArray:data];
            NSLog(@"选中数量发生变化'");
            [_imageList reloadData];
        }];
        self._blockJumpControl(bigPhoto);
    }
    
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
    CGSize size = CGSizeMake(40, 40); //缩略图尺寸是合适范围内尽量小，否则快速滑动界面会因内存爆满崩溃或者卡住
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

#pragma mark -- TransDelegate
- (void)transCameraImage:(UIImage *)image PHAsset:(PHAsset *)imageAsset
{
//    _fetchResult  = [[FZJPhotoTool alloc] getAllAssetInPhotoAblumWithAscending:YES];
//    [_imageList reloadData];
    FZJPhotoModel * model = [[FZJPhotoModel alloc]init];
    model.asset = imageAsset;
    model.imageName = [imageAsset valueForKey:@"filename"];
    [_selectedPhoto addObject:model];
    [_imageList reloadData];
 
}


#pragma mark - Photo library changed

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    // Call might come on any background queue. Re-dispatch to the main queue to handle it.
    NSLog(@"跟新资源文件");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *updatedFetchResults = nil;
        updatedFetchResults = [[[[FZJPhotoTool alloc]init]  getAllAssetInPhotoAblumWithAscending:YES] mutableCopy];
        if (updatedFetchResults)
        {
            self.fetchResult = [[updatedFetchResults reverseObjectEnumerator] allObjects];//倒序
        }
        [_imageList reloadData];
    });
}
@end
