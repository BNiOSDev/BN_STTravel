//
//  LBB_HomeSearchViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeSearchViewController.h"
#import "LBB_HomeSearchKeyWordCell.h"//关键词
#import "LBB_ScenicMainTableViewCell.h"//景点
#import "LBBTravelTableViewCell.h"//游记
#import "LBB_HomeSearchDefaultCell.h"//默认的
#import "LBB_GuiderUserFunsListCell.h"//用户
#import "LBB_HomeSearchGoodsCell.h"//商品
#import "LBB_HomeSearchSquareImageCell.h"//广场-图片
#import "LBB_HomeSearchSquareVideoCell.h"//广场视频

#import <BN_FilterMenu.h>
#import "LBB_FilterListTableViewCell.h"
#import "XDPopupListView.h"
#import "LBB_SearchViewModel.h"
#import "LBB_ScenicDetailViewController.h"
#import "LBB_SquareSnsFollowViewController.h"
#import "LBBVideoPlayerViewController.h"
#import "LBB_VideoDetailViewController.h"
#import "LBBHostDetailViewController.h"
#import "LBB_TravelCommentController.h"
#import "LBB_TravelDetailViewController.h"
#import "LBB_LocalSearchRecordManager.h"

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
@property(nonatomic, retain)LBB_PoohCoreLocationManager* locationManager;

@property(nonatomic, strong) NSTimer *timer;

//历史搜索
@property(nonatomic, retain)NSArray<NSString*>* searchRecordArray;
@property(nonatomic, retain)LBB_LocalSearchRecordManager* searchRecordManager;


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
    
-(void)refreshSearchRecordArray{

    WS(ws);
    if (!self.searchRecordManager) {
        self.searchRecordManager = [[LBB_LocalSearchRecordManager alloc]init];
    }
    
    self.searchRecordManager.resBlock = ^(NSMutableArray* array){
        
        ws.searchRecordArray = [array copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [ws.tableView reloadData];
        });
    };
    [self.searchRecordManager queryKeyWordList];
    
    
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
    [super loadCustomNavigationButton];
    //  self.title = @"取消";
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
    
    self.showType = self.searchType;//按下搜索按钮，展示搜索结果
    [self search:YES];
 //   [self.tableView reloadData];
    
}
 // called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.showType = LBBPoohHomeSearchTypeDefault;//有输入文字的时候，设置为关键词联想展示
  //  [self.tableView reloadData];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerSearch) userInfo:nil repeats:NO];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
 //   [self.searchBar becomeFirstResponder];

    return YES;
}

