//
//  LBB_HomeSearchViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeSearchViewController.h"
#import "LBB_HomeSearchKeyWordCell.h"//关键词
#import "LBB_GuiderUserDynamicCell.h"//广场
#import "LBB_ScenicMainTableViewCell.h"//景点
#import "LBBTravelTableViewCell.h"//游记
#import "LBB_HomeSearchDefaultCell.h"//默认的
#import "LBB_GuiderUserFunsListCell.h"//用户
#import "LBB_HomeSearchGoodsCell.h"//商品

#import <BN_FilterMenu.h>
#import "LBB_FilterListTableViewCell.h"
#import "XDPopupListView.h"
#import "LBB_SearchViewModel.h"

static const NSInteger kSearchButtonMarginRight = -10;
static const NSInteger kButtonWidth = 45;

@interface LBB_HomeSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,XDPopupListViewDataSource, XDPopupListViewDelegate>

@property(nonatomic, retain)UISearchBar* searchBar;
@property(nonatomic, retain)UITableView* tableView;

@property(nonatomic, assign)LBBPoohHomeSearchType showType;

@property(nonatomic, retain)UIButton *filterMenuButton;

@property(nonatomic, retain)XDPopupListView *mDropDownListView;

@property(nonatomic, retain)NSArray* menuArray;

@property(nonatomic, retain)LBB_SearchViewModel* viewModel;
//地理位置管理
@property (nonatomic,retain)LBB_PoohCoreLocationManager* locationManager;
@end

@implementation LBB_HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES];
}
    
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)loadCustomNavigationButton{
    
    //  self.title = @"取消";
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
    
    self.showType = self.searchType;//按下搜索按钮，展示搜索结果
    [self search];
 //   [self.tableView reloadData];
    
}
 // called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.showType = LBBPoohHomeSearchTypeDefault;//有输入文字的时候，设置为关键词联想展示
    [self.tableView reloadData];
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchBar becomeFirstResponder];
    return YES;
}

-(void)initViewModel{
    WS(ws);
    self.viewModel = [[LBB_SearchViewModel alloc]init];
    
    self.locationManager = [[LBB_PoohCoreLocationManager alloc] init];

    /**
     3.6.1	搜索-热门搜索词汇（已测）
     */
    
    [self.viewModel getHotWordArray];
    [self.viewModel.hotWordArray.loadSupport setDataRefreshblock:^{
        if (ws.searchBar.text.length <= 0) {
            [ws.tableView reloadData];
        }
    }];
    
    /**
     3.6.4	搜索-景点/美食/民宿（已测）
     
     @param longitude Y坐标
     @param dimensionality X坐标
     @param allSpotsType 1.美食 2.民宿 3景点
     @param name 搜索名称
     @param clear 清空原数据
     */
    
    @weakify(self);
    [RACObserve(self.locationManager, latitude) subscribeNext:^(NSString* num) {
        @strongify(self);
        
        [self search];

    }];
    
    [self.viewModel.scenicSpotsArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    [self.viewModel.foodSpotsArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    [self.viewModel.hostelSpotsArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    
}

//搜索动作
-(void)search{
    switch (self.searchType) {
        case LBBPoohHomeSearchTypeGoods://伴手礼
        {

        }
            break;
        case LBBPoohHomeSearchTypeScenic://景点
        {
            /**
             3.6.4	搜索-景点/美食/民宿（已测）
             
             @param longitude Y坐标
             @param dimensionality X坐标
             @param allSpotsType 1.美食 2.民宿 3景点
             @param name 搜索名称
             @param clear 清空原数据
             */
            [self.viewModel getAllSpotsArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude allSpotsType:3 name:self.searchBar.text clearData:YES];
        }
            break;
        case LBBPoohHomeSearchTypeFoods://美食
        {
            [self.viewModel getAllSpotsArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude allSpotsType:1 name:self.searchBar.text clearData:YES];
        }
            break;
        case LBBPoohHomeSearchTypeHostel://民宿
            
        {
             [self.viewModel getAllSpotsArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude allSpotsType:2 name:self.searchBar.text clearData:YES];
        }
            break;
        case LBBPoohHomeSearchTypeUser://用户
        {

        }
            break;
        case LBBPoohHomeSearchTypeSquare://广场

            break;
        case LBBPoohHomeSearchTypeTravel://游记
            
            
            break;
        case LBBPoohHomeSearchTypeDefault://展示搜索关键词
   
            
            break;
    }

}



/*
 *  setup UI
 */
-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:ColorWhite];
    
    self.menuArray = @[@"伴手礼",@"景点",@"美食",@"民宿",@"用户",@"广场",@"游记"];
    
    //自定义左侧的删选栏
    //CGFloat IAppNavigationBarHeight = 44.0f;
    // CGFloat IAppStatusBarHeight = 20.0f;
    self.filterMenuButton = [[UIButton alloc]initWithFrame:CGRectMake(15, IAppStatusBarHeight, AutoSize(150/2), IAppNavigationBarHeight-10)];
    [self.filterMenuButton setTitle:[self.menuArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.filterMenuButton setImage:IMAGE(@"搜索_下拉") forState:UIControlStateNormal];
    [self.filterMenuButton setImageEdgeInsets:UIEdgeInsetsMake(0, AutoSize(35), 0, AutoSize(-35))];
    [self.filterMenuButton setTitleEdgeInsets:UIEdgeInsetsMake(0, AutoSize(-10), 0, AutoSize(10))];
    [self.filterMenuButton setBackgroundColor:ColorBtnYellow];
    [self.filterMenuButton.titleLabel setFont:Font13];
    [self.view addSubview:self.filterMenuButton];
    self.mDropDownListView = [[XDPopupListView alloc] initWithBoundView:self.filterMenuButton dataSource:self delegate:self popupType:XDPopupListViewDropDown];
    [self.mDropDownListView.tableView setBounces:NO];
    
    [self.filterMenuButton bk_whenTapped:^{
        [ws.mDropDownListView show];
    }];
    
    [self.filterMenuButton setTitle:[self.menuArray objectAtIndex:self.searchType] forState:UIControlStateNormal];

    
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = ColorLine.CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = @"请选择分类进行搜索";//@"输入关键字搜索景点";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    [self.view addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.height.centerY.equalTo(ws.filterMenuButton);
        make.left.equalTo(ws.filterMenuButton.mas_right);
    }];
    
    UIButton *cancel = [[UIButton alloc] init];
    cancel.titleLabel.font = Font14;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel bk_addEventHandler:^(id sender){
        
        [ws.navigationController popViewControllerAnimated:YES];
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.height.width.mas_equalTo(kButtonWidth);
        make.centerY.equalTo(ws.filterMenuButton);
        make.right.equalTo(ws.view).offset(kSearchButtonMarginRight);
        make.left.equalTo(bar.mas_right).offset(10);
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self loadCustomCell];
    [self initViewModel];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setBackgroundColor:ColorLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(ws.filterMenuButton.mas_bottom).offset(10);
        make.bottom.equalTo(ws.view);
    }];
    
}

