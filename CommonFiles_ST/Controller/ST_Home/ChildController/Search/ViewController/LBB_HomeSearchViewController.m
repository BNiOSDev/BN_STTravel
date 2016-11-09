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



@interface LBB_HomeSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, retain)UISearchBar* searchBar;
@property(nonatomic, retain)UITableView* tableView;

@property(nonatomic, assign)LBBPoohHomeSearchType showType;


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
    
    //  self.title = @"取消";
    UIButton *cancel = [[UIButton alloc] init];
    cancel.titleLabel.font = Font14;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.frame = CGRectMake(0, 0, 45, 45);
    [cancel bk_addEventHandler:^(id sender){
        
        [ws.navigationController popViewControllerAnimated:YES];
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    
    CGFloat height = NavHeight - 10;
    CGFloat width = DeviceWidth - 45 - 15;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
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
    [titleView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(titleView);
    }];
    
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");
    
    self.showType = self.searchType;//按下搜索按钮，展示搜索结果
    
    [self.tableView reloadData];
    
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

/*
 *  setup UI
 */
-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self loadCustomCell];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setBackgroundColor:ColorLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        make.top.equalTo(ws.view);
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
        return 3;
    }
    else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
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
                    
                    [cell setModel:nil];
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
                [cell setModel:nil];
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
                [cell setModel:nil];
                
                
                return cell;
            }
                break;
            case LBBPoohHomeSearchTypeTravel://游记
            {
                LBBTravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBBTravelTableViewCell"];
                cell.cellBlock = ^(id view,UITableViewCellViewSignal signal){
                };
                ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
                cell.viewType = TravelsViewMainSqure;
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
        [self.tableView reloadData];
    }
    
}

@end
