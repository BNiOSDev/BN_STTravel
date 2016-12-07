//
//  LBB_LabelDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailViewController.h"
#import "LBB_LabelDetailHeaderView.h"

#import "LBB_LabelDetailHotDataSource.h"
#import "LBB_LabelDetailUserDataSource.h"
static const NSInteger kSearchButtonMarginRight = -10;
static const NSInteger kButtonWidth = 45;
typedef NS_ENUM(NSInteger, LBB_LabelDetailType) {
    LBB_LabelDetailHot = 0,//热门
    LBB_LabelDetailTime,//时间
    LBB_LabelDetailUser,//用户
};

@interface LBB_LabelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain)LBB_LabelDetailHeaderView* headerView;

@property(nonatomic, assign)LBB_LabelDetailType selectType;

@property(nonatomic, retain)LBB_LabelDetailHotDataSource* hotDataSource;
@property(nonatomic, retain)LBB_LabelDetailHotDataSource* timeDataSource;
@property(nonatomic, retain)LBB_LabelDetailUserDataSource* userDataSource;

@end

@implementation LBB_LabelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton:nil];
    [self setBaseNavigationBarHidden:NO];
    [self setBaseNavigationBarBackgroundColor:[UIColor clearColor]];
    [self setupFullContentView];
    [self setupNavigationUI];
    [self setupUI];
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
    /**
     1.1.1	广场-广场主页-标签主页-列表（已测）
     */
    [self.viewModel getTagsViewModelData];
    [self.viewModel.tagsViewModel.loadSupport setDataRefreshblock:^{
        [ws.headerView setModel:ws.viewModel.tagsViewModel];
        [ws.tableView reloadData];
    }];
    
    
    
    /**
     3.4.11	广场-广场主页-标签主页-列表（已测）
     @param type 标签类型 1：热门排序 2：时间排序
     @param clear 清空原数据
     */
    [self.viewModel getShowImageArrayOrderType:1 ClearData:YES];
    [self.viewModel.showImageHotArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    //时间排序
    [self.viewModel getShowImageArrayOrderType:2 ClearData:YES];
    [self.viewModel.showImageTimeArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    //用户
    [self.viewModel getShowViewUSersArray:YES];
    [self.viewModel.showViewUsersArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    //默认是动态
    switch (self.selectType) {
        case LBB_LabelDetailHot://热门
            [self.tableView setTableViewData:self.viewModel.showImageHotArray];
            
            break;
        case LBB_LabelDetailTime://时间
            [self.tableView setTableViewData:self.viewModel.showImageTimeArray];
            
            break;
        case LBB_LabelDetailUser://用户
            [self.tableView setTableViewData:self.viewModel.showViewUsersArray];
            break;
        default:
            break;
    }
    
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        [ws.viewModel getTagsViewModelData];
        [ws.viewModel getShowImageArrayOrderType:2 ClearData:YES];
        [ws.viewModel getShowImageArrayOrderType:1 ClearData:YES];
        [ws.viewModel getShowViewUSersArray:YES];
        
    } footerRefreshDatablock:^{
        [ws.tableView.mj_footer endRefreshing];
        switch (ws.selectType) {
            case LBB_LabelDetailHot://热门
                [ws.viewModel getShowImageArrayOrderType:1 ClearData:NO];
                
                break;
            case LBB_LabelDetailTime://时间
                [ws.viewModel getShowImageArrayOrderType:2 ClearData:NO];
                
                break;
            case LBB_LabelDetailUser://用户
                [ws.viewModel getShowViewUSersArray:NO];
                break;
            default:
                break;
        }
        
    }];
    
}


/*
 * setup navigation bar view
 */
-(void)setupNavigationUI{
    
    WS(ws);
    [self setBaseNavigationBarTitle:@"标签详情"];
    [self setBaseNavigationBarColor:ColorWhite];

    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:IMAGE(@"标签详情_分享") forState:UIControlStateNormal];
    [self.baseNavigationBarView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(kButtonWidth);
        make.bottom.equalTo(ws.baseNavigationBarView);
        make.right.equalTo(ws.baseNavigationBarView).offset(kSearchButtonMarginRight);
    }];
    [shareButton bk_addEventHandler:^(id sender){
        
        
        
    }forControlEvents:UIControlEventTouchUpInside];

}

/*
 * setup UI
 */
