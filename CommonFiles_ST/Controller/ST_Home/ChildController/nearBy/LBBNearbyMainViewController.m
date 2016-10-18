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

@interface LBBNearbyMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UIView* mapView;
@property (nonatomic, retain) UITableView* tableView;

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
    [self.mapView setFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 150)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBBNearbyMenuListTableViewCell class] forCellReuseIdentifier:@"LBBNearbyMenuListTableViewCell"];

}


#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, UISCREEN_WIDTH, height)];
    
    NSArray* segmentArray = @[@"景点",@"美食",@"民宿"];

    
    KSViewPagerView* pagerView = [[KSViewPagerView alloc] initWithArray:segmentArray];
    [v addSubview:pagerView];
    pagerView.backgroundColor = [UIColor whiteColor];
    [pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(v);
    }];
    [pagerView setActiveColor:[UIConstants getProminentFillColor]];
    [pagerView setInactiveColor:[UIColor colorWithRGB:0xafafaf]];
    [pagerView setTitleFont:Font3];
    [pagerView enableSeperatorView:YES];
    [pagerView.cursorView setHidden:YES];
    pagerView.click = ^(KSViewPagerView*v, NSNumber *index){
        
        
    };
    [pagerView setCursorPosition:0];
    
    return v;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 14;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBBPoohBaseTableViewCell* cell = (LBBPoohBaseTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return [cell getCellHeight];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) { //ad
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
        }
        
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


@end
