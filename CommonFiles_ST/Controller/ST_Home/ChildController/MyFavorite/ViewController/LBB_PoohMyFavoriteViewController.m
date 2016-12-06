//
//  LBB_PoohMyFavoriteViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohMyFavoriteViewController.h"
#import "LBB_PoohMyFavoriteMainCell.h"
#import "LBB_PoohMyFavoriteSubjectCell.h"
#import "LBB_ScenicDetailViewController.h"
#import "LBB_ScenicDetailSubjectViewController.h"
#import "LBB_PoohMyFavoriteViewModel.h"


@interface LBB_PoohMyFavoriteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain)HMSegmentedControl *segmentedControl;

@property(nonatomic, retain)LBB_PoohMyFavoriteViewModel* favoriteViewModel;//收藏的ViewModel
@property(nonatomic, retain)LBB_PoohMyFavoriteSpecialViewModel* subjectViewModel;//专题的ViewModel

@property(nonatomic, assign)int requestType;

@end

@implementation LBB_PoohMyFavoriteViewController

-(id)init{
    
    if (self = [super init]) {
        self.requestType = 3;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


-(void)initViewModel{
    WS(ws);
    self.favoriteViewModel = [[LBB_PoohMyFavoriteViewModel alloc]init];
    /**
     *3.5.15 我的-收藏 广场 景点/美食/民宿 列表（已测）
     @parames allSpotsType	1.美食 2.民宿 3景点
     @parames isClear 是否清除缓存
     */
    switch (self.favoriteType) {
        case LBBPoohSegmCtrlScenicType://景点
            self.requestType = 3;
            break;
        case LBBPoohSegmCtrlFoodsType://美食
            self.requestType = 1;
            break;
        case LBBPoohSegmCtrlHostelType://民宿
            self.requestType = 2;
            break;
            
        default:
            break;
    }
    
    [self.favoriteViewModel getPoohMyFavoriteData:self.requestType Clear:YES];
    [self.favoriteViewModel.favoriteArray.loadSupport setDataRefreshblock:^{
    
        [ws.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.favoriteViewModel.favoriteArray];
    
    
    
    self.subjectViewModel = [[LBB_PoohMyFavoriteSpecialViewModel alloc]init];
    /**
     *3.5.16 我的-收藏 广场 专题（已测）
     @parames allSpotsType	1.美食 2.民宿 3景点
     @parames isClear 是否清除缓存
     */
    [self.subjectViewModel getPoohMyFavoriteSpecialData:self.requestType Clear:YES];
    
    [self.subjectViewModel.favoriteSpeciallArray.loadSupport setDataRefreshblock:^{
        
        [ws.tableView reloadData];
    }];
    
    
    [self.tableView setHeaderRefreshDatablock:^{
    
        if (ws.segmentedControl.selectedSegmentIndex == 0) {//收藏
            [ws.favoriteViewModel getPoohMyFavoriteData:ws.requestType Clear:YES];

        }
        else{//专题
            [ws.subjectViewModel getPoohMyFavoriteSpecialData:ws.requestType Clear:YES];

        }
        
        [ws.tableView.mj_header endRefreshing];
    } footerRefreshDatablock:^{
        if (ws.segmentedControl.selectedSegmentIndex == 0) {//收藏
            [ws.favoriteViewModel getPoohMyFavoriteData:ws.requestType Clear:NO];
            
        }
        else{//专题
            [ws.subjectViewModel getPoohMyFavoriteSpecialData:ws.requestType Clear:NO];
            
        }
        [ws.tableView.mj_footer endRefreshing];
    }];

}


-(void)loadCustomNavigationButton{

    self.title = @"景点";
    if (self.favoriteType == LBBPoohSegmCtrlScenicType) {
        self.title = @"景点";
    }
    else if (self.favoriteType == LBBPoohSegmCtrlFoodsType) {
        self.title = @"美食";
    }
    else if (self.favoriteType == LBBPoohSegmCtrlHostelType) {
        self.title = @"民宿";
    }
    
}

-(void)buildControls{

    WS(ws);

    NSArray* segmentArray = @[@"景点",@"专题"];
    if (self.favoriteType == LBBPoohSegmCtrlScenicType) {
        segmentArray = @[@"景点",@"专题"];
    }
    else if (self.favoriteType == LBBPoohSegmCtrlFoodsType) {
        segmentArray = @[@"美食",@"专题"];
    }
    else if (self.favoriteType == LBBPoohSegmCtrlHostelType) {
        segmentArray = @[@"民宿",@"专题"];
    }
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
    segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                             NSForegroundColorAttributeName:ColorLightGray};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:Font15,
                                                     NSForegroundColorAttributeName:ColorBtnYellow};
    segmentedControl.selectionIndicatorColor = ColorBtnYellow;
    segmentedControl.verticalDividerWidth = SeparateLineWidth;
    segmentedControl.verticalDividerColor = ColorLightGray;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.layer.borderColor = [ColorLine CGColor];
    segmentedControl.layer.borderWidth = SeparateLineWidth;
    
    [self.view addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.top.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(TopSegmmentControlHeight));
    }];
    segmentedControl.indexChangeBlock = ^(NSInteger index){
        NSLog(@"segmentedControl select:%ld",index);
        
        if (index == 0) {
            [ws.tableView setTableViewData:ws.favoriteViewModel.favoriteArray];

        }
        else{
            [ws.tableView setTableViewData:ws.subjectViewModel.favoriteSpeciallArray];

        }
        [ws.tableView reloadData];
    };
    self.segmentedControl = segmentedControl;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_PoohMyFavoriteMainCell class] forCellReuseIdentifier:@"LBB_PoohMyFavoriteMainCell"];
    [self.tableView registerClass:[LBB_PoohMyFavoriteSubjectCell class] forCellReuseIdentifier:@"LBB_PoohMyFavoriteSubjectCell"];
    
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