- (void)timerSearch{

    switch (self.searchType) {
        case LBBPoohHomeSearchTypeGoods://伴手礼
        {
            
        }
            break;
        case LBBPoohHomeSearchTypeScenic://景点
        {
            /**
             3.6.5 搜索-景点/美食/民宿 词汇（已测）
             
             @param allSpotsType 1.美食 2.民宿 3景点
             @param name         搜索名称
             */
            [self.viewModel getSearchAllSpotsWordsArrayWithType:3 name:self.searchBar.text];
        }
            break;
        case LBBPoohHomeSearchTypeFoods://美食
        {
            [self.viewModel getSearchAllSpotsWordsArrayWithType:1 name:self.searchBar.text];
        }
            break;
        case LBBPoohHomeSearchTypeHostel://民宿
        {
            [self.viewModel getSearchAllSpotsWordsArrayWithType:2 name:self.searchBar.text];
        }
            break;
        case LBBPoohHomeSearchTypeUser://用户
        {
            [self.viewModel getSearchUserWordsArray:self.searchBar.text];
        }
            break;
        case LBBPoohHomeSearchTypeSquare://广场
        {
            [self.viewModel getSearchSquareWordsArray:self.searchBar.text];
        }
            break;
        case LBBPoohHomeSearchTypeTravel://游记
        {
            [self.viewModel getSearchTravelNotesWordsArray:self.searchBar.text];
        }
            
            break;
        case LBBPoohHomeSearchTypeDefault://展示搜索关键词
            
            [self refreshSearchRecordArray];
            break;
    }


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
        
        if ((self.searchType == LBBPoohHomeSearchTypeScenic)
            ||(self.searchType == LBBPoohHomeSearchTypeFoods)
            ||(self.searchType == LBBPoohHomeSearchTypeHostel)) {
            [self search:YES];
        }
        if ([num floatValue] != -1) {
            [self.locationManager.locManager stopUpdatingLocation];
        }
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
    
    /**
     3.6.5 搜索-景点/美食/民宿 词汇（已测）
     
     @param allSpotsType 1.美食 2.民宿 3景点
     @param name         搜索名称
     */
    [self.viewModel.allSpotWordArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    /**
     3.6.6 搜索-用户（已测）
     
     @param name   搜索名称
     @param clear 清空原数据
     */
    [self.viewModel.userArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    /**
     3.6.2 搜索-广场（已测）
     @param name 搜索名称
     */
    [self.viewModel.ugcArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    /**
     3.6.8 搜索-游记（已测）
     @param name 搜索名称
     */
    [self.viewModel.travelNoteArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    [self.tableView setHeaderRefreshDatablock:^{
        
        [ws search:YES];
        [ws.tableView.mj_header endRefreshing];
    } footerRefreshDatablock:^{
        
        [ws search:NO];

        [ws.tableView.mj_footer endRefreshing];

    }];
    
    [self setTableViewData];
}

//设置tableView 关联
-(void)setTableViewData{

    switch (self.showType) {
        case LBBPoohHomeSearchTypeGoods://伴手礼
        {
            
        }
            break;
        case LBBPoohHomeSearchTypeScenic://景点
        {
            [self.tableView setTableViewData:self.viewModel.scenicSpotsArray];
        }
            break;
        case LBBPoohHomeSearchTypeFoods://美食
        {
            [self.tableView setTableViewData:self.viewModel.foodSpotsArray];

        }
            break;
        case LBBPoohHomeSearchTypeHostel://民宿
        {
            [self.tableView setTableViewData:self.viewModel.hostelSpotsArray];
        }
            break;
        case LBBPoohHomeSearchTypeUser://用户
        {
            [self.tableView setTableViewData:self.viewModel.userArray];
        }
            break;
        case LBBPoohHomeSearchTypeSquare://广场
        {
            [self.tableView setTableViewData:self.viewModel.ugcArray];
        }
            break;
        case LBBPoohHomeSearchTypeTravel://游记
        {
            [self.tableView setTableViewData:self.viewModel.travelNoteArray];
        }
            
            break;
        case LBBPoohHomeSearchTypeDefault://展示搜索关键词
            
            
            break;
    }


}


//搜索动作
-(void)search:(BOOL)clear{
    [self.searchBar resignFirstResponder];

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
            [self.viewModel getAllSpotsArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude allSpotsType:3 name:self.searchBar.text clearData:clear];
        }
            break;
        case LBBPoohHomeSearchTypeFoods://美食
        {
            [self.viewModel getAllSpotsArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude allSpotsType:1 name:self.searchBar.text clearData:clear];
        }
            break;
        case LBBPoohHomeSearchTypeHostel://民宿
            
        {
             [self.viewModel getAllSpotsArrayLongitude:self.locationManager.longitude dimensionality:self.locationManager.latitude allSpotsType:2 name:self.searchBar.text clearData:clear];
        }
            break;
        case LBBPoohHomeSearchTypeUser://用户
        {
            [self.viewModel getUserArrayName:self.searchBar.text clearData:clear];
        }
            break;
        case LBBPoohHomeSearchTypeSquare://广场
        {
            [self.viewModel getSquareUgcArray:self.searchBar.text clearData:clear];
        }
            break;
        case LBBPoohHomeSearchTypeTravel://游记
        {
            [self.viewModel getSquareTravelNoteArray:self.searchBar.text clearData:clear];
        }
            
            break;
        case LBBPoohHomeSearchTypeDefault://展示搜索关键词
   
            
            break;
    }
    
    [self.searchRecordManager insertKeyWord:self.searchBar.text];
    WS(ws);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ws refreshSearchRecordArray];
    });
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
    [self refreshSearchRecordArray];

}