-(void)loadCustomCell{
    
    //标签关键字默认的
    [self.tableView registerClass:[LBB_HomeSearchKeyWordCell class] forCellReuseIdentifier:@"LBB_HomeSearchKeyWordCell"];
    //广场
    [self.tableView registerClass:[LBB_GuiderUserDynamicCell class] forCellReuseIdentifier:@"LBB_GuiderUserDynamicCell"];
    //景点、美食、民宿
    [self.tableView registerClass:[LBB_ScenicMainTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicMainTableViewCell"];

    //伴手礼
    [self.tableView registerClass:[LBB_HomeSearchGoodsCell class] forCellReuseIdentifier:@"LBB_HomeSearchGoodsCell"];

    //用户
    [self.tableView registerClass:[LBB_GuiderUserFunsListCell class] forCellReuseIdentifier:@"LBB_GuiderUserFunsListCell"];

    //游记
    [self.tableView registerClass:[LBBTravelTableViewCell class] forCellReuseIdentifier:@"LBBTravelTableViewCell"];

    //关键词联想，做为默认
    [self.tableView registerClass:[LBB_HomeSearchDefaultCell class] forCellReuseIdentifier:@"LBB_HomeSearchDefaultCell"];

}


#pragma mark - XDPopupListViewDataSource & XDPopupListViewDelegate

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath
{
    return AutoSize(35);
}
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clickedListViewAtIndexPath : %ld", indexPath.row);
    [self.filterMenuButton setTitle:[self.menuArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    self.searchType = indexPath.row;
    self.showType = self.searchType;
    [self search];
  //  [self.tableView reloadData];
}
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"itemCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cell.contentView setBackgroundColor:ColorBtnYellow];
    
    UILabel* titleLabel = [UILabel new];
    [titleLabel setFont:Font13];
    [titleLabel setTextColor:ColorWhite];
    [titleLabel setText:[self.menuArray objectAtIndex:indexPath.row]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.center.equalTo(cell.contentView);
    }];
    
    if (indexPath.row != self.menuArray.count-1) {
        UIView* sepLineView = [UIView new];
        [sepLineView setBackgroundColor:ColorWhite];
        [cell.contentView addSubview:sepLineView];
        [sepLineView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.left.equalTo(cell.contentView).offset(8);
            make.right.equalTo(cell.contentView).offset(-8);
        }];
    }
    
    return cell;
}


