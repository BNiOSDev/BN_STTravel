//
//  LBB_ScenicMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FoodsMainViewController.h"
#import "LBB_ScenicMainTableViewCell.h"
#import "LBB_ScenicSearchViewController.h"
#import "LBB_ScenicDetailViewController.h"
#import "LBB_ScenicDetailSubjectViewController.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBB_FoodsMainMenuCell.h"
#import "LBB_FilterTableViewCell.h"
@interface LBB_FoodsMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) UISearchBar *searchBar;


@end

@implementation LBB_FoodsMainViewController

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
    WS(ws);
    self.title = @"美食";
    UIButton *search = [[UIButton alloc] init];
    search.titleLabel.font = Font14;
    // [search setTitle:@"搜索" forState:UIControlStateNormal];
    // [search setImage:IMAGE(@"景区列表_搜索") forState:UIControlStateNormal];
    [search setBackgroundImage:IMAGE(@"景区列表_搜索") forState:UIControlStateNormal];
    
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    search.frame = CGRectMake(0, 0, 25, 25);
    [search bk_addEventHandler:^(id sender){
        
        LBB_ScenicSearchViewController* dest = [[LBB_ScenicSearchViewController alloc]init];
        dest.placeHolderString = @"输入关键字搜索美食";
        dest.click = ^(LBB_ScenicSearchViewController* v , NSIndexPath* indexPath){
            
            NSLog(@"选择搜索的数据:%ld",indexPath.row);
            [v.navigationController popViewControllerAnimated:YES];
        };
        [ws.navigationController pushViewController:dest animated:YES];
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    self.navigationItem.rightBarButtonItem = searchItem;
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[LBB_ScenicMainTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicMainTableViewCell"];
    [self.tableView registerClass:[LBB_FoodsMainMenuCell class] forCellReuseIdentifier:@"LBB_FoodsMainMenuCell"];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];

    
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
    
    
}


#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return AutoSize(TopSegmmentControlHeight);
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return [UIView new];
    }

    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    NSArray* segmentArray = @[@"附近",@"类别",@"智能排序",@"标签"];
    
    BN_FilterMenu* segmentedControl = [[BN_FilterMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    [segmentedControl setBackgroundColor:ColorWhite];
    
    [segmentedControl setTextColor:ColorGray];
    [segmentedControl setSelectedTextColor:ColorBtnYellow];
    segmentedControl.layer.borderWidth = 1;
    segmentedControl.layer.borderColor = ColorLine.CGColor;
    segmentedControl.menuArray = segmentArray;
    
    //返回section数组
    [segmentedControl getMenuDataSectionArrayInBlock:^NSArray*(NSInteger index, NSString *title){
        if (index == 2) {
            return @[
                     @[@"热门推荐",@"景区标签_热门"],
                     @[@"标签",@"景区标签_标签"],
                     @[@"价格",@"景区标签_价格"],
                     ];
        }
        return @[@""];
    }];
    [segmentedControl getSectionInBlock:^UIView*(NSInteger index, NSInteger section, id data){
        
        if (index == 2) {
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
        }
        return [UIView new];
    }];
    [segmentedControl heightForSectionInBlock:^CGFloat(NSInteger index, NSInteger section,id data){
        if (index == 2) {
            return AutoSize(56/2);
        }
        return 0;
    }];
    //返回数据数组
    [segmentedControl getMenuDataRowArrayInBlock:^NSArray*(NSInteger index, NSString *title, NSInteger section){
        
        if (index == 0) {
            return @[@[@"全部美食"],@[@"厦门特色小吃"],@[@"台湾特色小吃"],@[@"福建特色小吃"],@[@"海鲜"],@[@"咖啡"]];
        }
        else if (index == 1){
            return @[@[@"全部美食"],@[@"厦门特色小吃"],@[@"台湾特色小吃"],@[@"福建特色小吃"],@[@"海鲜"],@[@"咖啡"]];
        }
        else{
            if (section == 0) {
                return @[
                         @[@"不限",@"鼓浪屿",@"南普陀",@"演武大桥",@"厦门大学",@"厦大白城"]
                         ];
            }
            else if (section == 1){
                return @[
                         @[@"不限",@"好玩",@"浪漫",@"海边沙滩",@"环境好",@"美丽",@"不限",@"好玩",@"浪漫",@"海边沙滩"]
                         ];
            }
            else{
                return @[
                         @[@"不限",@"100以下",@"100-200",@"200-300",@"300-500",@"500以上"]
                         ];
            }
        }
    }];
    //返回每行的高度
    [segmentedControl heightForRowInBlock:^CGFloat(NSInteger index, NSIndexPath *indexPath, id data) {
        if (index < 2) {
            return [LBB_FilterTableViewCell getCellHeight:data];
        }
        return AutoSize(40);
    }];
    //返回cell
    [segmentedControl getCellInBlock:^UITableViewCell*(NSInteger index, NSIndexPath *indexPath, id data) {
        NSLog(@"getCellInBlock data:%@",data);
        
        if (index < 2) {
            static NSString *cellIdentifier = @"UITableViewCell";
            UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            NSString* title = [data objectAtIndex:0];

            [cell.textLabel setText:title];
            [cell.textLabel setFont:Font15];
            [cell.textLabel setTextColor:ColorGray];
            cell.tintColor = ColorBtnYellow;
            
            if (indexPath.row == 1) {
                [cell.textLabel setTextColor:ColorBtnYellow];
                UIImageView* accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize(13), AutoSize(11))];
                [accessoryView setImage:IMAGE(@"景区排序_打钩")];
                cell.accessoryView = accessoryView;
            }
            
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"LBB_FilterTableViewCell";
            LBB_FilterTableViewCell* cell = [[LBB_FilterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            cell.bottomMargin = AutoSize(15);
            cell.selectIndex = 0;
            [cell configContentView:data];
            
            cell.click = ^(NSNumber* num){
                
                [segmentedControl reloadData];
                
            };
            return cell;
        }
        
    }];
    //cell的选中动作
    [segmentedControl didDeselectRowAtIndexPathBlock:^(NSInteger index, NSIndexPath *indexPath, id data) {
        NSLog(@"index:%ld,选择 %@",index,data);
        if (index != 2) {
            [segmentedControl closeMenu];
        }
    }];
    
    //返回bottomView
    [segmentedControl getMenuBottomViewInBlock:^UIView*(NSInteger index, NSString *title){
        
        if (index < 2) {
            return nil;
        }
        
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
    return segmentedControl;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell *cell) {
                
                [cell setCycleScrollViewHeight:AutoSize(470/2)];
                [cell setCycleScrollViewUrls:nil];
            }];
        }
        else{
            return [tableView fd_heightForCellWithIdentifier:@"LBB_FoodsMainMenuCell" cacheByIndexPath:indexPath configuration:^(LBB_FoodsMainMenuCell *cell) {
                
            }];
        }
        
    }
    

    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicMainTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicMainTableViewCell *cell) {
        
        [cell showTopSepLine:YES];
        [cell setModel:nil];
    }];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
            LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                
                NSLog(@"LBBPoohCycleScrollCell nil");
            }
            [cell setCycleScrollViewHeight:AutoSize(470/2)];
            [cell setCycleScrollViewUrls:nil];
            [cell setEnableBlock:YES];
            cell.click = ^(NSNumber* index){
                
                //  NSInteger num = [index integerValue];
                LBB_ScenicDetailSubjectViewController* dest = [[LBB_ScenicDetailSubjectViewController alloc] init];
                [ws.navigationController pushViewController:dest animated:YES];
                
            };
            return cell;
        }
        else{
            static NSString *cellIdentifier = @"LBB_FoodsMainMenuCell";
            LBB_FoodsMainMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[LBB_FoodsMainMenuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                
                NSLog(@"LBB_FoodsMainMenuCell nil");
            }

            return cell;
        }
        
    }
    
    
    static NSString *cellIdentifier = @"LBB_ScenicMainTableViewCell";
    LBB_ScenicMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicMainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicMainTableViewCell nil");
    }
    [cell showTopSepLine:YES];
    [cell setModel:nil];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  [self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
    dest.homeType = LBBPoohHomeTypeFoods;

    [self.navigationController pushViewController:dest animated:YES];
}

@end
