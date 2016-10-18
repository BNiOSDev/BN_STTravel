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


#import "LBBPoohCycleScrollCell.h"
#import "LBBPoohBaseTableSectionHeaderView.h"
#import "LBBHomeMenuTableViewCell.h"
#import "LBBHomeAnnouncementTableViewCell.h"
#import "LBBHomeHotestTableViewCell.h"


typedef NS_ENUM(NSInteger, LBBHomeSectionType) {
    LBBHomeSectionMenuType = 0,//入口
    LBBHomeSectionHotestType,//热门推荐
    LBBHomeSectionVisitRecommendType,//游记推荐
    LBBHomeSectionVipRecommendType,//达人推荐
    LBBHomeSectionSquareCenterType,//广场中心
    LBBHomeSectionVisitProductType,//旅游产品
};


@interface ST_HomeViewController ()<UISearchBarDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSArray* sectionArray;

@end

@implementation ST_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

  //  [self setupNavigationUI];
  //  [self setupUI];
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


/*
 *  setup navigation UI
 */
- (void)setupNavigationUI
{
    WS(ws);

    CGFloat interval = 8;
    
    //near button
    LBBPoohVerticalButton *nearButton = [[LBBPoohVerticalButton alloc] init];
    nearButton.titleLabel.font = Font1;
    nearButton.titleLabel.text = @"附近";
    nearButton.imageView.image = [UIImage imageNamed:@"PoohNearby"];
    [self.baseNavigationBarView addSubview:nearButton];
    [nearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.baseNavigationBarView).offset(10);
        make.width.equalTo(@45);
        make.centerY.equalTo(ws.baseNavigationBarView);
        make.top.equalTo(ws.baseNavigationBarView).offset(interval);
        make.bottom.equalTo(ws.baseNavigationBarView).offset(-interval);
        
    }];
    
    [nearButton bk_whenTapped:^{
        
        NSLog(@"nearButton touch");
        LBBNearbyMainViewController* v = [[LBBNearbyMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
        
    }];
  
    
    
    //near button
    LBBPoohVerticalButton *signButton = [[LBBPoohVerticalButton alloc] init];
    signButton.titleLabel.font = Font1;
    signButton.titleLabel.text = @"签到";
    signButton.imageView.image = [UIImage imageNamed:@"PoohSign"];
    [self.baseNavigationBarView addSubview:signButton];
    [signButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.baseNavigationBarView).offset(-10);
        
        make.centerY.width.height.equalTo(nearButton);
    }];
    [signButton bk_whenTapped:^{
        
        NSLog(@"signButton touch");
        
    }];
    
    //search bar

    UISearchBar *bar = [UISearchBar new];
   // bar.barStyle = UIBarStyleDefault;
  //  bar.translucent = YES;
   // bar.barTintColor = Global_mainBackgroundColor;
   // bar.tintColor = Global_tintColor;
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 0.8;
    view.layer.cornerRadius = 15;

   // bar.layer.borderColor = [UIColor blackColor].CGColor;
   // bar.layer.borderWidth = 0.8;
    //bar.layer.cornerRadius = 8;
   // bar.showsBookmrarkButton = YES;
  //  [bar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [bar setBackgroundImage:[UIImage new]];
    [self.baseNavigationBarView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(ws.baseNavigationBarView);
        make.left.equalTo(nearButton.mas_right).offset(interval);
        make.right.equalTo(signButton.mas_left).offset(-interval);
        make.height.equalTo(@30);
    }];
    bar.delegate = self;
    bar.placeholder = @"请输入 景点 美食 民宿";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
}

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
    WS(ws);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.equalTo(ws.baseContentView);
        make.top.equalTo(ws.baseContentView.mas_top);
        make.bottom.equalTo(ws.baseContentView).offset(-IAppTabBarHeight);
    }];
    
    self.sectionArray = @[
                          @[@"",@""],
                          @[@"热门推荐",@"poohtest"],
                          @[@"游记推荐",@"poohtest"],
                          @[@"达人推荐",@"poohtest"],
                          @[@"广场中心",@"poohtest"],
                          @[@"旅游产品",@"poohtest"],
                          
                          ];
    
    
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
    return 60;
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

            cell = [self tableView:tableView menuSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionVipRecommendType:
        {
            cell = [self tableView:tableView menuSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionSquareCenterType:
        {
            cell = [self tableView:tableView menuSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionVisitProductType:
        {
            cell = [self tableView:tableView menuSectionCellForRowAtIndexPath:indexPath];
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
        }
        
        [cell setCycleScrollViewUrls:nil];
        
        return cell;
    }
    else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"LBBHomeMenuTableViewCell";
        LBBHomeMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBHomeMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBBHomeAnnouncementTableViewCell";
        LBBHomeAnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSLog(@"LBBHomeAnnouncementTableViewCell initWithStyle");
            cell = [[LBBHomeAnnouncementTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
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
        }
        
        [cell setCycleScrollViewUrls:nil];
        
        return cell;
    }
    else if (indexPath.row == 1){
        static NSString *cellIdentifier = @"LBBHomeHotestTableViewCell";
        LBBHomeHotestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBHomeHotestTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        [cell setreload];
        return cell;
    }
    else{
        return nil;
    }
}


@end
