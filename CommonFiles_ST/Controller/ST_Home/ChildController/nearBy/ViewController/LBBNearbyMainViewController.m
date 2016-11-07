//
//  LBBNearbyMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBNearbyMainViewController.h"
#import "KSViewPagerView.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBBNearbyMenuListTableViewCell.h"
#import "LBB_ScenicDetailViewController.h"

typedef NS_ENUM(NSInteger, LBB_NearbyMenuType) {
    LBB_NearbyMenuScenicType = 0,//景点
    LBB_NearbyMenuFoodsType,//美食
    LBB_NearbyMenuHostelType,//民宿
};

@interface LBBNearbyMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UIView* mapView;
@property (nonatomic, retain) UITableView* tableView;
@property(nonatomic, assign)  LBB_NearbyMenuType selectType;

@end

@implementation LBBNearbyMainViewController

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
 * setup Navigation UI
 */

-(void)loadCustomNavigationButton{
    self.title = @"附近";
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题

    self.mapView = [UIView new];
    [self.mapView setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
    [self.mapView setFrame:CGRectMake(0, 0, DeviceWidth, AutoSize(490/2))];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBBNearbyMenuListTableViewCell class] forCellReuseIdentifier:@"LBBNearbyMenuListTableViewCell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];

    self.tableView.tableHeaderView = self.mapView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    


}


#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return AutoSize(TopSegmmentControlHeight);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    NSArray* segmentArray = @[@"景点",@"美食",@"民宿"];

    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
    segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                             NSForegroundColorAttributeName:ColorLightGray};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:Font15,
                                                     NSForegroundColorAttributeName:ColorBtnYellow};
    segmentedControl.selectionIndicatorColor = [UIColor clearColor];
    segmentedControl.verticalDividerWidth = SeparateLineWidth;
    segmentedControl.verticalDividerColor = ColorLightGray;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectedSegmentIndex = self.selectType;
    [v addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(v);
    }];
    WS(ws);
    segmentedControl.indexChangeBlock = ^(NSInteger index){
        NSLog(@"segmentedControl select:%ld",index);
        ws.selectType = index;
        [ws.tableView reloadData];
    };

    return v;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 14;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return  [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
            [cell setCycleScrollViewHeight:AutoSize(226/2)];
            [cell setCycleScrollViewUrls:nil];
        }];
    }
    else{
        return  [tableView fd_heightForCellWithIdentifier:@"LBBNearbyMenuListTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBNearbyMenuListTableViewCell* cell){

        }];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) { //ad
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
        }
        [cell setCycleScrollViewHeight:AutoSize(226/2)];
        [cell setCycleScrollViewUrls:nil];
        
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBBNearbyMenuListTableViewCell";
        LBBNearbyMenuListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBNearbyMenuListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
            NSLog(@"LBBNearbyMenuListTableViewCell nil");
        }
        cell.portraitImageView.layer.cornerRadius = 5;
        cell.portraitImageView.layer.masksToBounds = YES;
        [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/h%3D200/sign=5c00db24cd95d143c576e32343f18296/03087bf40ad162d9ec74553b14dfa9ec8a13cd7a.jpg"] placeholderImage:IMAGE(@"poohtest")];
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    switch (self.selectType) {
        case LBB_NearbyMenuScenicType://景点
            dest.homeType = LBBPoohHomeTypeScenic;
            break;
        case LBB_NearbyMenuFoodsType://美食
            dest.homeType = LBBPoohHomeTypeFoods;
            break;
        case LBB_NearbyMenuHostelType://民宿
            dest.homeType = LBBPoohHomeTypeHostel;
            break;
    }
    if (dest) {
        [self.navigationController pushViewController:dest animated:YES];
    }
    
}

@end
