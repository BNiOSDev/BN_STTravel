//
//  LBBNearbyMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBNearbyMainViewController.h"
#import "KSViewPagerView.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBBNearbyMenuListTableViewCell.h"
#import "LBB_ScenicDetailViewController.h"
#import "LBB_NearViewModel.h"
#import "LBB_NearSign.h"
#import <BN_MapView.h>

@interface LBBNearbyMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) BN_MapView* mapView;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, assign)  LBBPoohSegmCtrlType selectType;

//地理位置管理
@property (nonatomic, retain)LBB_PoohCoreLocationManager* locationManager;
@property (nonatomic, strong)LBB_NearViewModel* viewModel;

@end

@implementation LBBNearbyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewModel{

    
    int distance = 1350000;
    self.locationManager = [[LBB_PoohCoreLocationManager alloc] init];

    self.viewModel = [[LBB_NearViewModel alloc]init];
    
    

    @weakify(self);
    /**
     3.9.2	附近 –美食\名宿\景点列表(已测)
     
     @param longitude Y坐标
     @param dimensionality X坐标
     @param distance 距离多少范围以内(单位米)
     @param allSpotsType 1.美食 2.民宿 3景点
     @param clear 是否清空原数据
     */
    
    [RACObserve(self.locationManager, latitude) subscribeNext:^(NSString* num) {
        @strongify(self);
        
        //景点
        [self.viewModel getSpotArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude distance:distance allSpotsType:3 clearData:YES];
        //美食
        [self.viewModel getSpotArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude distance:distance allSpotsType:1 clearData:YES];
        //民宿
        [self.viewModel getSpotArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude distance:distance allSpotsType:2 clearData:YES];
        
        //附近的商家
        [self.viewModel getNearSignInMapArrayClearData:self.locationManager.longitude  dimensionality:self.locationManager.latitude clear:YES];

    }];
    WS(ws);
    [self.viewModel.nearShopArray.loadSupport setDataRefreshblock:^{
        
        [ws.mapView removeAllAnnotation];
        [ws.mapView setDelta:0.2 Latitude:[ws.locationManager.latitude floatValue] longitude:[ws.locationManager.longitude floatValue]];
        for (LBB_NearShopModel* model in ws.viewModel.nearShopArray) {
            
            [ws.mapView andAnnotationLatitude:[model.dimensionality floatValue] longitude:[model.longitude floatValue]];
        }
    }];
    //景点
  //  [self.viewModel getSpotArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude distance:distance allSpotsType:3 clearData:YES];
    
    [self.viewModel.spotArray.loadSupport setDataRefreshblock:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    //美食
 //   [self.viewModel getSpotArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude distance:distance allSpotsType:1 clearData:YES];
    [self.viewModel.foodsArray.loadSupport setDataRefreshblock:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    //民宿
 //   [self.viewModel getSpotArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude distance:distance allSpotsType:2 clearData:YES];
    [self.viewModel.hostelArray.loadSupport setDataRefreshblock:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    //3.0 table view 的数据绑定，刷新，上拉刷新，下拉加载。全部集成在里面
    [self.tableView setTableViewData:self.viewModel.spotArray];

    
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        
        switch (ws.selectType) {
            case LBBPoohSegmCtrlScenicType://景点
            {
                [ws.viewModel getSpotAdvertisementListArrayClearData:YES];
                [ws.viewModel getSpotArrayLongitude:ws.locationManager.longitude dimensionality:ws.locationManager.latitude distance:distance allSpotsType:3 clearData:YES];
            }
                break;
            case LBBPoohSegmCtrlFoodsType://美食
            {
                [ws.viewModel getFoodAdvertisementListArrayClearData:YES];
                [ws.viewModel getSpotArrayLongitude:ws.locationManager.longitude dimensionality:ws.locationManager.latitude distance:distance allSpotsType:1 clearData:YES];
            }
                break;
            case LBBPoohSegmCtrlHostelType://民宿
            {
                [ws.viewModel getHostelAdvertisementListArrayClearData:YES];
                [ws.viewModel getSpotArrayLongitude:ws.locationManager.longitude dimensionality:ws.locationManager.latitude distance:distance allSpotsType:2 clearData:YES];
                
            }
                break;
        }
        [ws.tableView.mj_header endRefreshing];
    } footerRefreshDatablock:^{
        switch (ws.selectType) {
            case LBBPoohSegmCtrlScenicType://景点
            {
                [ws.viewModel getSpotArrayLongitude:ws.locationManager.longitude dimensionality:ws.locationManager.latitude distance:distance allSpotsType:3 clearData:NO];
            }
                break;
            case LBBPoohSegmCtrlFoodsType://美食
            {
                [ws.viewModel getSpotArrayLongitude:ws.locationManager.longitude dimensionality:ws.locationManager.latitude distance:distance allSpotsType:1 clearData:NO];
            }
                break;
            case LBBPoohSegmCtrlHostelType://民宿
            {
                [ws.viewModel getSpotArrayLongitude:ws.locationManager.longitude dimensionality:ws.locationManager.latitude distance:distance allSpotsType:2 clearData:NO];
                
            }
                break;
        }
        [ws.tableView.mj_footer endRefreshing];
        
    }];
    
    
#pragma AD
    
    /**
     3.1.1 广告轮播 8 附近景点广告
     
     @param clear 是否清空原数据
     */
    [self.viewModel getSpotAdvertisementListArrayClearData:YES];
    [self.viewModel.spotAdvertisementArray.loadSupport setDataRefreshblock:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    /**
     3.1.1 广告轮播 9附近美食广告
     
     @param clear 是否清空原数据
     */
    [self.viewModel getFoodAdvertisementListArrayClearData:YES];
    [self.viewModel.foodAdvertisementArray.loadSupport setDataRefreshblock:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    /**
     3.1.1 广告轮播 10 附近民宿广告
     
     @param clear 是否清空原数据
     */
    [self.viewModel getHostelAdvertisementListArrayClearData:YES];
    [self.viewModel.hostelAdvertisementArray.loadSupport setDataRefreshblock:^{
        @strongify(self);
        [self.tableView reloadData];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 * setup Navigation UI
 */

-(void)loadCustomNavigationButton{
    self.title = @"附近";
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题

    self.mapView = [[BN_MapView alloc] init];
    [self.mapView setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
    [self.mapView setFrame:CGRectMake(0, 0, DeviceWidth, AutoSize(490/2))];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBBNearbyMenuListTableViewCell class] forCellReuseIdentifier:@"LBBNearbyMenuListTableViewCell"];
    [self initViewModel];

    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];

    self.tableView.tableHeaderView = self.mapView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    


}


#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AutoSize(TopSegmmentControlHeight);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    NSArray* segmentArray = @[@"景点",@"美食",@"民宿"];

    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
    segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font14,
                                             NSForegroundColorAttributeName:ColorLightGray};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:Font14,
                                                     NSForegroundColorAttributeName:ColorBtnYellow};
    segmentedControl.selectionIndicatorColor = [UIColor clearColor];
    segmentedControl.verticalDividerWidth = SeparateLineWidth;
    segmentedControl.verticalDividerColor = ColorLightGray;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectedSegmentIndex = self.selectType;
    [v addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(v);
    }];
    WS(ws);
    segmentedControl.indexChangeBlock = ^(NSInteger index){
        NSLog(@"segmentedControl select:%ld",index);
        ws.selectType = index;
        switch (ws.selectType) {
            case LBBPoohSegmCtrlScenicType://景点
                [ws.tableView setTableViewData:ws.viewModel.spotArray];
                break;
            case LBBPoohSegmCtrlFoodsType://美食
                [ws.tableView setTableViewData:ws.viewModel.foodsArray];
                
                break;
            case LBBPoohSegmCtrlHostelType://民宿
                [ws.tableView setTableViewData:ws.viewModel.hostelArray];
                break;
            default:
                break;
        }
        [ws.tableView reloadData];
    };

    return v;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger row = 0;
    switch (self.selectType) {
        case LBBPoohSegmCtrlScenicType://景点
            row = self.viewModel.spotArray.count + 1;
            break;
        case LBBPoohSegmCtrlFoodsType://美食
            row = self.viewModel.foodsArray.count + 1;
            break;
        case LBBPoohSegmCtrlHostelType://民宿
            row = self.viewModel.hostelArray.count + 1;
            break;
    }
    
    return row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.row == 0) {
        return  [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
            [cell setCycleScrollViewHeight:AutoSize(226/2)];
            switch (self.selectType) {
                case LBBPoohSegmCtrlScenicType://景点
                    [cell setAdModelArray:ws.viewModel.spotAdvertisementArray];
                    break;
                case LBBPoohSegmCtrlFoodsType://美食
                    [cell setAdModelArray:ws.viewModel.foodAdvertisementArray];
                    break;
                case LBBPoohSegmCtrlHostelType://民宿
                    [cell setAdModelArray:ws.viewModel.hostelAdvertisementArray];
                    break;
            }
        }];
    }
    else{
        return  [tableView fd_heightForCellWithIdentifier:@"LBBNearbyMenuListTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBNearbyMenuListTableViewCell* cell){

            LBB_SpotModel* obj;
            switch (self.selectType) {
                case LBBPoohSegmCtrlScenicType://景点
                    obj = ws.viewModel.spotArray[indexPath.row - 1];
                    break;
                case LBBPoohSegmCtrlFoodsType://美食
                    obj = ws.viewModel.foodsArray[indexPath.row - 1];
                    break;
                case LBBPoohSegmCtrlHostelType://民宿
                    obj = ws.viewModel.hostelArray[indexPath.row - 1];
                    break;
            }
            
            [cell setModel:obj];
            
        }];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) { //ad
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
        }
        [cell setCycleScrollViewHeight:AutoSize(226/2)];
        switch (self.selectType) {
            case LBBPoohSegmCtrlScenicType://景点
                [cell setAdModelArray:self.viewModel.spotAdvertisementArray];
                break;
            case LBBPoohSegmCtrlFoodsType://美食
                [cell setAdModelArray:self.viewModel.foodAdvertisementArray];
                break;
            case LBBPoohSegmCtrlHostelType://民宿
                [cell setAdModelArray:self.viewModel.hostelAdvertisementArray];
                break;
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBBNearbyMenuListTableViewCell";
        LBBNearbyMenuListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBNearbyMenuListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
            NSLog(@"LBBNearbyMenuListTableViewCell nil");
        }
        
        LBB_SpotModel* obj;
        switch (self.selectType) {
            case LBBPoohSegmCtrlScenicType://景点
                obj = self.viewModel.spotArray[indexPath.row - 1];
                break;
            case LBBPoohSegmCtrlFoodsType://美食
                obj = self.viewModel.foodsArray[indexPath.row - 1];
                break;
            case LBBPoohSegmCtrlHostelType://民宿
                obj = self.viewModel.hostelArray[indexPath.row - 1];
                break;
        }
        
        [cell setModel:obj];
                
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    switch (self.selectType) {
        case LBBPoohSegmCtrlScenicType://景点
            dest.homeType = LBBPoohHomeTypeScenic;
            dest.spotModel = self.viewModel.spotArray[indexPath.row];
            break;
        case LBBPoohSegmCtrlFoodsType://美食
            dest.homeType = LBBPoohHomeTypeFoods;
            dest.spotModel = self.viewModel.foodsArray[indexPath.row];
            break;
        case LBBPoohSegmCtrlHostelType://民宿
            dest.homeType = LBBPoohHomeTypeHostel;
            dest.spotModel = self.viewModel.hostelArray[indexPath.row];
            break;
    }
    if (dest) {
        [self.navigationController pushViewController:dest animated:YES];
    }
    
}

@end