-(void)loadCustomCell{
    
    //标签关键字默认的
    [self.tableView registerClass:[LBB_HomeSearchKeyWordCell class] forCellReuseIdentifier:@"LBB_HomeSearchKeyWordCell"];
    //广场-图片
    [self.tableView registerClass:[LBB_HomeSearchSquareImageCell class] forCellReuseIdentifier:@"LBB_HomeSearchSquareImageCell"];
    //广场-视频
    [self.tableView registerClass:[LBB_HomeSearchSquareVideoCell class] forCellReuseIdentifier:@"LBB_HomeSearchSquareVideoCell"];
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
    [self search:YES];
  //  [self.tableView reloadData];
    [self setTableViewData];
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
    WS(ws);
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
    
    
    UIButton* clearButton = [UIButton new];
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearButton.titleLabel setFont:Font13];
    [clearButton setTitleColor:ColorGray forState:UIControlStateNormal];
    [view addSubview:clearButton];
    [clearButton mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-15);
    }];
    [clearButton bk_addEventHandler:^(id sender){
        
        ws.searchRecordManager.deleteBlock = ^(NSString* status){
            
            if (status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ws.searchRecordArray = nil;
                    [ws.tableView reloadData];
                });
            }
        };
        [ws.searchRecordManager deleteKeyWordList];
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (section == 0) {
        clearButton.hidden = NO;
    }
    else{
        clearButton.hidden = YES;
    }
    
    return view;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.searchBar.text length] <= 0) {
        
        if (section == 0) {//历史
            return ceil(self.searchRecordArray.count / 3.0);
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
                return self.viewModel.userArray.count;
            }
                break;
            case LBBPoohHomeSearchTypeSquare://广场
            {
                return self.viewModel.ugcArray.count;
            }
                break;
            case LBBPoohHomeSearchTypeTravel://游记
            {
                return self.viewModel.travelNoteArray.count;
            }
                break;
            case LBBPoohHomeSearchTypeDefault://展示搜索关键词
            {
                return self.viewModel.allSpotWordArray.count;
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
            {
                // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
                LBB_SearchSquareUgc* model = self.viewModel.ugcArray[indexPath.row];
                
                
                if (model.ugcType == 5) {	//Int	5：图片 6视频
                        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_HomeSearchSquareImageCell class] contentViewWidth:[self cellContentViewWith]];
                }
                else{
                    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LBB_HomeSearchSquareVideoCell class] contentViewWidth:[self cellContentViewWith]];
                }
          
            }
                break;
            case LBBPoohHomeSearchTypeTravel://游记
                
                return AutoSize(215);

                break;
            case LBBPoohHomeSearchTypeDefault://展示搜索关键词
                return [tableView fd_heightForCellWithIdentifier:@"LBB_HomeSearchDefaultCell" cacheByIndexPath:indexPath configuration:^(LBB_HomeSearchDefaultCell* cell){
                    NSString* string = ws.viewModel.allSpotWordArray[indexPath.row].name;
                    [cell.contentLabel setText:string];

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
            NSInteger idx1 = indexPath.row * 3;
            NSInteger idx2 = indexPath.row * 3+1;
            NSInteger idx3 = indexPath.row * 3+2;
            
            NSString *obj1 = [self.searchRecordArray objectAtIndex:idx1];
            [cell.labelButton1 setTitle:obj1 forState:UIControlStateNormal];
            
            if (idx2 < self.searchRecordArray.count) {
                NSString *obj2 = [self.searchRecordArray objectAtIndex:idx2];
                [cell.labelButton2 setTitle:obj2 forState:UIControlStateNormal];
                cell.labelButton2.hidden = NO;
            }
            else{
                cell.labelButton2.hidden = YES;
            }
            
            if (idx3 < self.searchRecordArray.count) {
                NSString *obj3 = [self.searchRecordArray objectAtIndex:idx3];
                [cell.labelButton3 setTitle:obj3 forState:UIControlStateNormal];
                cell.labelButton3.hidden = NO;
            }
            else{
                cell.labelButton3.hidden = YES;
            }
            
            
            cell.click = ^(NSNumber* num){
                NSString *obj1;
                
                switch ([num integerValue]) {
                    case 0:
                        obj1 = [self.searchRecordArray objectAtIndex:idx1];
                        break;
                    case 1:
                        obj1 = [self.searchRecordArray objectAtIndex:idx2];
                        break;
                    case 2:
                        obj1 = [self.searchRecordArray objectAtIndex:idx3];
                        break;
                    default:
                        break;
                }
                self.searchBar.text = obj1;
                self.showType = self.searchType;
                [self search:YES];
            };

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
            
            
            cell.click = ^(NSNumber* num){
                LBB_SearchHotWordModel *obj1;

                switch ([num integerValue]) {
                    case 0:
                        obj1 = [self.viewModel.hotWordArray objectAtIndex:idx1];
                        break;
                    case 1:
                        obj1 = [self.viewModel.hotWordArray objectAtIndex:idx2];
                        break;
                    case 2:
                        obj1 = [self.viewModel.hotWordArray objectAtIndex:idx3];
                        break;
                    default:
                        break;
                }
                self.searchBar.text = obj1.name;
                self.showType = self.searchType;
                [self search:YES];
            };
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
     
                LBB_UserOther* obj = self.viewModel.userArray[indexPath.row];
                [cell setModel:obj isTour:YES show:YES];
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeSquare://广场
            {
                LBB_SearchSquareUgc* model = self.viewModel.ugcArray[indexPath.row];

                if (model.ugcType == 5) {	//Int	5：图片 6视频
                    
                    LBB_HomeSearchSquareImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_HomeSearchSquareImageCell"];
                    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
                    
                    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
                    cell.model = self.viewModel.ugcArray[indexPath.row];
                    return cell;
                
                }
                else{
                    
                    LBB_HomeSearchSquareVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBB_HomeSearchSquareVideoCell"];
                    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
                    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
                    cell.model = self.viewModel.ugcArray[indexPath.row];
                    __weak typeof (self) weakSelf = self;
                    cell.blockBtnFunc = ^(NSInteger tag)
                    {
                        if(tag == 0)
                        {
                            LBBVideoPlayerViewController  *vc = [[LBBVideoPlayerViewController alloc]init];
                            vc.videoUrl = [NSURL URLWithString:model.videoUrl];
                            [weakSelf presentViewController:vc animated:YES completion:nil];
                        }
                    };
                    return cell;
                }
   
            }
                break;
            case LBBPoohHomeSearchTypeTravel://游记
            {
                LBBTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBBTravelTableViewCell"];
                cell.cellBlock = ^(id view,UITableViewCellViewSignal signal){
                    [self dealCellSignal:signal withIndex:indexPath];
                };
                ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
                
                [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
                
                
                cell.model = self.viewModel.travelNoteArray[indexPath.row];
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
                
                NSString* string = self.viewModel.allSpotWordArray[indexPath.row].name;
                [cell.contentLabel setText:string];
                return cell;
                
            }
                break;
        }

        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (self.showType) {
        case LBBPoohHomeSearchTypeGoods://伴手礼
        {
            
        }
            break;
        case LBBPoohHomeSearchTypeScenic://景点
        {
            LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
            dest.homeType = LBBPoohHomeTypeScenic;
            dest.spotModel = [self.viewModel.scenicSpotsArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:dest animated:YES];
        }
            break;
        case LBBPoohHomeSearchTypeFoods://美食
        {
            LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
            dest.homeType = LBBPoohHomeTypeFoods;
            dest.spotModel = [self.viewModel.foodSpotsArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:dest animated:YES];
        }
            break;
        case LBBPoohHomeSearchTypeHostel://民宿
            
        {
            LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
            dest.homeType = LBBPoohHomeTypeHostel;
            dest.spotModel = [self.viewModel.hostelSpotsArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:dest animated:YES];
        }
            break;
        case LBBPoohHomeSearchTypeUser://用户
        {
            LBB_SquareSnsFollowViewController* dest = [[LBB_SquareSnsFollowViewController alloc] init];
            LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
            LBB_UserOther* obj = self.viewModel.userArray[indexPath.row];
            viewModel.userId = obj.userId;
            dest.viewModel = viewModel;
            [self.navigationController pushViewController:dest animated:YES];

        }
            break;
        case LBBPoohHomeSearchTypeSquare://广场
        {
        
            LBB_SearchSquareUgc  *model = self.viewModel.ugcArray[indexPath.row];
            LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
            viewModel.ugcId = model.ugcId;
            if (model.ugcType == 5) {	//Int	5：图片 6视频
                LBBHostDetailViewController *vc = [[LBBHostDetailViewController alloc]init];
                vc.viewModel = viewModel;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                LBB_VideoDetailViewController *Vc = [[LBB_VideoDetailViewController alloc]init];
                Vc.viewModel = viewModel;
                [self.navigationController pushViewController:Vc animated:YES];
            }

        }
            break;
        case LBBPoohHomeSearchTypeTravel://游记
        {
            LBB_TravelDetailViewController *vc = [[LBB_TravelDetailViewController alloc]init];
            vc.model = self.viewModel.travelNoteArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case LBBPoohHomeSearchTypeDefault://展示搜索关键词
        {
            NSString* string = self.viewModel.allSpotWordArray[indexPath.row].name;
            self.searchBar.text = string;
            self.showType = self.searchType;
            [self search:YES];
        }
            
            break;
    }
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark 处理点击cell上面的按钮
- (void)dealCellSignal:(UITableViewCellViewSignal)signel  withIndex:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    switch (signel) {
        case UITableViewCellCollect:
        {
            
        }
            break;
        case UITableViewCellConment:
        {
            LBB_TravelCommentController *vc = [[LBB_TravelCommentController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case UITableViewCellPraise:
        {
            
        }
            break;
            
        default:
            break;
    }
}
    
@end
