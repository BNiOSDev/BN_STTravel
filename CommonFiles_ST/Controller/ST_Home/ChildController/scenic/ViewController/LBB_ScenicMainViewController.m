//
//  LBB_ScenicMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicMainViewController.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBB_ScenicMainTableViewCell.h"
#import "LBB_ScenicSearchViewController.h"
#import "LBB_ScenicDetailViewController.h"
#import "LBB_FilterTableViewCell.h"
#import "LBB_FilterListTableViewCell.h"
#import "LBB_ScenicViewModel.h"
#import "LBB_PoohCoreLocationManager.h"
#import "LBB_HomeSearchViewController.h"
@interface LBB_ScenicMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) UISearchBar *searchBar;

//菜单选项
@property (nonatomic, retain) NSArray* categoryArray;//类别
@property (nonatomic, retain) NSArray* sortArray;//排序
    
@property(nonatomic, retain)LBB_ScenicViewModel* viewModel;//数据模型

//菜单选项的选择项
@property (nonatomic,assign)NSInteger typeSelectIndex;//类别
@property (nonatomic,assign)NSInteger orderSelectIndex;//排序
@property (nonatomic,assign)NSInteger hotRecommendSelectIndex;//热门推荐
@property (nonatomic,assign)NSInteger tagsSelectIndex;//标签
@property (nonatomic,assign)NSInteger priceSelectIndex;//价格

//地理位置管理
@property (nonatomic,retain)LBB_PoohCoreLocationManager* locationManager;

@end

@implementation LBB_ScenicMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //菜单选项的选择项
    self.typeSelectIndex = -1;//类别
    self.orderSelectIndex = -1;//排序
    self.hotRecommendSelectIndex = -1;//热门推荐
    self.tagsSelectIndex = -1;//标签
    self.priceSelectIndex = -1;//价格
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
 *  init view Model
 */
-(void)initViewModel{
    WS(ws);

    self.viewModel = [[LBB_ScenicViewModel alloc]init];
    
    /**
     3.2.1	景点筛选条件(已测)
     */
#pragma 景点类别和标签的价格没有数据
    [self.viewModel getSpotCondition];
    [self.viewModel.scenicSpotCondition.loadSupport setDataRefreshblock:^{
        [ws getSpotArrayLongitude:YES];
    }];
   

    /**
     3.1.2 广告轮播 4.景点页面最顶部
     @param clear 是否清空原数据
     */
    [self.viewModel getAdvertisementListArrayClearData:YES];
    //1.监听数据，用来刷新数据，数据变化才会调用
    [self.viewModel.advertisementArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];
   
    /**
     3.2.4	景点列表(已测)
     
     @param longitude Y坐标
     @param dimensionality Y坐标
     @param typeKey 传入景点类型key
     @param orderKey 传入排序key
     @param hotRecommendKey 热门推荐key
     @param tagsKey 标签key
     @param priceKey 价格Key
     */
    [self.viewModel.spotArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
    }];
#pragma 响应处理
    //2.0响应的view，网络状态变化时的再刷新动作
    //  [self.tableView setTableViewData:self.viewModel.advertisementArray];
    //2.1点击刷新
    /* [ws.tableView setRefreshBlock:^{
     [ws.viewModel getAdvertisementListArrayClearData:NO];
     }];
     */
    //3.0 table view 的数据绑定，刷新，上拉刷新，下拉加载。全部集成在里面
     [self.tableView setTableViewData:self.viewModel.spotArray];
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        
        [ws.viewModel getAdvertisementListArrayClearData:YES];//       3.1.2 广告轮播 4.景点页面最顶部
        [ws.viewModel getSpotCondition];// 3.2.1	景点筛选条件(已测)
        [ws getSpotArrayLongitude:YES];

       
    } footerRefreshDatablock:^{
         [ws.tableView.mj_footer endRefreshing];
        [ws getSpotArrayLongitude:NO];
    }];
    @weakify(self);
    [RACObserve(self.locationManager, latitude) subscribeNext:^(NSString* num) {
        @strongify(self);
        
        [self getSpotArrayLongitude:YES];
        if ([num floatValue] != -1) {
            [self.locationManager.locManager stopUpdatingLocation];
        }
    }];
}


