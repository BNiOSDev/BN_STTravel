//
//  LBB_SquareSnsFollowViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareSnsFollowViewController.h"

#import "LBB_GuiderUserHeaderCell.h"


#import "LBB_SquareSnsFollowDynamicDataSource.h"
#import "LBB_SquareSnsFollowFavoriteDataSource.h"
#import "LBB_SquareSnsFollowFunsDataSource.h"


typedef NS_ENUM(NSInteger, LBB_SquareSnsFollowType) {
    LBB_SquareSnsFollowlDynamic = 0,//动态
    LBB_SquareSnsFollowlFavorite,//关注
    LBB_SquareSnsFollowFuns,//粉丝
};

@interface LBB_SquareSnsFollowViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;

@property(nonatomic, retain)LBB_SquareSnsFollowDynamicDataSource* dynamicDataSource;
@property(nonatomic, retain)LBB_SquareSnsFollowFavoriteDataSource* favoriteDataSource;
@property(nonatomic, retain)LBB_SquareSnsFollowFunsDataSource* funsDataSource;

@property(nonatomic, assign)LBB_SquareSnsFollowType selectType;

@end

@implementation LBB_SquareSnsFollowViewController

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


-(void)loadCustomNavigationButton{
    
    WS(ws);
    UIButton *shareButton = [[UIButton alloc] init];
    shareButton.titleLabel.font = Font14;
    [shareButton setImage:IMAGE(@"标签详情_分享") forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, 45, 45);
    [shareButton bk_addEventHandler:^(id sender){
        
        
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = shareItem;
}


/*
 *  setup UI
 */
-(void)buildControls{
    
    
    WS(ws);
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_GuiderUserHeaderCell class] forCellReuseIdentifier:@"LBB_GuiderUserHeaderCell"];
    
    self.dynamicDataSource = [[LBB_SquareSnsFollowDynamicDataSource alloc] initWithTableView:self.tableView];
    self.favoriteDataSource = [[LBB_SquareSnsFollowFavoriteDataSource alloc] initWithTableView:self.tableView];
    self.funsDataSource = [[LBB_SquareSnsFollowFunsDataSource alloc] initWithTableView:self.tableView];
    
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.equalTo(ws.view);
        make.top.equalTo(ws.view.mas_top);
        make.bottom.equalTo(ws.view);
    }];
    
    
    
}



#pragma tableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.001;
    }
    return AutoSize(TopSegmmentControlHeight);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    if (section == 0) {
        return [UIView new];
    }
    
    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    NSArray* segmentArray = @[@"动态112",@"关注12",@"粉丝1212"];
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
    segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                             NSForegroundColorAttributeName:ColorLightGray};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:Font15,
                                                     NSForegroundColorAttributeName:ColorBtnYellow};
    segmentedControl.selectionIndicatorColor = ColorBtnYellow;
    segmentedControl.verticalDividerWidth = SeparateLineWidth;
    segmentedControl.verticalDividerColor = ColorLightGray;
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = ColorLine.CGColor;
    segmentedControl.selectedSegmentIndex = self.selectType;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [v addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.width.equalTo(v);
        
    }];
    WS(ws);
    segmentedControl.indexChangeBlock = ^(NSInteger index){
        NSLog(@"segmentedControl select:%ld",index);
        ws.selectType = index;
        [ws.tableView reloadData];
    };
    
    return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    switch (self.selectType) {
        case LBB_SquareSnsFollowlDynamic:
            return [self.dynamicDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_SquareSnsFollowlFavorite:
            return [self.favoriteDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_SquareSnsFollowFuns:
            return [self.funsDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self tableView:tableView headerSectionCellForRowAtIndexPath:indexPath];
    }
    switch (self.selectType) {
        case LBB_SquareSnsFollowlDynamic:
            return [self.dynamicDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_SquareSnsFollowlFavorite:
            return [self.favoriteDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_SquareSnsFollowFuns:
            return [self.funsDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self tableView:tableView heightForHeaderSectionRowAtIndexPath:indexPath];
    }
    switch (self.selectType) {
        case LBB_SquareSnsFollowlDynamic:
            return [self.dynamicDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_SquareSnsFollowlFavorite:
            return [self.favoriteDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_SquareSnsFollowFuns:
            return [self.funsDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
    }
}


#pragma tableViewCell getter
-(UITableViewCell*)tableView:(UITableView *)tableView headerSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_GuiderUserHeaderCell";
    LBB_GuiderUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderUserHeaderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderUserHeaderCell nil");
        
    }
    [cell setModel:nil];
    return cell;
}

#pragma 周边推荐
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserHeaderCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserHeaderCell* cell){
        
        [cell setModel:nil];
    }];
    
}

@end
