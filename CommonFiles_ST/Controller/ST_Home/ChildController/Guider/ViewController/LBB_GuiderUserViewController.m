//
//  LBB_GuiderUserViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserViewController.h"

#import "LBB_GuiderUserHeaderCell.h"
#import "LBB_GuiderUserMsgCell.h"
#import "LBB_GuiderUserDeatilMsgCell.h"

#import "LBB_GuiderUserDynamicDataSource.h"
#import "LBB_GuiderUserFavoriteDataSource.h"
#import "LBB_GuiderUserFunsDataSource.h"


typedef NS_ENUM(NSInteger, LBB_GuiderUserType) {
    LBB_GuiderUserlDynamic = 0,//动态
    LBB_GuiderUserlFavorite,//关注
    LBB_GuiderUserFuns,//粉丝
};

@interface LBB_GuiderUserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* menuArray;
@property(nonatomic, assign)BOOL isOpen;

@property(nonatomic, retain)LBB_GuiderUserDynamicDataSource* dynamicDataSource;
@property(nonatomic, retain)LBB_GuiderUserFavoriteDataSource* favoriteDataSource;
@property(nonatomic, retain)LBB_GuiderUserFunsDataSource* funsDataSource;

@property(nonatomic, assign)LBB_GuiderUserType selectType;

@end

@implementation LBB_GuiderUserViewController

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
    
    __weak typeof(self) temp = self;
    
    [self.viewModel getUserShowViewModelData];
    [self.viewModel.userShowViewModel.loadSupport setDataRefreshblock:^{
        
        temp.title = temp.viewModel.userShowViewModel.userName;

        NSString* address = [NSString stringWithFormat:@"%@%@%@",temp.viewModel.userShowViewModel.provName,temp.viewModel.userShowViewModel.cityName,temp.viewModel.userShowViewModel.districtName];
        temp.menuArray = @[
                           @[@"导游_导游证号",@"导游证号",temp.viewModel.userShowViewModel.tourIdCard],
                           @[@"导游_从业时间",@"从业时间",temp.viewModel.userShowViewModel.tourStartTime],
                           @[@"导游_电话",@"联系电话",temp.viewModel.userShowViewModel.phoneNum],
                           @[@"导游_地址",@"地址",address],
                           @[@"导游_简介",@"简介",temp.viewModel.userShowViewModel.tourAWords],
                           ];
        
        
        /**
         3.4.7	广场-广场主页-个人主页-动态（已测）
         
         @param clear 清空原数据
         */
        [temp.viewModel.userShowViewModel getUserActionArrayClearData:YES];
        
        
        /**
         3.4.8	广场-广场主页-个人主页-关注（已测）
         
         @param clear 清空原数据
         */
        [temp.viewModel.userShowViewModel getUserAttentionArrayClearData:YES];
        
        /**
         3.4.9	广场-广场主页-个人主页-粉丝（已测）
         
         @param clear 清空原数据
         */
        [temp.viewModel.userShowViewModel getUserFansArrayClearData:YES];
        //默认是动态
        switch (temp.selectType) {
            case LBB_GuiderUserlDynamic://动态
                [temp.tableView setTableViewData:temp.viewModel.userShowViewModel.userActionArray];
                
                break;
            case LBB_GuiderUserlFavorite://关注
                [temp.tableView setTableViewData:temp.viewModel.userShowViewModel.userAttentionArray];
                
                break;
            case LBB_GuiderUserFuns://粉丝
                [temp.tableView setTableViewData:temp.viewModel.userShowViewModel.userFansArray];
                break;
            default:
                break;
        }
        [temp.tableView reloadData];
    }];
    
    [self.viewModel.userShowViewModel.userActionArray.loadSupport setDataRefreshblock:^{
        NSLog(@"userActionArray reloadData");
        [temp.tableView reloadData];
    }];
    [self.viewModel.userShowViewModel.userAttentionArray.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
    [self.viewModel.userShowViewModel.userFansArray.loadSupport setDataRefreshblock:^{
        [temp.tableView reloadData];
    }];
    
    
    
    [self.tableView setHeaderRefreshDatablock:^{
        [temp.tableView.mj_header endRefreshing];
        [temp.viewModel getUserShowViewModelData];
        [temp.viewModel.userShowViewModel getUserAttentionArrayClearData:YES];
        [temp.viewModel.userShowViewModel getUserActionArrayClearData:YES];
        [temp.viewModel.userShowViewModel getUserFansArrayClearData:YES];
        
        
    } footerRefreshDatablock:^{
        [temp.tableView.mj_footer endRefreshing];
        switch (temp.selectType) {
            case LBB_GuiderUserlDynamic://动态
                [temp.viewModel.userShowViewModel getUserActionArrayClearData:NO];
                
                break;
            case LBB_GuiderUserlFavorite://关注
                [temp.viewModel.userShowViewModel getUserAttentionArrayClearData:NO];
                
                break;
            case LBB_GuiderUserFuns://粉丝
                [temp.viewModel.userShowViewModel getUserFansArrayClearData:NO];
                break;
            default:
                break;
        }
        
    }];
}


