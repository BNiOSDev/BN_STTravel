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

static NSString *cellIdentifier = @"LBB_DiscoveryMainTableViewCell";


@interface LBB_DiscoveryMainViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic, retain)UITableView* tableView;
@property(nonatomic, retain)SDCycleScrollView* cycScrollView;
@property(nonatomic, strong)NSMutableArray *dataArray;

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
    
    UILabel* l = [UILabel new];
    [l setText:@"鹭爸爸为您定制个性化厦门游攻略"];
    [l setTextColor:ColorGray];
    [l setFont:Font14];
    [l setTextAlignment:NSTextAlignmentCenter];
    [v addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.top.equalTo(ws.cycScrollView.mas_bottom).offset(4*margin);
        make.left.right.equalTo(v);
        make.height.mas_equalTo(2*margin);
    }];
    
    UIButton* b = [UIButton new];
    [b setTitle:@"立即定制" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [b.titleLabel setFont:Font13];
    [b setBackgroundColor:ColorBtnYellow];
    [v addSubview:b];
    [b mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.equalTo(v);
        make.top.equalTo(l.mas_bottom).offset(2*margin);
        make.height.mas_equalTo(AutoSize(48/2));
        make.width.mas_equalTo(AutoSize(168/2));
    }];
    [b bk_addEventHandler:^(id sender){
        
        
        LBB_DiscoveryCustomizedViewController* dest = [[LBB_DiscoveryCustomizedViewController alloc]init];
        [ws.navigationController pushViewController:dest animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [v addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.bottom.width.centerX.equalTo(v);
        make.height.mas_equalTo(10);
        make.top.equalTo(b.mas_bottom).offset(2*margin);
    }];
    
    return v;
}


-(void)setCycleScrollViewUrls:(NSArray*)urlArray{
    
    NSArray* imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg",
                                  @"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690",
                                  @"http://img5.poco.cn/mypoco/myphoto/20080721/19/43214503200807211940527014829584496_033_640.jpg",
                                  @"http://img2.ph.126.net/O_N-vMFrIBv-vaXfC40fcA==/1679279711155879130.jpg",
                                  @"http://upload.sanqin.com/2014/0820/1408524577544.jpg",
                                  ];
    //  imagesURLStrings = @[@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg" ];
    self.cycScrollView.imageURLStringsGroup = imagesURLStrings;
}
#pragma SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"cycleScrollView didSelectItemAtIndex:%ld",index);
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
        make.left.equalTo(v).mas_offset(2*margin);
        make.width.mas_offset(SeparateLineWidth);
    }];
    
    UILabel* l = [UILabel new];
    [l setText:@"推荐线路攻略"];
    [l setTextColor:ColorGray];
    [l setFont:Font15];
    [v addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(v);
        make.left.equalTo(sep.mas_right).offset(2);
    }];
    
    return v;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(LBB_DiscoveryMainTableViewCell *cell) {
        
        [cell setModelaaa:nil andRow:indexPath.row];
    }];
    NSLog(@"height:%f",height);
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBB_DiscoveryMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_DiscoveryMainTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBB_DiscoveryMainTableViewCell nil");
    }
    [cell setModelaaa:nil andRow:indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    LBB_DiscoveryDetailViewController* dest = [[LBB_DiscoveryDetailViewController alloc]init];
    
    [self.navigationController pushViewController:dest animated:YES];
}


@end
