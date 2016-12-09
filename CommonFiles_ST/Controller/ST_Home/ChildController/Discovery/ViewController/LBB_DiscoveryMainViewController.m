//
//  LBB_DiscoveryMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryMainViewController.h"
#import "SDCycleScrollView.h"
#import "LBB_DiscoveryMainTableViewCell.h"
#import "LBB_DiscoveryCustomizedViewController.h"
#import "LBB_DiscoveryDetailViewController.h"
#import "LBB_FilterTableViewCell.h"
#import "LBBPoohVerticalButton.h"
#import "LBB_GuiderMainViewController.h"
#import "LBB_DiscoveryViewModel.h"
#import "LBB_FoodsMainViewController.h"
#import "LBB_HostelMainViewController.h"
#import "LBB_ScenicMainViewController.h"
#import "LBB_ScenicDetailViewController.h"
static NSString *cellIdentifier = @"LBB_DiscoveryMainTableViewCell";


@interface LBB_DiscoveryMainViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain)SDCycleScrollView* cycScrollView;
@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)LBB_DiscoveryViewModel* viewModel;


@property(nonatomic, assign)BOOL isCustom;//是否是自定义路线
@property(nonatomic, retain)NSArray<LBB_SquareTags*>* tagsArray;//标签数组
@property(nonatomic, retain)NSArray<LBB_SpotAddress*>* scenicArray; //景区列表数据
@property(nonatomic, retain)LBB_SquareTags* timeLine;


@end

@implementation LBB_DiscoveryMainViewController

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
    self.viewModel = [[LBB_DiscoveryViewModel alloc] init];
    
    
    /**
     3.1.2 广告轮播 1.首页最顶部
     @param clear 是否清空原数据
     */
    [self.viewModel getAdvertisementListArrayClearData:YES];
    
    //1.监听数据，用来刷新数据，数据变化才会调用
    [self.viewModel.advertisementArray.loadSupport setDataRefreshblock:^{
        
        [ws setCycleScrollViewUrls:ws.viewModel.advertisementArray];
    }];
    
    [self.viewModel getDiscoveryArrayClearData:YES];
    
    [self.viewModel.discoveryArray.loadSupport setDataRefreshblock:^{
        [ws.tableView reloadData];
    }];
    
    [self.tableView setTableViewData:self.viewModel.discoveryArray];
    
    [self.tableView setHeaderRefreshDatablock:^{
        ws.isCustom = NO;
        [ws.viewModel getDiscoveryArrayClearData:YES];

        [ws.tableView.mj_header endRefreshing];
        
    } footerRefreshDatablock:^{
        
        if (ws.isCustom) {
            [ws.viewModel getDiscoveryArrayClearData:ws.timeLine allSpots:ws.scenicArray tags:ws.tagsArray clear:NO];
        }
        else{
            [ws.viewModel getDiscoveryArrayClearData:NO];
        }

        [ws.tableView.mj_footer endRefreshing];

    }];
}

/*
 * setup navigation bar view
 */
