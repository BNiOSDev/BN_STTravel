//
//  LBB_MyTravelViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyTravelViewController.h"
#import "SDAutoLayout.h"
#import "ZJMTravelCell.h"
#import "LBB_TravelModel.h"
#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"

#define MyTravelNormal  @"LBB_MyTravelTableViewCell"

#import "SDAutoLayout.h"
#import "ZJMTravelModel.h"
#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"
#import "LBB_TravelDownloadManager.h"

#define MyTravelNormal  @"LBB_MyTravelTableViewCell"

@interface LBB_MyTravelViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView    *mTableView;
@property(nonatomic, strong) LBB_TravelViewModel *viewModel;
@property(nonatomic, strong) NSMutableArray<BN_SquareTravelNotesModel*> *downloadedTravelArray;

@end

@implementation LBB_MyTravelViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"游记", nil);
    [self createTable];
    [self initDataSource];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)createTable
{
    CGRect mainRect = CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64.f);
    _mTableView = [[UITableView alloc]initWithFrame:mainRect style:UITableViewStyleGrouped];
   
    if(self.squareType == MyTravelsViewFravorite) {
         _mTableView.height = DeviceHeight - TopSegmmentControlHeight - 64;
    }
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor = [UIColor whiteColor];
    
    [self.mTableView registerClass:[LBB_MyTravelTableViewCell class] forCellReuseIdentifier:MyTravelNormal];
    [self.view  addSubview:_mTableView];
}

- (void)initDataSource
{
    if (!self.viewModel) {
        self.viewModel = [[LBB_TravelViewModel alloc] init];
    }
    //下载的直接取缓存在本地的下载数据
    if (self.travelviewType == MyTravelsViewDownloaed) {
        self.downloadedTravelArray = [[LBB_TravelDownloadManager sharedInstance] getTravelDetailArray];
        NSMutableArray *travelArray = [NSMutableArray arrayWithCapacity:self.downloadedTravelArray.count];
        for (int i = 0;i < self.downloadedTravelArray.count; i++) {
            BN_SquareTravelNotesModel *tmpModel = self.downloadedTravelArray[i];
            LBB_TravelModel *travelModel = [[LBB_TravelModel alloc] init];
            travelModel.travelNoteId = tmpModel.travelNotesId;//游记主键
            travelModel.travelNoteName = tmpModel.name;//游记名称
            travelModel.travelNotePicUrl = tmpModel.picUrl;//游记封面
            travelModel.releaseDate = tmpModel.lastReleaseTime;//发布日期
            travelModel.dayCount = 0;//天数
            travelModel.isLiked = tmpModel.isLiked;//是否点赞
            travelModel.isCollected = tmpModel.isCollected;//是否收藏
            travelModel.totalLike = tmpModel.totalLike;//赞数
            travelModel.totalComment = tmpModel.totalComment;//评论数
            travelModel.totalCollected = tmpModel.totalCollected;//收藏数
            [travelArray addObject:travelModel];
        }
        self.viewModel.travelArray = travelArray;
        [self.mTableView reloadData];
        
    }else {
        __weak typeof (self) weakSelf = self;
        [self.mTableView setHeaderRefreshDatablock:^{
            [weakSelf.viewModel getMyTravelList:YES VidewType:weakSelf.squareType];
        } footerRefreshDatablock:^{
            [weakSelf.viewModel getMyTravelList:NO VidewType:weakSelf.squareType];
        }];
        
        //设置绑定数组
        [self.mTableView setTableViewData:self.viewModel.travelArray];
        
        
        [self.viewModel.travelArray.loadSupport setDataRefreshblock:^{
            NSLog(@"数据刷新了");
        }];
        
        [self.mTableView loadData:self.viewModel.travelArray];
        
        //刷新数据
        
        [self.viewModel getMyTravelList:YES VidewType:self.squareType];
    }
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"wyl = 22222222");
    return self.viewModel.travelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBB_MyTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTravelNormal];
    cell.cellBlock = ^(id info,UICollectionViewCellSignal signal){
        [self dealCellSignal:signal withIndex:indexPath Object:info];
    };
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    cell.viewType = _travelviewType;
    cell.squareType = _squareType;
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    if (self.viewModel.travelArray.count > indexPath.row) {
         cell.model = self.viewModel.travelArray[indexPath.row];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    if(self.squareType == MySquareViewFravorite)
    {
         return AUTO(190);
    }
    return AUTO(215);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UICollectionViewCellSignal)signel  withIndex:(NSIndexPath *)indexPath Object:(id)infoObject
{
    LBB_TravelModel *travelModel = (LBB_TravelModel*)infoObject;
    __weak typeof (self) weakSelf = self;
    __weak typeof (LBB_TravelModel *) weakTravelModel = travelModel;
    
    [travelModel.loadSupport setDataRefreshblock:^{
        [weakSelf.mTableView reloadData];
    }];
    
    [travelModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code,NSString* remak){
        if (remak && [remak length]) {
            [weakSelf showHudPrompt:remak];
        }
    }];
    
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    switch (signel) {
        case UICollectionViewCellPraise://赞
        {
            [travelModel like];
        }
            break;
        case UICollectionViewCellComment://评论
        {
            LBB_TravelCommentController *vc = [[LBB_TravelCommentController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UICollectionViewCellHeart://爱心
        {
            
            [travelModel collect];
        }
            break;
        case UICollectionViewCellDelete://删除
        {
            if (self.travelviewType == MyTravelsViewDownloaed){
                [self deleteDownloadedTravelWithID:travelModel.travelNoteId successBlock:^(NSError* error){
                    [self.viewModel.travelArray removeObject:travelModel];
                    [self.mTableView reloadData];
                }];
            }else {
                [travelModel.loadSupport setDataRefreshblock:^{
                    for (int i = 0; i < weakSelf.viewModel.travelArray.count; i++) {
                        LBB_TravelModel *tmpModel = weakSelf.viewModel.travelArray[i];
                        if (tmpModel.travelNoteId == weakTravelModel.travelNoteId) {
                            
                            [weakSelf.viewModel.travelArray removeObject:tmpModel];
                            break;
                        }
                    }
                    [weakSelf.mTableView reloadData];
                }];
                
                [travelModel deleteTravel];
            }
        }
            break;
        case UICollectionViewCellCollection://收藏
        {
            [travelModel collect];
        }
            break;
        default:
            break;
    }
}

- (void)deleteDownloadedTravelWithID:(long)travelID successBlock:(void(^)(NSError* error))block
{
    for (int i = 0; i < self.downloadedTravelArray.count; i++) {
         BN_SquareTravelNotesModel *tmpModel = self.downloadedTravelArray[i];
        if (tmpModel.travelNotesId == travelID) {
            [[LBB_TravelDownloadManager sharedInstance] deleteTravelDetail:tmpModel succ:^(NSError* error){
                if (block) {
                    block(error);
                }
            }];
            break;
        }
    }
}

@end
