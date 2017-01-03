//
//  LBB_TravelGuideViewController.m
//  ST_Travel
//  我的-下载-攻略
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelGuideViewController.h"
#import "SDAutoLayout.h"
#import "ZJMTravelCell.h"
#import "LBB_TravelModel.h"
#import "LBB_TravelGuideModel.h"
#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"
#import "LBB_DiscoveryDetailViewController.h"
#import "LBB_StarRatingViewController.h"
#import "LBB_DiscoveryDownLoadManager.h"

#define MyTravelNormal  @"LBB_MyTravelTableViewCell"

@interface LBB_TravelGuideViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong) LBB_TravelGuideViewModelModel *viewModel;
@property(nonatomic, strong) NSMutableArray<LBB_DiscoveryDetailModel*> *downloadedTravelArray;
@end

@implementation LBB_TravelGuideViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"攻略", nil);
     [self createTable];
     [self initDataSource];
}
 
- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_TravelGuideViewModelModel alloc] init];
    }
    if (self.travelviewType == MyTravelsViewGuideDownloaed) {
        self.downloadedTravelArray = [[LBB_DiscoveryDownLoadManager sharedInstance] getDiscoveryDetailArray];
        NSMutableArray *travelArray = [NSMutableArray arrayWithCapacity:self.downloadedTravelArray.count];
        for (int i = 0;i < self.downloadedTravelArray.count; i++) {
            LBB_DiscoveryDetailModel *tmpModel = self.downloadedTravelArray[i];
            LBB_TravelGuideModel *travelModel = [[LBB_TravelGuideModel alloc] init];
            travelModel.lineId = tmpModel.lineId;//路线ID
            travelModel.coverImageUrl = tmpModel.coverImagesUrl;//列表上显示的图片
            travelModel.name = tmpModel.name;//标题
            
            travelModel.releaseDate  = nil;//发布日期
            travelModel.dayCount = 0;//天数
            
            travelModel.isCollected = tmpModel.isCollected;//收藏标志0未收藏 1：收藏
            travelModel.isLiked = tmpModel.isLiked;//点赞标志 0未点赞 1：点赞
            travelModel.likeNum = tmpModel.likeNum;//点赞次数
            travelModel.commentsNum = tmpModel.commentsNum;//评论条数
            travelModel.collecteNum = tmpModel.collecteNum;//收藏次数
            [travelArray addObject:travelModel];
        }
        self.viewModel.travelGuideArray = travelArray;
        [self.mTableView reloadData];
        
    }else {
        
        __weak typeof (self) weakSelf = self;
        [self.mTableView setHeaderRefreshDatablock:^{
            [weakSelf.viewModel getMyTravelGuideList:YES];
        } footerRefreshDatablock:^{
            [weakSelf.viewModel getMyTravelGuideList:NO];
        }];
        
        //设置绑定数组
        [self.mTableView setTableViewData:self.viewModel.travelGuideArray];
        
        [self.viewModel.travelGuideArray.loadSupport setDataRefreshblock:^{
            NSLog(@"数据刷新了");
        }];
        
        [self.mTableView loadData:self.viewModel.travelGuideArray];
        
        //刷新数据
        [weakSelf.viewModel getMyTravelGuideList:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; 
}

- (void)createTable
{
    _mTableView = [[UITableView alloc]initWithFrame:DeviceRect style:UITableViewStyleGrouped];
    CGRect mainRect = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64.f);
    _mTableView = [[UITableView alloc]initWithFrame:mainRect style:UITableViewStyleGrouped];
    if(self.travelviewType == MyTravelsGuideViewFravorite) {
        _mTableView.height = DeviceHeight - TopSegmmentControlHeight - 64;
    }
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = [UIColor whiteColor];
    
    [self.mTableView registerClass:[LBB_MyTravelTableViewCell class] forCellReuseIdentifier:MyTravelNormal];
    
    [self.view  addSubview:_mTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"wyl = 22222222");
    return self.viewModel.travelGuideArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_MyTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTravelNormal];
    cell.guideCellBlock = ^(id object,UICollectionViewCellSignal signal){
        [self dealCellSignal:signal withIndex:indexPath Object:object];
    };
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    cell.viewType = _travelviewType;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    if (indexPath.row < self.viewModel.travelGuideArray.count) {
        cell.guideModel = self.viewModel.travelGuideArray[indexPath.row];

    }
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.viewModel.travelGuideArray.count) {
        
        if (self.travelviewType == MyTravelsViewGuideDownloaed) {
            LBB_DiscoveryDetailViewController* dest = [[LBB_DiscoveryDetailViewController alloc]initWithDetailModel:self.downloadedTravelArray[indexPath.row]];
            [self.navigationController pushViewController:dest animated:YES];
        }
        else{
             LBB_TravelGuideModel *guideModel = self.viewModel.travelGuideArray[indexPath.row];
             LBB_DiscoveryDetailViewController* dest = [[LBB_DiscoveryDetailViewController alloc]init];
             dest.viewModel = [[LBB_DiscoveryModel alloc] init];
             dest.viewModel.lineId = guideModel.lineId;
            [self.navigationController pushViewController:dest animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    return AUTO(215);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UICollectionViewCellSignal)signel  withIndex:(NSIndexPath *)indexPath Object:(id)infoObject
{
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    LBB_TravelGuideModel *travelGuideModel = (LBB_TravelGuideModel*)infoObject;
    
    __weak typeof (self) weakSelf = self;
    __weak typeof (LBB_TravelGuideModel *) weakTravelModel = travelGuideModel;
    
    [travelGuideModel.loadSupport setDataRefreshblock:^{
        [weakSelf.mTableView reloadData];
    }];
    
    [travelGuideModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        if (remak && [remak length]) {
            [weakSelf showHudPrompt:remak];
        }
    }];

    
    switch (signel) {
        case UICollectionViewCellPraise://赞
        {
            [travelGuideModel like];
        }
            break;
        case UICollectionViewCellComment://评论
        {
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc] init];
            [self.navigationController pushViewController:dest animated:YES];
        }
            break;
        case UICollectionViewCellHeart://爱心
        {
            [travelGuideModel collect];
        }
            break;
        case UICollectionViewCellDelete://删除
        {
            if (self.travelviewType == MyTravelsViewGuideDownloaed){
                [self deleteDownloadedTravelWithID:travelGuideModel.lineId successBlock:^(NSError* error){
                    [self.viewModel.travelGuideArray removeObject:travelGuideModel];
                    [self.mTableView reloadData];
                }];
            }
        }
        default:
            break;
    }
}


- (void)deleteDownloadedTravelWithID:(long)lineID successBlock:(void(^)(NSError* error))block
{
    for (int i = 0; i < self.downloadedTravelArray.count; i++) {
        LBB_DiscoveryDetailModel *tmpModel = self.downloadedTravelArray[i];
        if (tmpModel.lineId == lineID) {
            [[LBB_DiscoveryDownLoadManager sharedInstance] deleteDiscoveryDetail:tmpModel succ:^(NSError* error){
                if (block) {
                    block(error);
                }
            }];
            break;
        }
    }
}
@end