/**
 3.2.4	景点列表(已测)


 @param clear 是否清空原数据
 */
-(void)getSpotArrayLongitude:(BOOL)clear{

    int typeKey = -1;//类别
    int orderKey = -1;//排序
    int hotRecommendKey = -1;//热门推荐
    int tagsKey = -1;//标签
    int priceKey = -1;//价格

    
    if (self.viewModel.scenicSpotCondition.type.count > 0) {
        
        if (self.typeSelectIndex >= 0) {
            LBB_ScenicSpotConditionOption* typeObj = [self.viewModel.scenicSpotCondition.type objectAtIndex:self.typeSelectIndex];
            typeKey = typeObj.key;
        }
    }
    
    if (self.viewModel.scenicSpotCondition.order.count > 0) {
        if (self.orderSelectIndex >= 0) {
            LBB_ScenicSpotConditionOption* orderObj = [self.viewModel.scenicSpotCondition.order objectAtIndex:self.orderSelectIndex];
            orderKey = orderObj.key;
        }
    }
    
    if (self.viewModel.scenicSpotCondition.hotRecommend.count > 0) {
        if (self.hotRecommendSelectIndex >= 0) {
            LBB_ScenicSpotConditionOption* hotRecommendObj = [self.viewModel.scenicSpotCondition.hotRecommend objectAtIndex:self.hotRecommendSelectIndex];
            hotRecommendKey = hotRecommendObj.key;
        }
    }
    
    if (self.viewModel.scenicSpotCondition.tags.count > 0) {
        if (self.tagsSelectIndex >= 0) {
            LBB_ScenicSpotConditionOption* tagsObj = [self.viewModel.scenicSpotCondition.tags objectAtIndex:self.tagsSelectIndex];
            tagsKey = tagsObj.key;
        }
    }
    
    if (self.viewModel.scenicSpotCondition.price.count > 0) {
        if (self.priceSelectIndex >= 0) {
            LBB_ScenicSpotConditionOption* priceObj = [self.viewModel.scenicSpotCondition.price objectAtIndex:self.priceSelectIndex];
            priceKey = priceObj.key;
        }
    }
    
    
    NSLog(@"纬度latitude:%@",self.locationManager.latitude);
    NSLog(@"经度longitude:%@",self.locationManager.longitude);

#pragma 以下全部使用默认值，测试数据
   /*  typeKey = -1;//类别
     orderKey = -1;//排序
     hotRecommendKey = -1;//热门推荐
     tagsKey = -1;//标签
     priceKey = -1;//价格
   */
    
    [self.viewModel getSpotArrayLongitude:self.locationManager.longitude//精度
                           dimensionality:self.locationManager.latitude//维度
                                  typeKey:typeKey
                                 orderKey:orderKey
                          hotRecommendKey:hotRecommendKey
                                  tagsKey:tagsKey
                                 priceKey:priceKey
                                clearData:clear];
    
}


/*
 * setup Navigation UI
 */

