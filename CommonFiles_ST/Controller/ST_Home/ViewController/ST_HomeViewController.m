//
//  ST_HomeViewController.m
//  ST_Travel
//
//  Created by newman on 16/10/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ST_HomeViewController.h"
#import "PoohCommon.h"

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
    LBBHomeSectionTravelRecommendType,//游记推荐
    LBBHomeSectionVipRecommendType,//达人推荐
    LBBHomeSectionSquareCenterType,//广场中心
    LBBHomeSectionTravelProductType,//旅游产品
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
    back.titleLabel.font = Font5;
    back.titleLabel.text = @"附近";
    back.frame = CGRectMake(0, 0, 45, 45);
    [back.imageView setImage:IMAGE(@"ST_Home_Nearby")];
    [back bk_whenTapped:^{
        
        NSLog(@"back touch");
        LBBNearbyMainViewController* v = [[LBBNearbyMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
    }];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    LBBPoohVerticalButton *sign = [[LBBPoohVerticalButton alloc] init];
    sign.titleLabel.font = Font5;
    sign.titleLabel.text = @"签到";
    sign.frame = CGRectMake(0, 0, 45, 45);
    [sign.imageView setImage:IMAGE(@"ST_Home_Signin")];
    [sign bk_whenTapped:^{
        
        NSLog(@"signButton touch");
        LBBSigninMainViewController* v = [[LBBSigninMainViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
        
    }];
    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:sign];
    self.navigationItem.rightBarButtonItem = signItem;
    
    
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
                          @"",
                          @"热门推荐",
                          @"游记推荐",
                          @"达人推荐",
                          @"广场中心",
                          @"伴手礼推荐",
                          ];
    
    WS(ws);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBBHomeMenuTableViewCell class] forCellReuseIdentifier:@"LBBHomeMenuTableViewCell"];
    [self.tableView registerClass:[LBBHomeAnnouncementTableViewCell class] forCellReuseIdentifier:@"LBBHomeAnnouncementTableViewCell"];
    [self.tableView registerClass:[LBBHomeHotestTableViewCell class] forCellReuseIdentifier:@"LBBHomeHotestTableViewCell"];
    [self.tableView registerClass:[LBBHomeTravelRecommendTableViewCell class] forCellReuseIdentifier:@"LBBHomeTravelRecommendTableViewCell"];
    [self.tableView registerClass:[LBBHomeSquareCenterTableViewCell class] forCellReuseIdentifier:@"LBBHomeSquareCenterTableViewCell"];
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

}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self.searchBar becomeFirstResponder];
    return YES;
}