#pragma tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.searchBar.text length] <= 0) {
        return 2;
    }
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([self.searchBar.text length] <= 0) {
        return AutoSize(35);
    }
    
    return 0.001;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([self.searchBar.text length] > 0) {
        return [UIView new];
    }
    UIView* view = [UIView new];
    [view setBackgroundColor:ColorLine];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [view setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    NSArray* icons = @[@"景区标签_热门",@"景区标签_标签"];
    NSArray* titles = @[@"历史搜索",@"热门搜索"];
    
    
    UIView* subView = [UIView new];
    [view addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.center.equalTo(view);
    }];
    
    UIImageView* iconImageView = [UIImageView new];
    [iconImageView setImage:IMAGE([icons objectAtIndex:section])];
    [iconImageView setContentMode:UIViewContentModeCenter];
    [subView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.left.equalTo(subView);
        make.top.bottom.equalTo(subView);
    }];
    
    UILabel* titleLabel = [UILabel new];
    [titleLabel setText:[titles objectAtIndex:section]];
    [titleLabel setTextColor:ColorGray];
    [titleLabel setFont:Font13];
    [subView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.right.equalTo(subView);
        make.left.equalTo(iconImageView.mas_right).offset(8);
    }];
    
    
    return view;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.searchBar.text length] <= 0) {
        
        if (section == 0) {//历史
            return 3;
        }
        else{
            return ceil(self.viewModel.hotWordArray.count / 3.0);
        }
        return 3;
    }
    else{
        switch (self.showType) {
            case LBBPoohHomeSearchTypeGoods://伴手礼
            {
                return 10;
            }
                break;
            case LBBPoohHomeSearchTypeScenic://景点
            {
                return self.viewModel.scenicSpotsArray.count;
            }
                break;
            case LBBPoohHomeSearchTypeFoods://美食
            {
                return self.viewModel.foodSpotsArray.count;
            }
                break;
            case LBBPoohHomeSearchTypeHostel://民宿
            {
                return self.viewModel.hostelSpotsArray.count;
            }
                break;
            case LBBPoohHomeSearchTypeUser://用户
            {
                return 10;
            }
                break;
            case LBBPoohHomeSearchTypeSquare://广场
            {
                return 10;
            }
                break;
            case LBBPoohHomeSearchTypeTravel://游记
            {
                return 10;
            }
                break;
            case LBBPoohHomeSearchTypeDefault://展示搜索关键词
            {
                return 10;
            }
                break;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    if ([self.searchBar.text length] <= 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_HomeSearchKeyWordCell" cacheByIndexPath:indexPath configuration:^(LBB_HomeSearchKeyWordCell* cell){
        }];
    }
    else{
        switch (self.showType) {
            case LBBPoohHomeSearchTypeGoods://伴手礼
            {
                return [tableView fd_heightForCellWithIdentifier:@"LBB_HomeSearchGoodsCell" cacheByIndexPath:indexPath configuration:^(LBB_HomeSearchGoodsCell *cell) {
                    
                }];
            }
                break;
            case LBBPoohHomeSearchTypeScenic://景点
            case LBBPoohHomeSearchTypeFoods://美食
            case LBBPoohHomeSearchTypeHostel://民宿

            {
                return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicMainTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicMainTableViewCell *cell) {
                    
                    
                    if (self.showType == LBBPoohHomeSearchTypeScenic) {
                        [cell setModel:ws.viewModel.scenicSpotsArray[indexPath.row]];
                    }
                    else if(self.showType == LBBPoohHomeSearchTypeFoods){
                        [cell setModel:ws.viewModel.foodSpotsArray[indexPath.row]];
                    }
                    else{
                        [cell setModel:ws.viewModel.hostelSpotsArray[indexPath.row]];
                    }
                }];
            }
                break;
            case LBBPoohHomeSearchTypeUser://用户
            {
                return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserFunsListCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserFunsListCell* cell){
                }];
            }
                break;
            case LBBPoohHomeSearchTypeSquare://广场
                return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserDynamicCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserDynamicCell* cell){
                }];
                break;
            case LBBPoohHomeSearchTypeTravel://游记
                
                return AutoSize(215);

                break;
            case LBBPoohHomeSearchTypeDefault://展示搜索关键词
                return [tableView fd_heightForCellWithIdentifier:@"LBB_HomeSearchDefaultCell" cacheByIndexPath:indexPath configuration:^(LBB_HomeSearchDefaultCell* cell){
                    [cell.contentLabel setText:@"鼓浪屿啦啦啦"];

                }];
                
                break;
        }
        
        return 10;
        
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.searchBar.text length] <= 0) {
        
        static NSString *cellIdentifier = @"LBB_HomeSearchKeyWordCell";
        LBB_HomeSearchKeyWordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_HomeSearchKeyWordCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_HomeSearchKeyWordCell nil");
            
        }
        
        if (indexPath.section == 0) {//搜索历史
            
        }
        else{
        
            NSInteger idx1 = indexPath.row * 3;
            NSInteger idx2 = indexPath.row * 3+1;
            NSInteger idx3 = indexPath.row * 3+2;

            LBB_SearchHotWordModel *obj1 = [self.viewModel.hotWordArray objectAtIndex:idx1];
            [cell.labelButton1 setTitle:obj1.name forState:UIControlStateNormal];
            
            if (idx2 < self.viewModel.hotWordArray.count) {
                LBB_SearchHotWordModel *obj2 = [self.viewModel.hotWordArray objectAtIndex:idx2];
                [cell.labelButton2 setTitle:obj2.name forState:UIControlStateNormal];
                cell.labelButton2.hidden = NO;
            }
            else{
                cell.labelButton2.hidden = YES;
            }
            
            if (idx3 < self.viewModel.hotWordArray.count) {
                LBB_SearchHotWordModel *obj3 = [self.viewModel.hotWordArray objectAtIndex:idx3];
                [cell.labelButton3 setTitle:obj3.name forState:UIControlStateNormal];
                cell.labelButton3.hidden = NO;
            }
            else{
                cell.labelButton3.hidden = YES;
            }
            
        }
        return cell;
    }
    else{
        switch (self.showType) {
            case LBBPoohHomeSearchTypeGoods://伴手礼
            {
                static NSString *cellIdentifier = @"LBB_HomeSearchGoodsCell";
                LBB_HomeSearchGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[LBB_HomeSearchGoodsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    
                    NSLog(@"LBB_HomeSearchGoodsCell nil");
                }
                [cell setModel:nil];
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeScenic://景点
            case LBBPoohHomeSearchTypeFoods://美食
            case LBBPoohHomeSearchTypeHostel://民宿
            {
                static NSString *cellIdentifier = @"LBB_ScenicMainTableViewCell";
                LBB_ScenicMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[LBB_ScenicMainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    
                    NSLog(@"LBB_ScenicMainTableViewCell nil");
                }
                
                
                if (self.showType == LBBPoohHomeSearchTypeScenic) {
                    [cell setModel:self.viewModel.scenicSpotsArray[indexPath.row]];
                }
                else if(self.showType == LBBPoohHomeSearchTypeFoods){
                    [cell setModel:self.viewModel.foodSpotsArray[indexPath.row]];
                }
                else{
                    [cell setModel:self.viewModel.hostelSpotsArray[indexPath.row]];
                }
                
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeUser://用户
            {
                static NSString *cellIdentifier = @"LBB_GuiderUserFunsListCell";
                LBB_GuiderUserFunsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[LBB_GuiderUserFunsListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    
                    NSLog(@"LBB_GuiderUserFunsListCell nil");
                }
                cell.vImageView.hidden = NO;
                cell.levelButton.hidden = NO;
                cell.identityLable.hidden = NO;
                [cell setModel:nil];
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeSquare://广场
            {
                static NSString *cellIdentifier = @"LBB_GuiderUserDynamicCell";
                LBB_GuiderUserDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[LBB_GuiderUserDynamicCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
                    NSLog(@"LBB_GuiderUserDynamicCell nil");
                }
               // [cell setModel:nil];
                
                
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeTravel://游记
            {
                LBBTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBBTravelTableViewCell"];
                cell.cellBlock = ^(id view,UITableViewCellViewSignal signal){
                };
                ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
                [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
                
                ZJMTravelModel  *model = [[ZJMTravelModel alloc]init];
                model.iconName = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
                model.imageUrl = @"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg";
                model.name = @"钟爱SD的男人";
                model.msgContent = @"开启说走就走的旅行吧";
                model.timeStr = @"2016-09-09";
                model.daysStr = @"5 days";
                model.vistNum = @"1080";
                model.praiseNum = @"999";
                model.commentNum = @"999";
                model.collectNum = @"9999";
                cell.model = model;
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeDefault://展示搜索关键词
            {
                static NSString *cellIdentifier = @"LBB_HomeSearchDefaultCell";
                LBB_HomeSearchDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (cell == nil) {
                    cell = [[LBB_HomeSearchDefaultCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
                    NSLog(@"LBB_HomeSearchDefaultCell nil");
                }
                
                [cell.contentLabel setText:@"鼓浪屿啦啦啦"];
                
                return cell;
                
            }
                break;
        }

        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.showType == LBBPoohHomeSearchTypeDefault ) {
        
        self.searchBar.text = @"鼓浪屿啦啦啦";
        self.showType = self.searchType;
        [self search];
       // [self.tableView reloadData];
    }
}



    
@end