-(void)loadCustomNavigationButton{
    self.title = @"攻略";
}

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    self.tableView.fd_debugLogEnabled = YES;

    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题

    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_DiscoveryMainTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    [self initViewModel];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [self configTableHeaderView];
    [self setCycleScrollViewUrls:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
/*
 * setup table header view
 */
-(UIView*)configTableHeaderView{
    WS(ws);

    CGFloat margin = 8;
    CGFloat height = AutoSize(310/2)
                    + 4*margin + 2*margin
                    + 2*margin + AutoSize(48/2)
                    + 2*margin + 10;
    UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, height)];
    [v setBackgroundColor:[UIColor whiteColor]];
    // 情景一：采用本地图片实现
    
    self.cycScrollView = [[SDCycleScrollView alloc]init];
    self.cycScrollView.placeholderImage = IMAGE(PlaceHolderImage);
    self.cycScrollView.infiniteLoop = YES;
    self.cycScrollView.autoScrollTimeInterval = 2;
    //  cycleScrollView.localizationImageNamesGroup = imageNames;
    
    self.cycScrollView.delegate = self;
    //  cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [v addSubview:self.cycScrollView];
    [self.cycScrollView mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.top.equalTo(v);
        make.height.mas_equalTo(AutoSize(310/2));
    }];
    
    
    UIView* bgView = [UIView new];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [v addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(ws.cycScrollView.mas_bottom);
        make.left.right.equalTo(v);
        make.height.mas_equalTo(4*margin + AutoSize(48/2) + 2*margin);
    }];
    
    UIView* v1 = [UIView new];
    [bgView addSubview:v1];
    UIView* v2 = [UIView new];
    [bgView addSubview:v2];
    
    [v1 mas_makeConstraints:^(MASConstraintMaker* make){
    
        make.left.top.bottom.equalTo(bgView);
    }];
    [v2 mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.right.top.bottom.equalTo(bgView);
        make.left.equalTo(v1.mas_right);
        make.width.equalTo(v1);
    }];
    
    LBBPoohVerticalButton* btn1 = [[LBBPoohVerticalButton alloc]init];
    [btn1.titleLabel setText:@"定制个性化攻略"];
    [btn1.titleLabel setTextColor:[UIColor blackColor]];
    [btn1.titleLabel setFont:Font12];
    [btn1.imageView setImage:IMAGE(@"ST_Discovery_攻略")];
    [v1 addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.center.equalTo(v1);
    }];
    [btn1 bk_addEventHandler:^(id sender){
        
        
        LBB_DiscoveryCustomizedViewController* dest = [[LBB_DiscoveryCustomizedViewController alloc]init];
        dest.click = ^(LBB_DiscoveryCustomizedViewController* vc ,LBB_SquareTags* timeLine , NSArray<LBB_SpotAddress*>*scenicArray , NSArray<LBB_SquareTags*>*tagsArray ){
        
            
            ws.timeLine = timeLine;//[timeLine copy];
            ws.scenicArray = scenicArray;//[scenicArray copy];
            ws.tagsArray = tagsArray;//[tagsArray copy];
            [ws.viewModel getDiscoveryArrayClearData:ws.timeLine allSpots:ws.scenicArray tags:ws.tagsArray clear:YES];

            [vc.navigationController popViewControllerAnimated:YES];
        };
    
        [ws.navigationController pushViewController:dest animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    LBBPoohVerticalButton* btn2 = [[LBBPoohVerticalButton alloc]init];
    [btn2.titleLabel setText:@"鹭岛导游推荐"];
    [btn2.titleLabel setTextColor:[UIColor blackColor]];
    [btn2.titleLabel setFont:Font12];
    [btn2.imageView setImage:IMAGE(@"ST_Discovery_导游")];
    [v2 addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.center.equalTo(v2);
    }];
    [btn2 bk_addEventHandler:^(id sender){
        
        
        LBB_GuiderMainViewController* dest = [[LBB_GuiderMainViewController alloc]init];
        [ws.navigationController pushViewController:dest animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];

    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [v addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.bottom.width.centerX.equalTo(v);
        make.height.mas_equalTo(10);
        make.top.equalTo(bgView.mas_bottom);//.offset(2*margin);
    }];
    
    return v;
}


-(void)setCycleScrollViewUrls:(NSMutableArray<BN_HomeAdvertisement *> *)adModelArray{
    
    NSMutableArray* urls = [NSMutableArray new];
    for (BN_HomeAdvertisement* obj in adModelArray) {
        
        [urls addObject:obj.picUrl];
    }
    NSLog(@"urls:%@",urls);
    self.cycScrollView.imageURLStringsGroup = urls;
}
#pragma SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
    BN_HomeAdvertisement* model = [self.viewModel.advertisementArray objectAtIndex:index];
    NSLog(@"cycleScrollView didSelect :%@",model);
    
    switch (model.classes) {
        case 1://外部链接
        {
            LBB_ToWebViewController *webViewController = [[LBB_ToWebViewController alloc]init];
            webViewController.url = [NSURL URLWithString:model.hrefUrl];
            [[self getViewController].navigationController pushViewController:webViewController animated:YES];
        }
            break;
        case 2://列表
        {
            UIViewController* dest;
            switch (model.type) {
                case 1://美食
                    dest = [[LBB_FoodsMainViewController alloc] init];
                    break;
                case 2://民宿
                    dest = [[LBB_HostelMainViewController alloc] init];
                    break;
                case 3://景点
                    dest = [[LBB_ScenicMainViewController alloc] init];
                    break;
                case 4://伴手礼
                    break;
                default:
                    break;
            }
            if (dest) {
                [self.navigationController pushViewController:dest animated:YES];
            }
            
        }
            break;
        case 3://详情
        {
            LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc] init];
            LBB_SpotModel* viewModel = [[LBB_SpotModel alloc]init];
            viewModel.allSpotsId = model.objId;//主键Id
            dest.spotModel = viewModel;
            switch (model.type) {
                case 1://美食
                    dest.homeType = LBBPoohHomeTypeFoods;
                    break;
                case 2://民宿
                    dest.homeType = LBBPoohHomeTypeHostel;
                    break;
                case 3://景点
                    dest.homeType = LBBPoohHomeTypeScenic;
                    break;
                case 4://伴手礼
                    break;
                default:
                    break;
            }
            if (dest) {
                [self.navigationController pushViewController:dest animated:YES];
            }
        }
            break;
            
        default:
            break;
    }

}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* v = [UIView new];
    return v;
};

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return AutoSize(86/2);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* v = [UIView new];
    [v setBackgroundColor:[UIColor whiteColor]];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, UISCREEN_WIDTH, height)];
    
    
    CGFloat margin = 8;
    UIView* sep = [UIView new];
    [sep setBackgroundColor:[UIColor blackColor]];
    [v addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerY.equalTo(v);
        make.height.mas_equalTo(20);
        make.left.equalTo(v).mas_offset(margin);
        make.width.mas_offset(SeparateLineWidth*2);
    }];
    
    UILabel* l = [UILabel new];
    [l setText:@"推荐线路攻略"];
    [l setTextColor:ColorGray];
    [l setFont:Font15];
    [v addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v);
        make.left.equalTo(sep.mas_right).offset(4);
    }];
    
    NSArray* segmentArray = @[@""];
    
    BN_FilterMenu* segmentedControl = [[BN_FilterMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];;
    [segmentedControl setTextColor:ColorGray];
    [segmentedControl setSelectedTextColor:ColorBtnYellow];
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = ColorLine.CGColor;
    segmentedControl.menuArray = segmentArray;
    [v addSubview:segmentedControl];
    segmentedControl.hidden = YES;
    
    UILabel* titleLabel = [UILabel new];
    [titleLabel setText:@"筛选"];
    [titleLabel setFont:Font15];
    [titleLabel setTextAlignment:NSTextAlignmentRight];
    [v addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v);
        make.right.equalTo(v).offset(-AutoSize(24));
    }];
    titleLabel.hidden = YES;
    
    
    //返回section数组
    [segmentedControl getMenuDataSectionArrayInBlock:^NSArray*(NSInteger index, NSString *title){
            return @[
                     @[@"时间选择",@"ST_Discovery_TimeSL"],
                     @[@"区域选择",@"ST_Discovery_AreaSL"],
                     @[@"爱好选择",@"ST_Discovery_FavoriteWhite"],
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
        
        UIImageView* arrowView = [UIImageView new];
        [arrowView setImage:IMAGE(@"景点专题_箭头Down")];
        [view addSubview:arrowView];
        [arrowView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(-20);
        }];
        
        return view;
    }];
    [segmentedControl heightForSectionInBlock:^CGFloat(NSInteger index, NSInteger section,id data){
        return AutoSize(56/2);

    }];
    //返回数据数组
    [segmentedControl getMenuDataRowArrayInBlock:^NSArray*(NSInteger index, NSString *title, NSInteger section){
        
            if (section == 0) {
                return @[
                         @[@"1日游",@"2日游",@"3日游",@"3-5日游",@"5-7日游",@"其他"]
                         ];
            }
            else if (section == 1){
                return @[
                         @[@"岛内",@"岛内-岛外",@"厦门周边"]
                         ];
            }
            else{
                return @[
                         @[@"我是吃货",@"运动达人",@"文艺小资"]
                         ];
            }
            
        
    }];
    //返回每行的高度
    [segmentedControl heightForRowInBlock:^CGFloat(NSInteger index, NSIndexPath *indexPath, id data) {
        return [LBB_FilterTableViewCell getCellHeight:data];

    }];
    //返回cell
    [segmentedControl getCellInBlock:^UITableViewCell*(NSInteger index, NSIndexPath *indexPath, NSArray* data) {
        NSLog(@"data:%@",data);
        
            static NSString *cellIdentifier = @"LBB_FilterTableViewCell";
            LBB_FilterTableViewCell* cell = [[LBB_FilterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.bottomMargin = AutoSize(15);
            cell.selectIndex = 0;
            [cell configContentView:data];
            
            cell.click = ^(NSNumber* num){
                
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
        }];
        
        return bottomView;
        
    }];

    return v;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.viewModel.discoveryArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(LBB_DiscoveryMainTableViewCell *cell) {
        
        [cell setModel:self.viewModel.discoveryArray[indexPath.row]];
    }];
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBB_DiscoveryMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_DiscoveryMainTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_DiscoveryMainTableViewCell nil");
    }
    [cell setModel:self.viewModel.discoveryArray[indexPath.row]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    LBB_DiscoveryDetailViewController* dest = [[LBB_DiscoveryDetailViewController alloc]init];
    dest.viewModel = self.viewModel.discoveryArray[indexPath.row];
    [self.navigationController pushViewController:dest animated:YES];
}


@end