#pragma table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return self.favoriteViewModel.favoriteArray.count;
    }
    else{
        return self.subjectViewModel.favoriteSpeciallArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_PoohMyFavoriteMainCell" cacheByIndexPath:indexPath configuration:^(LBB_PoohMyFavoriteMainCell *cell) {
            [cell setModel:self.favoriteViewModel.favoriteArray[indexPath.row]];

        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_PoohMyFavoriteSubjectCell" cacheByIndexPath:indexPath configuration:^(LBB_PoohMyFavoriteSubjectCell *cell) {
            [cell setModel:self.subjectViewModel.favoriteSpeciallArray[indexPath.row]];
        }];
    }
    

    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
   
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        static NSString *cellIdentifier = @"LBB_PoohMyFavoriteMainCell";
        LBB_PoohMyFavoriteMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_PoohMyFavoriteMainCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_PoohMyFavoriteMainCell nil");
        }
        [cell setModel:self.favoriteViewModel.favoriteArray[indexPath.row]];
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_PoohMyFavoriteSubjectCell";
        LBB_PoohMyFavoriteSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_PoohMyFavoriteSubjectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_PoohMyFavoriteSubjectCell nil");
        }
        [cell setModel:self.subjectViewModel.favoriteSpeciallArray[indexPath.row]];
        return cell;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
//    dest.homeType = LBBPoohHomeTypeFoods;
//    
//    [self.navigationController pushViewController:dest animated:YES];
    
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
        switch (self.favoriteType) {
            case LBBPoohSegmCtrlScenicType://景点
                dest.homeType = LBBPoohHomeTypeScenic;
                break;
            case LBBPoohSegmCtrlFoodsType://美食
                dest.homeType = LBBPoohHomeTypeFoods;
                break;
            case LBBPoohSegmCtrlHostelType://民宿
                dest.homeType = LBBPoohHomeTypeHostel;
                break;
        }
        if (dest) {
            [self.navigationController pushViewController:dest animated:YES];
        }
    }
    else{
        LBB_ScenicDetailSubjectViewController* dest = [[LBB_ScenicDetailSubjectViewController alloc]init];
        switch (self.favoriteType) {
            case LBBPoohSegmCtrlScenicType://景点
                dest.homeType = LBBPoohHomeTypeScenic;
                break;
            case LBBPoohSegmCtrlFoodsType://美食
                dest.homeType = LBBPoohHomeTypeFoods;
                break;
            case LBBPoohSegmCtrlHostelType://民宿
                dest.homeType = LBBPoohHomeTypeHostel;
                break;
        }
        if (dest) {
            [self.navigationController pushViewController:dest animated:YES];
        }
    }

    
}

@end