-(void)loadCustomNavigationButton{
 //   WS(ws);
    [super loadCustomNavigationButton];
   self.title = @"景点";
    UIButton *search = [[UIButton alloc] init];
    search.titleLabel.font = Font14;
   // [search setTitle:@"搜索" forState:UIControlStateNormal];
   // [search setImage:IMAGE(@"景区列表_搜索") forState:UIControlStateNormal];
    [search setImage:IMAGE(@"景区列表_搜索") forState:UIControlStateNormal];

    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    search.frame = CGRectMake(0, 0, 45, 45);
    [search bk_addEventHandler:^(id sender){
        
       /* LBB_ScenicSearchViewController* dest = [[LBB_ScenicSearchViewController alloc]init];
        dest.placeHolderString = @"输入关键字搜索景点";
        dest.click = ^(LBB_ScenicSearchViewController* v , NSIndexPath* indexPath){
            
            NSLog(@"选择搜索的数据:%ld",indexPath.row);
            [v.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        */
        
        LBB_HomeSearchViewController* searchVC = [[LBB_HomeSearchViewController alloc]init];
        searchVC.searchType = LBBPoohHomeSearchTypeScenic;
        [self.navigationController pushViewController:searchVC animated:YES];
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = searchItem;
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSArray* segmentArray = @[@"景点类别",@"排序",@"标签"];
    self.categoryArray = @[
                            @[@"全部",@"景点类别全部",@"景点类别全部HL"],
                            @[@"城市观光",@"景点类别城市观光",@"景点类别城市观光HL"],
                            @[@"水上乐园",@"景点类别水上游玩",@"景点类别水上游玩HL"],
                            @[@"展览馆",@"景点类别展览馆",@"景点类别展览馆HL"],
                            @[@"文化古迹",@"景点类别文化古迹",@"景点类别文化古迹HL"],
                            @[@"自然风光",@"景点类别自然风光",@"景点类别自然风光"],
                           ];
    self.sortArray = @[
                           @[@"智能排序",@"景区排序_智能排序",@"景区排序_智能排序HL"],
                           @[@"销量优先",@"景区排序_销量优先",@"景区排序_销量优先HL"],
                           @[@"离我最近",@"景区排序_离我最近",@"景区排序_离我最近HL"],
                           @[@"评价最高",@"景区排序_评价最高",@"景区排序_评价最高HL"],
                           ];

    BN_FilterMenu* segmentedControl = [[BN_FilterMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, AutoSize(TopSegmmentControlHeight))];;
    [segmentedControl setTextColor:ColorGray];
    [segmentedControl setSelectedTextColor:ColorBtnYellow];
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = ColorLine.CGColor;
    segmentedControl.menuArray = segmentArray;
    [self.view addSubview:segmentedControl];
    
    //返回section数组
    [segmentedControl getMenuDataSectionArrayInBlock:^NSArray*(NSInteger index, NSString *title){
        if (index == 2) {
            return @[
                     @[@"热门推荐",@"景区标签_热门"],
                     @[@"标签",@"景区标签_标签"],
                     @[@"价格",@"景区标签_价格"],
                     ];
        }
        return @[@""];
    }];
    [segmentedControl getSectionInBlock:^UIView*(NSInteger index, NSInteger section, id data){
        
        if (index == 2) {
            CGFloat height = AutoSize(56/2);
            CGFloat margin = 10;
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, height)];
            [view setBackgroundColor:ColorWhite];
            NSString* title = [data objectAtIndex:0];
            NSString* imageName = [data objectAtIndex:1];
            
            UIImageView* imageView = [UIImageView new];
            [imageView setImage:IMAGE(imageName)];
            [view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker* make){
                
                make.centerY.equalTo(view);
                make.left.equalTo(view).offset(margin);
            }];
            
            UILabel* titleLabel = [UILabel new];
            [titleLabel setFont:Font15];
            [titleLabel setTextColor:ColorGray];
            [titleLabel setText:title];
            [view addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
                
                make.centerY.equalTo(view);
                make.left.equalTo(imageView.mas_right).offset(margin/3);
            }];
        
            UIImageView* arrowView = [UIImageView new];
            [arrowView setImage:IMAGE(@"景点专题_箭头Down")];
            [view addSubview:arrowView];
            [arrowView mas_makeConstraints:^(MASConstraintMaker* make){
                make.centerY.equalTo(view);
                make.right.equalTo(view).offset(-20);
            }];
            
            return view;
        }
        return [UIView new];
    }];
    [segmentedControl heightForSectionInBlock:^CGFloat(NSInteger index, NSInteger section,id data){
        if (index == 2) {
            return AutoSize(56/2);
        }
        return 0;
    }];
    //返回数据数组
    [segmentedControl getMenuDataRowArrayInBlock:^NSArray*(NSInteger index, NSString *title, NSInteger section){
    
        if (index == 0) {//类别
            return ws.viewModel.scenicSpotCondition.type;
        }
        else if (index == 1){//排序
            return ws.viewModel.scenicSpotCondition.order;
        }
        else{//标签
            if (section == 0) {//热门推荐
                if (ws.viewModel.scenicSpotCondition.hotRecommend.count <= 0) {
                    return @[];
                }
                return @[ws.viewModel.scenicSpotCondition.hotRecommend];

            }
            else if (section == 1){//标签
                if (ws.viewModel.scenicSpotCondition.tags.count <= 0) {
                    return @[];
                }
                return @[ws.viewModel.scenicSpotCondition.tags];

            }
            else{//价格
                if (ws.viewModel.scenicSpotCondition.price.count <= 0) {
                    return @[];
                }
                return @[ws.viewModel.scenicSpotCondition.price];

            }
        
        }
    }];
    //返回每行的高度
    [segmentedControl heightForRowInBlock:^CGFloat(NSInteger index, NSIndexPath *indexPath, id data) {
        if (index == 2) {
            return [LBB_FilterTableViewCell getCellHeight:data];
        }
        return AutoSize(40);
    }];
    //返回cell
    [segmentedControl getCellInBlock:^UITableViewCell*(NSInteger index, NSIndexPath *indexPath, id data) {
        NSLog(@"data:%@",data);
        
        if (index < 2) {
            static NSString *cellIdentifier = @"LBB_FilterListTableViewCell";
            LBB_FilterListTableViewCell* cell = [[LBB_FilterListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            LBB_ScenicSpotConditionOption* obj = (LBB_ScenicSpotConditionOption*)data;
            NSLog(@"LBB_ScenicSpotConditionOption:%@",data);
           // NSString* title = [data objectAtIndex:0];
            NSString* imageName;
            NSString* imageNameHL ;
            NSInteger selectIndex = 0;
            if (index == 0) {//类别
                
                NSInteger index = indexPath.row;
                if (index >= ws.categoryArray.count) {
                    index = ws.categoryArray.count - 1;
                }
                imageName = [[ws.categoryArray objectAtIndex:index] objectAtIndex:1];
                imageNameHL = [[ws.categoryArray objectAtIndex:index] objectAtIndex:2];
                selectIndex = ws.typeSelectIndex;
            }
            else{//排序
                NSInteger index = indexPath.row;
                if (index >= ws.sortArray.count) {
                    index = ws.sortArray.count - 1;
                }
                imageName = [[ws.sortArray objectAtIndex:index] objectAtIndex:1];
                imageNameHL = [[ws.sortArray objectAtIndex:index] objectAtIndex:2];
                selectIndex = ws.orderSelectIndex;

            }

            [cell.imageView setImage:IMAGE(imageName)];
            [cell.textLabel setText:obj.name];
            [cell.textLabel setFont:Font15];
            [cell.textLabel setTextColor:ColorGray];
            cell.tintColor = ColorBtnYellow;
            
            if (indexPath.row == selectIndex) {
                [cell.imageView setImage:IMAGE(imageNameHL)];
                [cell.textLabel setTextColor:ColorBtnYellow];
                UIImageView* accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize(13), AutoSize(11))];
                [accessoryView setImage:IMAGE(@"景区排序_打钩")];
                cell.accessoryView = accessoryView;
            }
            
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"LBB_FilterTableViewCell";
            LBB_FilterTableViewCell* cell = [[LBB_FilterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.bottomMargin = AutoSize(15);
            
            NSLog(@"array:%@",data);
          //  LBB_ScenicSpotConditionOption* obj = (LBB_ScenicSpotConditionOption*)data;

            if (indexPath.section == 0) {//热门推荐
                cell.selectIndex = ws.hotRecommendSelectIndex;
            }
            else if (indexPath.section == 1){//标签
                cell.selectIndex = ws.tagsSelectIndex;
            }
            else{//价格
                cell.selectIndex = ws.priceSelectIndex;
            }
            
            NSArray* dataArray = [data map:^id(LBB_ScenicSpotConditionOption* model){
                return model.name;
            }];
            NSLog(@"dataArray:%@",dataArray);

            [cell configContentView:dataArray];

            cell.click = ^(NSNumber* num){
                if (indexPath.section == 0) {//热门推荐
                   ws.hotRecommendSelectIndex = [num integerValue];
                }
                else if (indexPath.section == 1){//标签
                    ws.tagsSelectIndex = [num integerValue];
                }
                else{//价格
                    ws.priceSelectIndex = [num integerValue];
                }
                [segmentedControl reloadData];

            };
            return cell;
        }
       
    }];
    //cell的选中动作
    [segmentedControl didDeselectRowAtIndexPathBlock:^(NSInteger index, NSIndexPath *indexPath, id data) {
        NSLog(@"index:%ld,选择 %@",index,data);
        
        if (index == 0) {//类别
            ws.typeSelectIndex = indexPath.row;
            [segmentedControl closeMenu];

        }
        else if (index == 1){//排序
            ws.orderSelectIndex = indexPath.row;
            [segmentedControl closeMenu];
        }
        [ws getSpotArrayLongitude:YES];

    }];
    
    //返回bottomView
    [segmentedControl getMenuBottomViewInBlock:^UIView*(NSInteger index, NSString *title){

        if (index < 2) {
            return nil;
        }
        
        UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, AutoSize(70/2))];
        
        CGFloat width = DeviceWidth* 220/640;
        
        UIButton* cancelButton = [UIButton new];
        [cancelButton setBackgroundColor:ColorWhite];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:Font13];
        [cancelButton setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        [bottomView addSubview:cancelButton];
        
        UIButton* confirmButton = [UIButton new];
        [confirmButton setBackgroundColor:ColorBtnYellow];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton.titleLabel setFont:Font13];
        [confirmButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [bottomView addSubview:confirmButton];
        
        [cancelButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.top.bottom.equalTo(bottomView);
            make.width.mas_equalTo(width);
        }];
        
        [confirmButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(cancelButton.mas_right);
            make.top.bottom.right.equalTo(bottomView);
        }];
        
        [cancelButton bk_whenTapped:^{
            [segmentedControl closeMenu];
        }];
        
        
        [confirmButton bk_whenTapped:^{
            [segmentedControl closeMenu];
            [ws getSpotArrayLongitude:YES];
        }];
        
        return bottomView;
        
    }];
    
    self.locationManager = [[LBB_PoohCoreLocationManager alloc] init];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBB_ScenicMainTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicMainTableViewCell"];
    [self initViewModel];

    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segmentedControl.mas_bottom);
        make.width.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
}


#pragma tableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.spotArray.count + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell *cell) {
            
            [cell setCycleScrollViewHeight:AutoSize(460/2)];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicMainTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicMainTableViewCell *cell) {
            [cell showTopSepLine:YES];
            [cell setModel:[ws.viewModel.spotArray objectAtIndex:indexPath.section - 1]];
        }];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  //  WS(ws);
    if (indexPath.section == 0) { //ad
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
        }
        [cell setCycleScrollViewHeight:AutoSize(460/2)];
        [cell setAdModelArray:self.viewModel.advertisementArray];//设置model。热门推荐广告的数据
        
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_ScenicMainTableViewCell";
        LBB_ScenicMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicMainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicMainTableViewCell nil");
        }
        [cell showTopSepLine:YES];
        [cell setModel:[self.viewModel.spotArray objectAtIndex:indexPath.section - 1]];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  //  [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    dest.homeType = LBBPoohHomeTypeScenic;
    dest.spotModel = [self.viewModel.spotArray objectAtIndex:indexPath.section - 1];
    [self.navigationController pushViewController:dest animated:YES];
}

@end