#pragma tableView Delegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* v = [UIView new];
    return v;
};

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == LBBHomeSectionMenuType) {
        return 0.001;
    }
    return DeviceWidth* 86/640;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == LBBHomeSectionMenuType) {
        return [UIView new];
    }
    UIView* v = [UIView new];
    [v setBackgroundColor:[UIColor whiteColor]];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    
    
    UIImageView* img = [UIImageView new];
    [img setImage:IMAGE([self.sectionArray objectAtIndex:section])];
    [img setContentMode:UIViewContentModeCenter];
    [v addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.height.width.equalTo(v);
       // make.width.equalTo(@184);
    }];
    
    UIButton* btn = [UIButton new];
    [btn setBackgroundImage:IMAGE(@"ST_Home_Arrow") forState:UIControlStateNormal];
    [btn setContentMode:UIViewContentModeCenter];
    [v addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.width.mas_equalTo(15);
        make.height.equalTo(@22);
        make.centerY.equalTo(v);
        make.right.equalTo(v).offset(-16);
    }];
    
    [btn bk_addEventHandler:^(id sender){
    
        NSLog(@"touch section header");
        
    } forControlEvents:UIControlEventTouchUpInside];

    
    if ((section == LBBHomeSectionHotestType)
        ||(section == LBBHomeSectionVipRecommendType)) {
        btn.hidden = YES;
    }
    
    
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
        case LBBHomeSectionTravelRecommendType:
            {
                return 2;
            }
            break;
        case LBBHomeSectionVipRecommendType:
            {
                return 1;
            }
            break;
        case LBBHomeSectionSquareCenterType:
            {
                return 2;
            }
            break;
        case LBBHomeSectionTravelProductType:
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
    
    CGFloat height = 0;
    switch (indexPath.section) {
        case LBBHomeSectionMenuType:
        {
            if (indexPath.row == 0) {

                height = [LBBPoohCycleScrollCell getCellHeight];
            }
            else if (indexPath.row == 1){

                height = [LBBHomeMenuTableViewCell getCellHeight];
            }
            else{
                height = [LBBHomeAnnouncementTableViewCell getCellHeight];
            }
                
        }
            break;
        case LBBHomeSectionHotestType:
        {
            if (indexPath.row == 0) {
                
                height = [LBBPoohCycleScrollCell getCellHeight];
            }
            else{
                height = [LBBHomeHotestTableViewCell getCellHeight];
                
              /*  return [tableView fd_heightForCellWithIdentifier:@"LBBHomeHotestTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeHotestTableViewCell* cell){
                    [cell setPagerViewHidden:YES];
                }];*/
            }
            
        }
            break;
        case LBBHomeSectionTravelRecommendType:
        {
            
            return [tableView fd_heightForCellWithIdentifier:@"LBBHomeTravelRecommendTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeTravelRecommendTableViewCell* cell){
            
            }];
           // height = [LBBHomeTravelRecommendTableViewCell getCellHeight];
        }
            break;
        case LBBHomeSectionVipRecommendType:
        {
            height = [LBBHomeHotestTableViewCell getCellHeight];
            
         /*   return [tableView fd_heightForCellWithIdentifier:@"LBBHomeHotestTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeHotestTableViewCell* cell){
                [cell setPagerViewHidden:YES];

            }];*/
        }
            break;
        case LBBHomeSectionSquareCenterType:
        {
            height = [LBBHomeSquareCenterTableViewCell getCellHeight];
        }
            break;
        case LBBHomeSectionTravelProductType:
        {
            if (indexPath.row == 0) {
                
                height = [LBBPoohCycleScrollCell getCellHeight];
            }
            else{
               height = [LBBHomeHotestTableViewCell getCellHeight2];
                
            /*    return [tableView fd_heightForCellWithIdentifier:@"LBBHomeHotestTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeHotestTableViewCell* cell){
                }];*/

            }
        }
            break;
        default:
            {
            
            }
        break;
    }
    
    return height;
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
        case LBBHomeSectionTravelRecommendType:
        {

            cell = [self tableView:tableView travelRecommendSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionVipRecommendType:
        {
            cell = [self tableView:tableView vipRecommendCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionSquareCenterType:
        {
            cell = [self tableView:tableView squareCenterSectionCellForRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionTravelProductType:
        {
            cell = [self tableView:tableView travelProductCellForRowAtIndexPath:indexPath];
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

    
    //热门推荐
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
        [cell setPagerViewHidden:YES];
        [cell setreload];
        return cell;
    }
    else{
        return nil;
    }
}

    //游记推荐
-(UITableViewCell*)tableView:(UITableView *)tableView travelRecommendSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBBHomeTravelRecommendTableViewCell";
    LBBHomeTravelRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBBHomeTravelRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        NSLog(@"LBBHomeTravelRecommendTableViewCell nil");

    }
   
    [cell setModel:nil];

    return cell;
   
}
    //达人推荐
-(UITableViewCell*)tableView:(UITableView *)tableView vipRecommendCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBBHomeHotestTableViewCell";
    LBBHomeHotestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBBHomeHotestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSLog(@"LBBHomeHotestTableViewCell nil");
    }
    [cell setPagerViewHidden:NO];
    [cell setreload];
    return cell;

}
    //广场中心
-(UITableViewCell*)tableView:(UITableView *)tableView squareCenterSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBBHomeSquareCenterTableViewCell";
    LBBHomeSquareCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSLog(@"LBBHomeSquareCenterTableViewCell nil");
        cell = [[LBBHomeSquareCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }

    [cell setModel:nil];

    return cell;
}

    //伴手礼推荐
-(UITableViewCell*)tableView:(UITableView *)tableView travelProductCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        [cell setPagerViewHidden:NO];
        [cell setreload];
        return cell;
    }
    else{
        return nil;
    }
}


@end
