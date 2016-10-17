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

#import "LBBPoohCycleScrollCell.h"
#import "LBBPoohBaseTableSectionHeaderView.h"
#import "LBBHomeMenuTableViewCell.h"
#import "LBBHomeAnnouncementTableViewCell.h"

//static const NSInteger kSearchButtonMarginRight = -10;
//static const NSInteger kButtonFontSize = 15;
//static const NSInteger kButtonWidth = 45;

@interface ST_HomeViewController ()<UISearchBarDelegate>

@property (nonatomic, retain) UISearchBar *searchBar;


@end

@implementation ST_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setupNavigationUI];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:NO animated:YES];

}

-(BOOL)prefersStatusBarHidden{
    return YES;
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
    nearButton.imageView.image = [UIImage imageNamed:@"poohtest"];
    [self.baseNavigationBarView addSubview:nearButton];
    [nearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.baseNavigationBarView).offset(10);
        make.width.equalTo(@(IAppNavigationBarHeight+IAppStatusBarHeight - 2*interval));
        make.centerY.equalTo(ws.baseNavigationBarView);
        make.top.equalTo(ws.baseNavigationBarView).offset(interval);
        make.bottom.equalTo(ws.baseNavigationBarView).offset(-interval);
        
    }];
    
    [nearButton bk_whenTapped:^{
        
        NSLog(@"nearButton touch");
        
    }];
    
    //near button
    LBBPoohVerticalButton *signButton = [[LBBPoohVerticalButton alloc] init];
    signButton.titleLabel.font = Font1;
    signButton.titleLabel.text = @"签到";
    signButton.imageView.image = [UIImage imageNamed:@"poohtest"];
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
    [bar setBackgroundImage:[UIImage new]];
    [self.baseNavigationBarView addSubview:bar];
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(ws.baseNavigationBarView);
        make.left.equalTo(nearButton.mas_right).offset(2*interval);
        make.right.equalTo(signButton.mas_left).offset(-2*interval);
    }];
    bar.delegate = self;
    bar.placeholder = @"请输入 景点 美食 民宿";
    [bar setContentMode:UIViewContentModeLeft];
    self.searchBar = bar;
    

    
}

/*
 *  setup UI
 */
-(void)setupUI{
    WS(ws);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.left.right.equalTo(ws.baseContentView);
        make.top.equalTo(ws.baseContentView.mas_top);
        make.bottom.equalTo(ws.baseContentView).offset(-IAppTabBarHeight);
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView* v = [UIView new];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, UISCREEN_WIDTH, height)];
    
    LBBPoohBaseTableSectionHeaderView* header = [[LBBPoohBaseTableSectionHeaderView alloc]init];
    [v addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.width.height.equalTo(v);
    }];
    
    [header.markButton bk_addEventHandler:^(id sender){
    
        NSLog(@"%@ section header button click:%ld",[self class],section);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    return v;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LBBPoohBaseTableViewCell* cell = (LBBPoohBaseTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return [cell getCellHeight];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self tableView:tableView cycleCellForRowAtIndexPath:indexPath];
    
    return cell;
}



#pragma tableViewCell getter
-(UITableViewCell*)tableView:(UITableView *)tableView cycleCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
            cell = [[LBBHomeAnnouncementTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        NSArray* array = @[@"IMCCP",@"a iOS developer",@"GitHub:https://github.com/IMCCP"];
        [cell setScrollTextArray:array];
        
        return cell;
    }
    
}

@end
