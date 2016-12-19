//
//  LBB_GuiderMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderMainViewController.h"
#import "LBB_GuiderMainCell.h"
#import "LBB_GuiderApplyViewController.h"
#import "LBB_GuiderUserViewController.h"
#import "LBB_FilterTableViewCell.h"
#import "LBB_TagsViewModel.h"
#import "LBB_GuiderViewModel.h"

@interface LBB_GuiderMainViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView* tableView;

@property(nonatomic, strong) NSTimer *timer;


//菜单选项的选择项
@property (nonatomic,assign)NSInteger guiderSelectIndex;//导游选择
@property (nonatomic,assign)NSInteger jobTimeSelectIndex;//从业时间
@property (nonatomic,assign)NSInteger genderSelectIndex;//性别选择

@property (nonatomic, strong)LBB_GuiderViewModel* viewModel;

@end

@implementation LBB_GuiderMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.guiderSelectIndex = -1;//导游选择
    self.jobTimeSelectIndex = -1;//从业时间
    self.genderSelectIndex = -1;//性别选择
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
    self.viewModel = [[LBB_GuiderViewModel alloc]init];
    
    /**
     3.7.5 导游 – 查询条件（已测）
     */
    [self.viewModel getGuiderConditions];
    [self.viewModel.guiderCondition.loadSupport setDataRefreshblock:^{
        [ws getGuiderList:YES];
    }];
    
    /**
     3.7.6 导游 -列表（已测）
     @param name       模糊查询名字
     @param tagKey     标签key
     @param jobTimeKey 工作时长key
     @param genderKey  性别key
     @param clear      清空原数据
     */
    [self.viewModel.guiderListArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];//data reload
        //[ws reloadTableSnap];
    }];

    //3.0 table view 的数据绑定，刷新，上拉刷新，下拉加载。全部集成在里面
    [self.tableView setTableViewData:self.viewModel.guiderListArray];
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.viewModel guiderCondition];// 3 3.7.5 导游 – 查询条件（已测）
        [ws getGuiderList:YES];
        [ws.tableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        [ws getGuiderList:NO];
        [ws.tableView.mj_footer endRefreshing];
    }];

    
}



/**
 获取导游列表

 @param clear 清空数据
 */
-(void)getGuiderList:(BOOL)clear{
    
    int tagKey = -1;//导游选择
    int jobTimeKey = -1;//从业时间
    int genderKey = -1;//性别选择
    
    if (self.viewModel.guiderCondition.tags.count > 0) {
        
        if (self.guiderSelectIndex >= 0) {
            LBB_GuiderConditionOption* tagObj = [self.viewModel.guiderCondition.tags objectAtIndex:self.guiderSelectIndex];
            tagKey = tagObj.key;
            tagKey = -1;
        }
    }
    
    if (self.viewModel.guiderCondition.jobTime.count > 0) {
        
        if (self.jobTimeSelectIndex >= 0) {
            LBB_GuiderConditionOption* tagObj = [self.viewModel.guiderCondition.jobTime objectAtIndex:self.jobTimeSelectIndex];
            jobTimeKey = tagObj.key;
        }
    }
    
    if (self.viewModel.guiderCondition.gender.count > 0) {
        
        if (self.genderSelectIndex >= 0) {
            LBB_GuiderGenderConditionOption* tagObj = [self.viewModel.guiderCondition.gender objectAtIndex:self.genderSelectIndex];
            genderKey = tagObj.key;
        }
    }
    /**
     3.7.6 导游 -列表（已测）
     @param name       模糊查询名字
     @param tagKey     标签key
     @param jobTimeKey 工作时长key
     @param genderKey  性别key
     @param clear      清空原数据
     */
    [self.viewModel getGuiderListArray:self.searchBar.text tagKey:tagKey jobTimeKey:jobTimeKey genderKey:genderKey clear:clear];
    
}


