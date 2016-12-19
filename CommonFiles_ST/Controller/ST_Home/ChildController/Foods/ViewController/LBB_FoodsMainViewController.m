//
//  LBB_ScenicMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FoodsMainViewController.h"
#import "LBB_ScenicMainTableViewCell.h"
#import "LBB_ScenicSearchViewController.h"
#import "LBB_ScenicDetailViewController.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBB_FoodsMainMenuCell.h"
#import "LBB_FilterTableViewCell.h"
#import "LBB_FilterListTableViewCell.h"
#import "LBB_FoodsViewModel.h"
#import "LBB_HomeSearchViewController.h"
@interface LBB_FoodsMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) UISearchBar *searchBar;

//菜单选项
@property (nonatomic, retain) NSArray* categoryArray;//类别
@property (nonatomic, retain) NSArray* sortArray;//排序

@property(nonatomic, retain)LBB_FoodsViewModel* viewModel;//数据模型

//菜单选项的选择项
@property (nonatomic,assign)NSInteger areaSelectIndex;//区域
@property (nonatomic,assign)NSInteger distanceSelectIndex;//距离

@property (nonatomic,assign)NSInteger typeSelectIndex;//类别
@property (nonatomic,assign)NSInteger orderSelectIndex;//排序
@property (nonatomic,assign)NSInteger hotRecommendSelectIndex;//热门推荐
@property (nonatomic,assign)NSInteger tagsSelectIndex;//标签
@property (nonatomic,assign)NSInteger priceSelectIndex;//价格

//地理位置管理
@property (nonatomic,retain)LBB_PoohCoreLocationManager* locationManager;

@end

@implementation LBB_FoodsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //菜单选项的选择项
    self.areaSelectIndex = -1;//区域
    self.distanceSelectIndex = -1;//距离
    
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
    
    self.viewModel = [[LBB_FoodsViewModel alloc]init];
    
    /**
     3.2.1	景点筛选条件(已测)
     */