-(void)setupUI{
    
    WS(ws);
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.headerView = [[LBB_LabelDetailHeaderView alloc]init];
    [self.headerView setFrame:CGRectMake(0, 0, DeviceWidth, [LBB_LabelDetailHeaderView getHeight])];
    [self.baseContentView setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.hotDataSource = [[LBB_LabelDetailHotDataSource alloc] initWithTableView:self.tableView];
    self.hotDataSource.showImageArray = self.viewModel.showImageHotArray;
    
    self.timeDataSource = [[LBB_LabelDetailHotDataSource alloc] initWithTableView:self.tableView];
    self.timeDataSource.showImageArray = self.viewModel.showImageTimeArray;
    
    self.userDataSource = [[LBB_LabelDetailUserDataSource alloc] initWithTableView:self.tableView];
    self.userDataSource.showViewUsersArray = self.viewModel.showViewUsersArray;
    
    self.userDataSource.parentViewController = self;
    [self initViewModel];
    [self.baseContentView addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.centerX.equalTo(ws.baseContentView);
        make.bottom.equalTo(ws.baseContentView);
    }];
    
}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.selectType == LBB_LabelDetailUser) {
        return AutoSize(72/2)+SeparateLineWidth + AutoSize(54/2);

    }
    return AutoSize(72/2)+SeparateLineWidth;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    WS(ws);
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, height)];
    [v setBackgroundColor:ColorLine];
    NSArray* titleArray = @[@"热门",@"时间",@"用户"];
    NSArray* iconArray = @[@"标签详情_热门",@"标签详情_时间",@"标签详情_用户"];
    NSArray* iconHLArray = @[@"标签详情_热门HL",@"标签详情_时间HL",@"标签详情_用户HL"];
    CGFloat labelHeight = AutoSize(54/2);
    CGFloat width = (DeviceWidth - 2*SeparateLineWidth)/3;
    for (int i = 0; i<titleArray.count; i++) {
        
        UIButton* b = [UIButton new];
        [b setBackgroundColor:ColorWhite];
        [b setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [b.titleLabel setFont:Font13];
        if (self.selectType == i) {
            [b setImage:IMAGE(iconHLArray[i]) forState:UIControlStateNormal];
            [b setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        }
        else{
            [b setImage:IMAGE(iconArray[i]) forState:UIControlStateNormal];
            [b setTitleColor:ColorGray forState:UIControlStateNormal];
        }
        [v addSubview:b];
        [b mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(v).offset(i*(width+SeparateLineWidth));
            make.top.equalTo(v);
            make.width.mas_equalTo(width);
            if (self.selectType == LBB_LabelDetailUser) {
                make.bottom.equalTo(v).offset(-SeparateLineWidth - labelHeight);
            }
            else{
                make.bottom.equalTo(v).offset(-SeparateLineWidth);
            }
        }];
        [b bk_addEventHandler:^(id sender){
        
            ws.selectType = i;
            //默认是动态
            switch (self.selectType) {
                case LBB_LabelDetailHot://热门
                    [self.tableView setTableViewData:self.viewModel.showImageHotArray];
                    
                    break;
                case LBB_LabelDetailTime://时间
                    [self.tableView setTableViewData:self.viewModel.showImageTimeArray];
                    
                    break;
                case LBB_LabelDetailUser://用户
                     [self.tableView setTableViewData:self.viewModel.showViewUsersArray];
                    break;
                default:
                    break;
            }
            
            [ws.tableView reloadData];
        } forControlEvents:UIControlEventTouchUpInside];
    }

    if (self.selectType == LBB_LabelDetailUser) {
        UILabel* l = [UILabel new];
        [l setBackgroundColor:ColorLine];
        [l setTextColor:ColorLightGray];
        [l setFont:Font12];
        [l setText:[NSString stringWithFormat:@"  共有%ld位达人",self.viewModel.showViewUsersArray.count]];
        [v addSubview:l];
        [l mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.width.equalTo(v);
            make.height.mas_equalTo(labelHeight);
        }];
    }

    
    return v;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView numberOfRowsInSection:section];
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
            break;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView heightForRowAtIndexPath:indexPath];
            break;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.selectType) {
        case LBB_LabelDetailHot:
            return [self.hotDataSource tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailTime:
            return [self.timeDataSource tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
        case LBB_LabelDetailUser:
            return [self.userDataSource tableView:self.tableView didSelectRowAtIndexPath:indexPath];
            break;
    }
}

@end