-(void)loadCustomNavigationButton{
  
    CGFloat height = IAppNavigationBarHeight - 10;
    CGFloat width = DeviceWidth - 2*45 - 30;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = [UIColor blackColor].CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.cornerRadius = height/2;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = @"请搜索用户";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    [titleView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(titleView);
    }];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
}


/*
 *  setup UI
 */
-(void)buildControls{

    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_GuiderMainCell class] forCellReuseIdentifier:@"LBB_GuiderMainCell"];
    [self initViewModel];
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
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
    [self getGuiderList:YES];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchBar becomeFirstResponder];
    return YES;
}
// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerSearch) userInfo:nil repeats:NO];
}

- (void)timerSearch{
    [self getGuiderList:YES];

}
#pragma tableView Delegate


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AutoSize(40);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    WS(ws);
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView* v = [UIView new];
    [v setBackgroundColor:ColorWhite];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
 
    UIButton* b1 = [UIButton new];
    [b1 setTitle:@"申请导游证 >" forState:UIControlStateNormal];
    [b1 setTitleColor:ColorBlack forState:UIControlStateNormal];
    [b1.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    b1.layer.borderColor = ColorLine.CGColor;
    b1.layer.borderWidth = SeparateLineWidth;
    b1.layer.masksToBounds = YES;
    [v addSubview:b1];
    [b1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.equalTo(v);
        make.width.mas_equalTo(AutoSize(250/2));
        make.height.mas_equalTo(AutoSize(40/2));

    }];
    
    [b1 bk_addEventHandler:^(id sender){
    
        LBB_GuiderApplyViewController* dest = [[LBB_GuiderApplyViewController alloc]init];
      //  dest.showLabelTag = YES;
        dest.tags = ws.viewModel.guiderCondition.tags;
        [ws.navigationController pushViewController:dest animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];

    
    //设置
    NSString* strFormat1 = @"申请导游证 >";
    NSString* strFormat2 = @">";
    UIColor* fontColor = ColorLine;
    NSDictionary* attrsDic = @{NSForegroundColorAttributeName:fontColor,
                               NSFontAttributeName:Font14};    //显示的字符串进行富文本转换
    NSMutableAttributedString* strAttr = [[NSMutableAttributedString alloc]initWithString:strFormat1];
    //字体设置
    NSRange rang = [strFormat1 rangeOfString:strFormat2];
    if (rang.location != NSNotFound) {
       // NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
        [strAttr addAttributes:attrsDic range:NSMakeRange(rang.location, rang.length)];
    }else{
       // NSLog(@"Not Found");
    }
    b1.titleLabel.attributedText = strAttr;
   
    
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [v addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.bottom.equalTo(v);
        make.height.mas_equalTo(SeparateLineWidth);
    }];
    
    NSArray* segmentArray = @[@""];
    
    BN_FilterMenu* segmentedControl = [[BN_FilterMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];;
    [segmentedControl setTextColor:ColorGray];
    [segmentedControl setSelectedTextColor:ColorBtnYellow];
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = ColorLine.CGColor;
    segmentedControl.menuArray = segmentArray;
    [v addSubview:segmentedControl];
    
    [v bringSubviewToFront:b1];
    
    UILabel* titleLabel = [UILabel new];
    [titleLabel setText:@"筛选"];
    [titleLabel setTextColor:ColorLightGray];
    [titleLabel setFont:Font14];
    [titleLabel setTextAlignment:NSTextAlignmentRight];
    [v addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v);
        make.right.equalTo(v).offset(-AutoSize(24));
    }];
    
    
    //返回section数组
    [segmentedControl getMenuDataSectionArrayInBlock:^NSArray*(NSInteger index, NSString *title){
        return @[
                 @[@"导游选择",@"导游_导游选择"],
                 @[@"从业时间",@"导游_从业时间-筛选"],
                 @[@"性别选择",@"导游_性别选择"],
                 ];
        
    }];
    [segmentedControl getSectionInBlock:^UIView*(NSInteger index, NSInteger section, id data){
        
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
        
        return view;
    }];
    [segmentedControl heightForSectionInBlock:^CGFloat(NSInteger index, NSInteger section,id data){
        return AutoSize(56/2);
        
    }];
    //返回数据数组
    [segmentedControl getMenuDataRowArrayInBlock:^NSArray*(NSInteger index, NSString *title, NSInteger section){
        
        if (section == 0) {//导游
            return @[];
            if (ws.viewModel.guiderCondition.tags.count <= 0) {
                return @[];
            }
            return @[ws.viewModel.guiderCondition.tags];
        }
        else if (section == 1){//从业时间
            if (ws.viewModel.guiderCondition.jobTime.count <= 0) {
                return @[];
            }
            return @[ws.viewModel.guiderCondition.jobTime];
        }
        else{//性别
            if (ws.viewModel.guiderCondition.gender.count <= 0) {
                return @[];
            }
            return @[ws.viewModel.guiderCondition.gender];
        }
        
        
    }];
    //返回每行的高度
    [segmentedControl heightForRowInBlock:^CGFloat(NSInteger index, NSIndexPath *indexPath, id data) {
        return [LBB_FilterTableViewCell getCellHeight:data];
        
    }];
    //返回cell
    [segmentedControl getCellInBlock:^UITableViewCell*(NSInteger index, NSIndexPath *indexPath, NSArray* data) {
     //   NSLog(@"data:%@",data);
        
        static NSString *cellIdentifier = @"LBB_FilterTableViewCell";
        LBB_FilterTableViewCell* cell = [[LBB_FilterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.bottomMargin = AutoSize(15);
        
      //  NSLog(@"array:%@",data);
        if (indexPath.section == 0) {//导游选择
            cell.selectIndex = ws.guiderSelectIndex;
        }
        else if (indexPath.section == 1){//从业时间
            cell.selectIndex = ws.jobTimeSelectIndex;
        }
        else{//性别
            cell.selectIndex = ws.genderSelectIndex;
        }
        
        NSArray* dataArray;
        
        if (indexPath.section == 2) {
            dataArray = [data map:^id(LBB_GuiderGenderConditionOption* model){
                return model.gender;
            }];
        }
        else{
            dataArray = [data map:^id(LBB_GuiderConditionOption* model){
                return model.name;
            }];
        }

      //  NSLog(@"dataArray:%@",dataArray);
        
        [cell configContentView:dataArray];
        
        cell.click = ^(NSNumber* num){
            if (indexPath.section == 0) {//导游选择
                ws.guiderSelectIndex = [num integerValue];
            }
            else if (indexPath.section == 1){//从业时间
                ws.jobTimeSelectIndex = [num integerValue];
            }
            else{//性别
                ws.genderSelectIndex = [num integerValue];
            }
            [segmentedControl reloadData];
            
        };
        return cell;
        
        
    }];
    //cell的选中动作
    [segmentedControl didDeselectRowAtIndexPathBlock:^(NSInteger index, NSIndexPath *indexPath, id data) {
        NSLog(@"index:%ld,选择 %@",index,data);
        
    }];
    
    //返回bottomView
    [segmentedControl getMenuBottomViewInBlock:^UIView*(NSInteger index, NSString *title){
        
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
            [ws getGuiderList:YES];
        }];
        
        return bottomView;
        
    }];
    

    
    return v;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.guiderListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LBB_GuiderMainCell";
    LBB_GuiderMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_GuiderMainCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_GuiderMainCell nil");
    }
    
    LBB_GuiderListViewModel* obj = self.viewModel.guiderListArray[indexPath.row];
    [cell setModel:obj];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LBB_GuiderListViewModel* obj = self.viewModel.guiderListArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:@"LBB_GuiderMainCell" cacheByIndexPath:indexPath configuration:^(LBB_GuiderMainCell *cell) {
        [cell setModel:obj];
    }];
}

@end