-(void)loadCustomNavigationButton{
    
    [super loadCustomNavigationButton];
}


/*
 *  setup UI
 */
-(void)buildControls{
    
    
    WS(ws);
    
    
    self.menuArray = @[
                        @[@"导游_导游证号",@"导游证号",@"D-100-003256"],
                        @[@"导游_从业时间",@"从业时间",@"2012-09-09"],
                        @[@"导游_电话",@"联系电话",@"1856249542"],
                        @[@"导游_地址",@"地址",@"厦门湖里区"],
                        @[@"导游_简介",@"简介",@"厦门知名品牌导游第一名"],
                        ];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_GuiderUserHeaderCell class] forCellReuseIdentifier:@"LBB_GuiderUserHeaderCell"];
    [self.tableView registerClass:[LBB_GuiderUserMsgCell class] forCellReuseIdentifier:@"LBB_GuiderUserMsgCell"];
    [self.tableView registerClass:[LBB_GuiderUserDeatilMsgCell class] forCellReuseIdentifier:@"LBB_GuiderUserDeatilMsgCell"];

    [self initViewModel];
    
    self.dynamicDataSource = [[LBB_GuiderUserDynamicDataSource alloc] initWithTableView:self.tableView];
    self.favoriteDataSource = [[LBB_GuiderUserFavoriteDataSource alloc] initWithTableView:self.tableView];
    self.funsDataSource = [[LBB_GuiderUserFunsDataSource alloc] initWithTableView:self.tableView];

    self.dynamicDataSource.userActionArray = self.viewModel.userShowViewModel.userActionArray;
    
    self.favoriteDataSource.userAttentionArray = self.viewModel.userShowViewModel.userAttentionArray;
    self.funsDataSource.userFansArray = self.viewModel.userShowViewModel.userFansArray;

    
    
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
    NSArray* segmentArray = @[[NSString stringWithFormat:@"动态%d",self.viewModel.userShowViewModel.actionNum],[NSString stringWithFormat:@"关注%d",self.viewModel.userShowViewModel.followNum],[NSString stringWithFormat:@"粉丝%d",self.viewModel.userShowViewModel.fansNum]];
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
    segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                             NSForegroundColorAttributeName:ColorLightGray};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:Font15,
                                                     NSForegroundColorAttributeName:ColorBtnYellow};
    segmentedControl.selectionIndicatorColor = ColorBtnYellow;
    segmentedControl.verticalDividerWidth = SeparateLineWidth;
    segmentedControl.verticalDividerColor = ColorLightGray;
    segmentedControl.layer.borderWidth = SeparateLineWidth;
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
        return self.menuArray.count + 1;
    }
    
    switch (self.selectType) {
        case LBB_GuiderUserlDynamic:
            return [self.dynamicDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_GuiderUserlFavorite:
            return [self.favoriteDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_GuiderUserFuns:
            return [self.funsDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return [self tableView:tableView headerSectionCellForRowAtIndexPath:indexPath];
    }
    switch (self.selectType) {
        case LBB_GuiderUserlDynamic:
            return [self.dynamicDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_GuiderUserlFavorite:
            return [self.favoriteDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_GuiderUserFuns:
            return [self.funsDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self tableView:tableView heightForHeaderSectionRowAtIndexPath:indexPath];
    }
    switch (self.selectType) {
        case LBB_GuiderUserlDynamic:
            return [self.dynamicDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_GuiderUserlFavorite:
            return [self.favoriteDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_GuiderUserFuns:
            return [self.funsDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
    }
}


#pragma tableViewCell getter
-(UITableViewCell*)tableView:(UITableView *)tableView headerSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"LBB_GuiderUserHeaderCell";
        LBB_GuiderUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_GuiderUserHeaderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_GuiderUserHeaderCell nil");
            
        }
        [cell setModel:self.viewModel.userShowViewModel];
        return cell;
    }
    else if (indexPath.row == self.menuArray.count){
        static NSString *cellIdentifier = @"LBB_GuiderUserDeatilMsgCell";
        LBB_GuiderUserDeatilMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_GuiderUserDeatilMsgCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_GuiderUserDeatilMsgCell nil");
        }
        NSInteger row = indexPath.row - 1;
        cell.detailString = self.viewModel.userShowViewModel.tourDetails;
        
        cell.click = ^(NSNumber* num){
            ws.isOpen = !ws.isOpen;
            [ws.tableView reloadData];
        };

        if (self.isOpen) {
            [cell.rightButton setImage:IMAGE(@"导游_上拉箭头") forState:UIControlStateNormal];
            [cell.detailLabel setText:cell.detailString];
            [cell.detailLabel setLineSpace:5];
        }
        else{
            [cell.rightButton setImage:IMAGE(@"导游_下拉箭头") forState:UIControlStateNormal];
            [cell.detailLabel setText:@""];
        }
        [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
        [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
        [cell.textField setText:self.viewModel.userShowViewModel.tourAWords];
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_GuiderUserMsgCell";
        LBB_GuiderUserMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_GuiderUserMsgCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_GuiderUserMsgCell nil");
        }
        
        NSInteger row = indexPath.row - 1;
        [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
        [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
        [cell.textField setText:[[self.menuArray objectAtIndex:row] objectAtIndex:2]];
        
        return cell;
    }
}

#pragma header part
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserHeaderCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserHeaderCell* cell){
            
            [cell setModel:nil];
        }];
    }
    else if (indexPath.row == self.menuArray.count){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserDeatilMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserDeatilMsgCell* cell){
            NSInteger row = indexPath.row - 1;
            
            cell.detailString = self.viewModel.userShowViewModel.tourDetails;
            if (self.isOpen) {
                [cell.rightButton setImage:IMAGE(@"导游_上拉箭头") forState:UIControlStateNormal];
                [cell.detailLabel setText:cell.detailString];
                [cell.detailLabel setLineSpace:5];
            }
            else{
                [cell.rightButton setImage:IMAGE(@"导游_下拉箭头") forState:UIControlStateNormal];
                [cell.detailLabel setText:@""];
            }
            [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
            [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
            [cell.textField setText:self.viewModel.userShowViewModel.tourAWords];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderUserMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderUserMsgCell* cell){
            NSInteger row = indexPath.row - 1;

            [cell.iconImageView setImage:IMAGE([[self.menuArray objectAtIndex:row] objectAtIndex:0])];
            [cell.titleLabel setText:[[self.menuArray objectAtIndex:row] objectAtIndex:1]];
            [cell.textField setText:[[self.menuArray objectAtIndex:row] objectAtIndex:2]];
            
        }];
    }

}

@end