#pragma 景点类别和标签的价格没有数据
    [self.viewModel getFoodsCondition];
    [self.viewModel.foodsCondition.loadSupport setDataRefreshblock:^{
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
    [self.viewModel.foodsArray.loadSupport setDataRefreshblock:^{
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
    [self.tableView setTableViewData:self.viewModel.foodsArray];
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        
        [ws.viewModel getAdvertisementListArrayClearData:YES];//       3.1.2 广告轮播 4.景点页面最顶部
        [ws.viewModel getFoodsCondition];// 3.2.1	景点筛选条件(已测)
        [ws getSpotArrayLongitude:YES];

        
    } footerRefreshDatablock:^{
        [ws getSpotArrayLongitude:NO];
        [ws.tableView.mj_footer endRefreshing];
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
    int areaKey = -1;//区域
    int distanceKey = -1;//距离
    
    if (self.viewModel.foodsCondition.type.count > 0) {
        if (self.typeSelectIndex >= 0) {
            LBB_FoodsConditionOption* typeObj = [self.viewModel.foodsCondition.type objectAtIndex:self.typeSelectIndex];
            typeKey = typeObj.key;
        }
    }
    
    if (self.viewModel.foodsCondition.order.count > 0) {
        if (self.orderSelectIndex >= 0) {
            LBB_FoodsConditionOption* orderObj = [self.viewModel.foodsCondition.order objectAtIndex:self.orderSelectIndex];
            orderKey = orderObj.key;
        }
    }
    
    if (self.viewModel.foodsCondition.hotRecommend.count > 0) {
        if (self.hotRecommendSelectIndex >= 0) {
            LBB_FoodsConditionOption* hotRecommendObj = [self.viewModel.foodsCondition.hotRecommend objectAtIndex:self.hotRecommendSelectIndex];
            hotRecommendKey = hotRecommendObj.key;
        }
    }
    
    if (self.viewModel.foodsCondition.tags.count > 0) {
        if (self.tagsSelectIndex >= 0) {
            LBB_FoodsConditionOption* tagsObj = [self.viewModel.foodsCondition.tags objectAtIndex:self.tagsSelectIndex];
            tagsKey = tagsObj.key;
        }
    }
    
    if (self.viewModel.foodsCondition.price.count > 0) {
        if (self.priceSelectIndex >= 0) {
            LBB_FoodsConditionOption* priceObj = [self.viewModel.foodsCondition.price objectAtIndex:self.priceSelectIndex];
            priceKey = priceObj.key;
        }
    }
    
    if (self.viewModel.foodsCondition.tradingArea.count > 0) {
        if (self.areaSelectIndex >= 0) {
            LBB_FoodsConditionOption* areaObj = [self.viewModel.foodsCondition.tradingArea objectAtIndex:self.areaSelectIndex];
            areaKey = areaObj.key;
        }
    }
    
    if (self.viewModel.foodsCondition.distance.count > 0) {
        if (self.distanceSelectIndex >= 0) {
            LBB_FoodsConditionOption* distanceObj = [self.viewModel.foodsCondition.distance objectAtIndex:self.distanceSelectIndex];
            distanceKey = distanceObj.key;
        }
    }
    
    NSLog(@"纬度latitude:%@",self.locationManager.latitude);
    NSLog(@"经度longitude:%@",self.locationManager.longitude);
    
#pragma 以下全部使用默认值，测试数据
   /* typeKey = -1;//类别
    orderKey = -1;//排序
    hotRecommendKey = -1;//热门推荐
    tagsKey = -1;//标签
    priceKey = -1;//价格
    areaKey = -1;//区域
    distanceKey = -1;//距离
*/
    [self.viewModel getFoodsArrayLongitude:self.locationManager.longitude//精度
                           dimensionality:self.locationManager.latitude//维度
                            tradingAreaKey:areaKey
                                  distance:distanceKey
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
  //  WS(ws);
    [super loadCustomNavigationButton];
    self.title = @"美食";
    UIButton *search = [[UIButton alloc] init];
    search.titleLabel.font = Font14;
    // [search setTitle:@"搜索" forState:UIControlStateNormal];
    // [search setImage:IMAGE(@"景区列表_搜索") forState:UIControlStateNormal];
    [search setImage:IMAGE(@"景区列表_搜索") forState:UIControlStateNormal];
    
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    search.frame = CGRectMake(0, 0, 25, 25);
    [search bk_addEventHandler:^(id sender){
        
       /* LBB_ScenicSearchViewController* dest = [[LBB_ScenicSearchViewController alloc]init];
        dest.placeHolderString = @"输入关键字搜索美食";
        dest.click = ^(LBB_ScenicSearchViewController* v , NSIndexPath* indexPath){
            
            NSLog(@"选择搜索的数据:%ld",indexPath.row);
            [v.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        */
        LBB_HomeSearchViewController* searchVC = [[LBB_HomeSearchViewController alloc]init];
        searchVC.searchType = LBBPoohHomeSearchTypeFoods;
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
    self.locationManager = [[LBB_PoohCoreLocationManager alloc] init];

    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_ScenicMainTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicMainTableViewCell"];
    [self.tableView registerClass:[LBB_FoodsMainMenuCell class] forCellReuseIdentifier:@"LBB_FoodsMainMenuCell"];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];

    [self initViewModel];
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
}


#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return AutoSize(TopSegmmentControlHeight);
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WS(ws);

    if (section == 0) {
        return [UIView new];
    }
    
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    NSArray* segmentArray = @[@"附近",@"类别",@"智能排序",@"标签"];
    
    BN_FilterMenu* segmentedControl = [[BN_FilterMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    [segmentedControl setBackgroundColor:ColorWhite];
    
    [segmentedControl setTextColor:ColorGray];
    [segmentedControl setSelectedTextColor:ColorBtnYellow];
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = ColorLine.CGColor;
    segmentedControl.menuArray = segmentArray;
    
    //返回section数组
    [segmentedControl getMenuDataSectionArrayInBlock:^NSArray*(NSInteger index, NSString *title){
        if (index == 3) {
            return @[
                     @[@"热门推荐",@"景区标签_热门"],
                     @[@"标签",@"景区标签_标签"],
                     @[@"价格",@"景区标签_价格"],
                     ];
        }
        return @[@""];
    }];
    //返回section的高度和内容
    [segmentedControl heightForSectionInBlock:^CGFloat(NSInteger index, NSInteger section,id data){
        if (index == 3) {//标签
            return AutoSize(56/2);
        }
        if (index == 0) {//附近
            return AutoSize(84/2);
        }
        return 0;
    }];
    [segmentedControl getSectionInBlock:^UIView*(NSInteger index, NSInteger section, id data){
        
        if (index == 0) {//附近
            CGFloat height = AutoSize(84/2);
            CGFloat margin = 10;
            UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, height)];
            [view setBackgroundColor:ColorWhite];
            
            UIView* subSupView = [UIView new];
            [view addSubview:subSupView];
            
            UIView* subSecondView = [UIView new];
            [view addSubview:subSecondView];
            
            [subSupView mas_makeConstraints:^(MASConstraintMaker* make){
                make.left.top.bottom.equalTo(view);
            }];
            [subSecondView mas_makeConstraints:^(MASConstraintMaker* make){
                make.right.top.bottom.equalTo(view);
                make.left.equalTo(subSupView.mas_right);
                make.width.equalTo(subSupView);
            }];
            
            UILabel* titleLabel = [UILabel new];
            [titleLabel setFont:Font15];
            [titleLabel setTextColor:ColorGray];
            [titleLabel setText:@"附近"];
            [subSupView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
                
                make.centerY.equalTo(subSupView);
                make.left.equalTo(subSupView).offset(AutoSize(margin));
            }];

            UILabel* subTitleLabel = [UILabel new];
            [subTitleLabel setFont:Font15];
            [subTitleLabel setTextColor:ColorBtnYellow];
            [subTitleLabel setText:@"附近(智能商圈)"];
            [subSecondView addSubview:subTitleLabel];
            [subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
                
                make.center.equalTo(subSecondView);
            }];
            
            return view;
        }
        
        if (index == 3) {//标签
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

    //返回数据数组
    [segmentedControl getMenuDataRowArrayInBlock:^NSArray*(NSInteger index, NSString *title, NSInteger section){
        
        if (index == 0) {//附近
            return self.viewModel.foodsCondition.tradingArea;
        }
        else if (index == 1){//类别
            return self.viewModel.foodsCondition.type;
        }
        else if (index == 2){//智能排序
            return self.viewModel.foodsCondition.order;
        }
        else{//标签
            if (section == 0) {//热门推荐
                if (ws.viewModel.foodsCondition.price.count <= 0) {
                    return @[];
                }
                return @[ws.viewModel.foodsCondition.hotRecommend];
                
            }
            else if (section == 1){//标签
                if (ws.viewModel.foodsCondition.price.count <= 0) {
                    return @[];
                }
                return @[ws.viewModel.foodsCondition.tags];
                
            }
            else{//价格
                if (ws.viewModel.foodsCondition.price.count <= 0) {
                    return @[];
                }
                return @[ws.viewModel.foodsCondition.price];
                
            }
        }
    }];
    //返回每行的高度
    [segmentedControl heightForRowInBlock:^CGFloat(NSInteger index, NSIndexPath *indexPath, id data) {
        if (index == 3) {//标签
            return [LBB_FilterTableViewCell getCellHeight:data];
        }
        return AutoSize(40);
    }];
    //返回cell
    [segmentedControl getCellInBlock:^UITableViewCell*(NSInteger index, NSIndexPath *indexPath, id data) {
        NSLog(@"getCellInBlock data:%@",data);
        
        if (index < 3) {
            static NSString *cellIdentifier = @"LBB_FilterListTableViewCell";
            LBB_FilterListTableViewCell* cell = [[LBB_FilterListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            if (index == 2) {//智能排序
                
                NSArray* sortArray = @[
                                   @[@"智能排序",@"景区排序_智能排序",@"景区排序_智能排序HL"],
                                   @[@"价格最低",@"美食首页_价格排序",@"美食首页_价格排序HL"],
                                   @[@"价格最高",@"美食首页_价格排序",@"美食首页_价格排序HL"],
                                   @[@"评价最高",@"景区排序_评价最高",@"景区排序_评价最高HL"],
                                   ];
                
                NSInteger index = indexPath.row;
                if (index >= sortArray.count) {
                    index = sortArray.count - 1;
                }
                NSString* imageName = [[sortArray objectAtIndex:index] objectAtIndex:1];
                NSString* imageNameHL = [[sortArray objectAtIndex:index] objectAtIndex:2];
                LBB_FoodsConditionOption* obj = (LBB_FoodsConditionOption*)data;

                NSString* title = obj.name;

                [cell.imageView setImage:IMAGE(imageName)];
                [cell.textLabel setText:title];
                [cell.textLabel setFont:Font15];
                [cell.textLabel setTextColor:ColorGray];
                cell.tintColor = ColorBtnYellow;
                
                if (indexPath.row == ws.orderSelectIndex) {//类别
                    [cell.imageView setImage:IMAGE(imageNameHL)];
                    [cell.textLabel setTextColor:ColorBtnYellow];
                    UIImageView* accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize(13), AutoSize(11))];
                    [accessoryView setImage:IMAGE(@"景区排序_打钩")];
                    cell.accessoryView = accessoryView;
                }
                return cell;
            }
            else{
                LBB_FoodsConditionOption* obj = (LBB_FoodsConditionOption*)data;
                NSString* title = obj.name;
                [cell.textLabel setText:title];
                [cell.textLabel setFont:Font15];
                [cell.textLabel setTextColor:ColorGray];
                cell.tintColor = ColorBtnYellow;
                
                NSInteger selectIndex;
                if (index == 0) {//附近
                    [cell showSepLineView:NO];//不展示分割线
                    [cell setBackgroundColor:[UIColor colorWithRGB:0xeaeaea]];
                    selectIndex = ws.areaSelectIndex;
                }
                else{//类别
                    selectIndex = ws.typeSelectIndex;
                }
                if (indexPath.row == selectIndex) {//选中行高亮
                    [cell.textLabel setTextColor:ColorBtnYellow];
                    [cell setBackgroundColor:ColorWhite];
                    UIImageView* accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize(13), AutoSize(11))];
                    [accessoryView setImage:IMAGE(@"景区排序_打钩")];
                    cell.accessoryView = accessoryView;
                }
    
                return cell;
            }
        }
        else{
            static NSString *cellIdentifier = @"LBB_FilterTableViewCell";
            LBB_FilterTableViewCell* cell = [[LBB_FilterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.bottomMargin = AutoSize(15);
            if (indexPath.section == 0) {//热门推荐
                cell.selectIndex = ws.hotRecommendSelectIndex;
            }
            else if (indexPath.section == 1){//标签
                cell.selectIndex = ws.tagsSelectIndex;
            }
            else{//价格
                cell.selectIndex = ws.priceSelectIndex;
            }
            
            NSArray* dataArray = [data map:^id(LBB_FoodsConditionOption* model){
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
        if (index == 0) {//附近
            ws.areaSelectIndex = indexPath.row;
           // [segmentedControl closeMenu];
        }
        else if (index == 1){//类别
            ws.typeSelectIndex = indexPath.row;
            [segmentedControl closeMenu];
        }
        else if(index == 2){//排序
            ws.orderSelectIndex = indexPath.row;
            [segmentedControl closeMenu];
        }
        if (index != 0) {
            [ws getSpotArrayLongitude:YES];
        }
    }];
    
    //返回bottomView
    [segmentedControl getMenuBottomViewInBlock:^UIView*(NSInteger index, NSString *title){
        
        if (index < 3) {
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
    
    //设置是否有二级菜单
    //- (void)haveSubFilterInBlock:(BOOL (^)(NSInteger index, NSString *title))block;
    [segmentedControl haveSubFilterInBlock:^BOOL(NSInteger index, NSString *title){
        
        if (index == 0) {
            return YES;
        }
        return NO;
    }];
    
    //对应选项的子菜单数组
    [segmentedControl.subFilterView getMenuDataRowArrayInBlock:^NSArray *(NSInteger SupIndex, id SupData) {
        //return @[SupData,@"222",@"333"];
        return self.viewModel.foodsCondition.distance;

    }];
    
    //子菜单点击事件
    [segmentedControl.subFilterView didDeselectRowAtIndexPathBlock:^(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data) {
        ws.distanceSelectIndex = indexPath.row;
        if (ws.areaSelectIndex <= 0) {
            ws.areaSelectIndex = 0;
        }
        [segmentedControl closeMenu];
        [ws getSpotArrayLongitude:YES];
    }];
    
    //子菜单行高
    [segmentedControl.subFilterView heightForRowInBlock:^CGFloat(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data) {
        return AutoSize(40);
    }];
    //子菜单的cell
    //返回cell
    [segmentedControl.subFilterView getCellInBlock:^UITableViewCell*(NSInteger SupIndex, NSIndexPath *indexPath, id SupData, id data) {
        NSLog(@"subFilterView getCellInBlock data:%@",data);
        NSLog(@"subFilterView getCellInBlock SupData:%@",data);
        
        static NSString *cellIdentifier = @"LBB_FilterListTableViewCell";
        LBB_FilterListTableViewCell* cell = [[LBB_FilterListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
            LBB_FoodsConditionOption* obj = (LBB_FoodsConditionOption*)data;
            NSString* title = obj.name;
            [cell.textLabel setText:title];
            [cell.textLabel setFont:Font15];
            [cell.textLabel setTextColor:ColorGray];
            cell.tintColor = ColorBtnYellow;
            
            if (indexPath.row == ws.distanceSelectIndex) {
                [cell.textLabel setTextColor:ColorBtnYellow];
                UIImageView* accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize(13), AutoSize(11))];
                [accessoryView setImage:IMAGE(@"景区排序_打钩")];
                cell.accessoryView = accessoryView;
            }
            
            return cell;
     
    }];

    
    
    return segmentedControl;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return self.viewModel.foodsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell *cell) {
                
                [cell setCycleScrollViewHeight:AutoSize(470/2)];
                [cell setCycleScrollViewUrls:nil];
            }];
        }
        else{
            return [tableView fd_heightForCellWithIdentifier:@"LBB_FoodsMainMenuCell" cacheByIndexPath:indexPath configuration:^(LBB_FoodsMainMenuCell *cell) {
            }];
        }
        
    }
    

    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicMainTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicMainTableViewCell *cell) {
        
        [cell showTopSepLine:YES];
        [cell setModel:[ws.viewModel.foodsArray objectAtIndex:indexPath.row]];
    }];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 //   WS(ws);
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
            LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                
                NSLog(@"LBBPoohCycleScrollCell nil");
            }
            [cell setCycleScrollViewHeight:AutoSize(470/2)];
            [cell setAdModelArray:self.viewModel.advertisementArray];
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"LBB_FoodsMainMenuCell";
            LBB_FoodsMainMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBB_FoodsMainMenuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                
                NSLog(@"LBB_FoodsMainMenuCell nil");
            }

            return cell;
        }
        
    }
    
    
    static NSString *cellIdentifier = @"LBB_ScenicMainTableViewCell";
    LBB_ScenicMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicMainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicMainTableViewCell nil");
    }
    [cell showTopSepLine:YES];
    [cell setModel:[self.viewModel.foodsArray objectAtIndex:indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        return;
    }
    
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    dest.homeType = LBBPoohHomeTypeFoods;
    dest.spotModel = [self.viewModel.foodsArray objectAtIndex:indexPath.section - 1];

    [self.navigationController pushViewController:dest animated:YES];
}

@end
