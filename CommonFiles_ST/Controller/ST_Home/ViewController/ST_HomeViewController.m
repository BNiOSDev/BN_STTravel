//
//  ST_HomeViewController.m
//  ST_Travel
//
//  Created by newman on 16/10/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ST_HomeViewController.h"
#import "ST_TabBarController.h"
#import "LBBPoohVerticalButton.h"

#import "LBBHomeSearchResultViewController.h"
#import "LBBNearbyMainViewController.h"
#import "LBBSigninMainViewController.h"


#import "LBBPoohCycleScrollCell.h"
#import "LBBPoohBaseTableSectionHeaderView.h"
#import "LBBHomeMenuTableViewCell.h"
#import "LBBHomeAnnouncementTableViewCell.h"
#import "LBBHomeHotestTableViewCell.h"
#import "LBBHomeTravelRecommendTableViewCell.h"
#import "LBBHomeSquareCenterTableViewCell.h"


typedef NS_ENUM(NSInteger, LBBHomeSectionType) {
    LBBHomeSectionMenuType = 0,//入口
    LBBHomeSectionHotestType,//热门推荐
    LBBHomeSectionVisitRecommendType,//游记推荐
    LBBHomeSectionVipRecommendType,//达人推荐
    LBBHomeSectionSquareCenterType,//广场中心
    LBBHomeSectionVisitProductType,//旅游产品
};


@interface ST_HomeViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSArray* sectionArray;
@property (nonatomic, retain) UITableView* tableView;

@end

@implementation ST_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];

}

/*
-(BOOL)prefersStatusBarHidden{
    return YES;
}
*/
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
    LBBPoohVerticalButton *back = [[LBBPoohVerticalButton alloc] init];
    back.titleLabel.font = Font1;
    back.titleLabel.text = @"附近";
    back.frame = CGRectMake(0, 0, 45, 45);
    [back.imageView setImage:IMAGE(@"PoohNearby")];
    [back bk_whenTapped:^{
        
        NSLog(@"back touch");
        LBBNearbyMainViewController* v = [[LBBNearbyMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
    }];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    LBBPoohVerticalButton *sign = [[LBBPoohVerticalButton alloc] init];
    sign.titleLabel.font = Font1;
    sign.titleLabel.text = @"签到";
    sign.frame = CGRectMake(0, 0, 45, 45);
    [sign.imageView setImage:IMAGE(@"PoohSign")];
    [sign bk_whenTapped:^{
        
        NSLog(@"signButton touch");
        LBBSigninMainViewController* v = [[LBBSigninMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
        
    }];
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:sign];
    self.navigationItem.rightBarButtonItem = signItem;
    
    
    CGFloat height = IAppNavigationBarHeight - 10;
    CGFloat width = UISCREEN_WIDTH - 2*45 - 30;

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//allocate titleView
    UISearchBar *bar = [UISearchBar new];
    bar.barStyle = UIBarStyleDefault;
    
    bar.layer.borderColor = [UIColor blackColor].CGColor;
    bar.layer.borderWidth = 0.8;
    bar.layer.cornerRadius = height/2;
    bar.layer.masksToBounds = YES;
    [bar setBackgroundImage:[UIImage new]];
    bar.delegate = self;
    bar.placeholder = @"请输入 景点 美食 民宿";
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
    self.sectionArray = @[
                          @[@"",@""],
                          @[@"热门推荐",@"poohtest"],
                          @[@"游记推荐",@"poohtest"],
                          @[@"达人推荐",@"poohtest"],
                          @[@"广场中心",@"poohtest"],
                          @[@"旅游产品",@"poohtest"],
                          
                          ];
    
    WS(ws);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBBHomeMenuTableViewCell class] forCellReuseIdentifier:@"LBBHomeMenuTableViewCell"];
    [self.tableView registerClass:[LBBHomeAnnouncementTableViewCell class] forCellReuseIdentifier:@"LBBHomeAnnouncementTableViewCell"];
    [self.tableView registerClass:[LBBHomeHotestTableViewCell class] forCellReuseIdentifier:@"LBBHomeHotestTableViewCell"];
    [self.tableView registerClass:[LBBHomeTravelRecommendTableViewCell class] forCellReuseIdentifier:@"LBBHomeTravelRecommendTableViewCell"];
    [self.tableView registerClass:[LBBHomeSquareCenterTableViewCell class] forCellReuseIdentifier:@"LBBHomeSquareCenterTableViewCell"];

}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"searchBarSearchButtonClicked");

}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchBar becomeFirstResponder];
    return YES;
}


#pragma tableView Delegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == LBBHomeSectionMenuType) {
        return 0;
    }
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == LBBHomeSectionMenuType) {
        return [UIView new];
    }
    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, UISCREEN_WIDTH, height)];
    
    LBBPoohBaseTableSectionHeaderView* header = [[LBBPoohBaseTableSectionHeaderView alloc]init];
    [v addSubview:header];
    [header.titleLabel setText:[[self.sectionArray objectAtIndex:section] objectAtIndex:0]];
    [header.iconView setImage:IMAGE([[self.sectionArray objectAtIndex:section] objectAtIndex:1])];
    [header mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(v);
    }];
    
    [header.markButton bk_addEventHandler:^(id sender){
    
        NSLog(@" section header button click:%ld",section);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    return v;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    switch (section) {
        case LBBHomeSectionMenuType:
            {
                return 3;
            }
            break;

        case LBBHomeSectionHotestType:
            {
                return 2;
            }
            break;
        case LBBHomeSectionVisitRecommendType:
            {
                return 2;
            }
            break;
        case LBBHomeSectionVipRecommendType:
            {
                return 2;
            }
            break;
        case LBBHomeSectionSquareCenterType:
            {
                return 2;
            }
            break;
        case LBBHomeSectionVisitProductType:
            {
                return 2;
            }
            break;
        default:
            return 0;
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBBPoohBaseTableViewCell* cell = (LBBPoohBaseTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return [cell getCellHeight];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell;
    
    switch (indexPath.section) {
        case LBBHomeSectionMenuType:
        {
            cell = [self tableView:tableView menuSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionHotestType:
        {
            cell = [self tableView:tableView hotSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionVisitRecommendType:
        {

            cell = [self tableView:tableView travelRecommendSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionVipRecommendType:
        {
            cell = [self tableView:tableView menuSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionSquareCenterType:
        {
            cell = [self tableView:tableView squareCenterSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionVisitProductType:
        {
            cell = [self tableView:tableView hotSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        default:
            return nil;
            break;
    }
    
    return cell;
}



#pragma tableViewCell getter
-(UITableViewCell*)tableView:(UITableView *)tableView menuSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");

        }
        
        [cell setCycleScrollViewUrls:nil];
        
        return cell;
    }
    else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"LBBHomeMenuTableViewCell";
        LBBHomeMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBHomeMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBHomeMenuTableViewCell nil");

        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBBHomeAnnouncementTableViewCell";
        LBBHomeAnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSLog(@"LBBHomeAnnouncementTableViewCell initWithStyle");
            cell = [[LBBHomeAnnouncementTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBHomeAnnouncementTableViewCell nil");

        }
        NSArray* array = @[@"IMCCP",@"a iOS developer",@"GitHub:https://github.com/IMCCP"];
        [cell setScrollTextArray:array];
        
        return cell;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView hotSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");

        }
        
        [cell setCycleScrollViewUrls:nil];
        
        return cell;
    }
    else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"LBBHomeHotestTableViewCell";
        LBBHomeHotestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBHomeHotestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            NSLog(@"LBBHomeHotestTableViewCell nil");

        }
        
        [cell setreload];
        return cell;
    }
    else{
        return nil;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView travelRecommendSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBBHomeTravelRecommendTableViewCell";
    LBBHomeTravelRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBBHomeTravelRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBBHomeTravelRecommendTableViewCell nil");

    }
    
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(@"poohtest")];
    [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg"] placeholderImage:IMAGE(@"poohtest")];

    return cell;
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView squareCenterSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBBHomeSquareCenterTableViewCell";
    LBBHomeSquareCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSLog(@"LBBHomeSquareCenterTableViewCell nil");
        cell = [[LBBHomeSquareCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    [cell.item2.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/h%3D200/sign=5c00db24cd95d143c576e32343f18296/03087bf40ad162d9ec74553b14dfa9ec8a13cd7a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    [cell.item2.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    [cell.item1.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/4b90f603738da97739bab10cb551f8198618e37b.jpg"] placeholderImage:IMAGE(@"poohtest")];
    [cell.item1.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/a9d3fd1f4134970a9edd270890cad1c8a7865d6e.jpg"] placeholderImage:IMAGE(@"poohtest")];

    return cell;
}

@end
