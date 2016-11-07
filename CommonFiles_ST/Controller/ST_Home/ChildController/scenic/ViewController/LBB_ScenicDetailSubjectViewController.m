//
//  LBB_ScenicDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailSubjectViewController.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBB_ScenicTextTableViewCell.h"
#import "LBB_ScenicDetailSubjectLableCell.h"
#import "LBB_ScenicDetailSubjectContentCell.h"

#import "LBB_ScenicDetailVipFavoriteCell.h"
#import "LBB_ScenicDetailCommentsCell.h"
#import "LBB_ScenicDetailTravelRecommendCell.h"


typedef NS_ENUM(NSInteger, LBBScenicDetailSubSectionType) {
    LBBScenicDetailSectionHeaderType = 0,//header部分
    LBBScenicDetailSectionSubjectType,//专题项
    LBBScenicDetailSectionSubjectFavoriteType,//专题收藏
    LBBScenicDetailSectionSubjectRecommendType,//专题推荐
    
    LBBScenicDetailSectionTotal,//总数
    
};


@interface LBB_ScenicDetailSubjectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* sectionArray;

@end

@implementation LBB_ScenicDetailSubjectViewController

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
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    UIButton *share = [[UIButton alloc] init];
    [share setBackgroundImage:IMAGE(@"景点详情_分享") forState:UIControlStateNormal];
    share.frame = CGRectMake(0, 0, 27, 27);
    [share bk_addEventHandler:^(id sender){
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    UIButton *favorite = [[UIButton alloc] init];
    [favorite setBackgroundImage:IMAGE(@"景点详情_收藏") forState:UIControlStateNormal];
    favorite.frame = CGRectMake(0, 0, 27, 27);
    [favorite bk_addEventHandler:^(id sender){
        
    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:favorite];
    
    self.navigationItem.rightBarButtonItems = @[searchItem,favoriteItem];
}

/*
 * setup UI
 */

-(void)buildControls{
    
    WS(ws);
    
    
    self.sectionArray = @[
                          @"",
                          @"",
                          @"",
                          @"景点专题_专题推荐",

                          ];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerTableViewCell];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
    
}


-(void)registerTableViewCell{
    //header part
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    [self.tableView registerClass:[LBB_ScenicTextTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicTextTableViewCell"];
    [self.tableView registerClass:[LBB_ScenicDetailSubjectLableCell class] forCellReuseIdentifier:@"LBB_ScenicDetailSubjectLableCell"];

    //专题详情
    [self.tableView registerClass:[LBB_ScenicDetailSubjectContentCell class] forCellReuseIdentifier:@"LBB_ScenicDetailSubjectContentCell"];
    
    //专题收藏
    [self.tableView registerClass:[LBB_ScenicDetailVipFavoriteCell class] forCellReuseIdentifier:@"LBB_ScenicDetailVipFavoriteCell"];
    [self.tableView registerClass:[LBB_ScenicDetailCommentsCell class] forCellReuseIdentifier:@"LBB_ScenicDetailCommentsCell"];
    //周边推荐
    [self.tableView registerClass:[LBB_ScenicDetailTravelRecommendCell class] forCellReuseIdentifier:@"LBB_ScenicDetailTravelRecommendCell"];
    
}

#pragma tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == LBBScenicDetailSectionSubjectRecommendType) {
        return AutoSize(40);
    }
    return 0.001;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != LBBScenicDetailSectionSubjectRecommendType) {
        return [UIView new];
    }
    
    UIView* v = [UIView new];
    [v setBackgroundColor:[UIColor getRandomColor]];
    CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
    [v setFrame:CGRectMake(0, 0, DeviceWidth, height)];
    [v setBackgroundColor:[UIColor whiteColor]];
    UIImageView* img = [UIImageView new];
    [img setImage:IMAGE([self.sectionArray objectAtIndex:section])];
    [img setContentMode:UIViewContentModeCenter];
    [v addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.height.width.equalTo(v);
        // make.width.equalTo(@184);
    }];
    return v;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return LBBScenicDetailSectionTotal;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case LBBScenicDetailSectionHeaderType://header部分
            return 4;
            break;
        case LBBScenicDetailSectionSubjectType://专题项
            return 3;
            break;
        case LBBScenicDetailSectionSubjectFavoriteType:///专题收藏
            return 2;
            break;
        case LBBScenicDetailSectionSubjectRecommendType://专题推荐
            return 5;
            break;
        default:
            break;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case LBBScenicDetailSectionHeaderType://header部分
            return [self tableView:tableView heightForHeaderSectionRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSubjectType://专题项
            return [self tableView:tableView heightForSubjectsRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSubjectFavoriteType://专题收藏
            return [self tableView:tableView heightForSubjectFavoriteRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSubjectRecommendType://专题推荐
            return [self tableView:tableView heightForTravelRecommendRowAtIndexPath:indexPath];
            break;
        default:
            return [self tableView:tableView heightForHeaderSectionRowAtIndexPath:indexPath];
            break;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case LBBScenicDetailSectionHeaderType://header部分
            return [self tableView:tableView cellForHeaderSectionRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSubjectType://专题项
            return [self tableView:tableView cellForSubjectsRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSubjectFavoriteType://专题收藏
            return [self tableView:tableView cellForSubjectFavoriteRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSubjectRecommendType://专题推荐
            return [self tableView:tableView cellForTravelRecommendRowAtIndexPath:indexPath];
            break;
        default:
            return [self tableView:tableView cellForHeaderSectionRowAtIndexPath:indexPath];
            break;
    }
}


/*
 *  对每个section的cell进行分开封装
 */
#pragma header 部分的cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {//ad
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
        }
        // [cell setCycleScrollViewHeight:AutoSize(386/2)];
        [cell setCycleScrollViewUrls:nil];
        return cell;
        
    }
    else if(indexPath.row == 1 || indexPath.row == 2){//msg
        
        static NSString *cellIdentifier = @"LBB_ScenicDetailSubjectLableCell";
        LBB_ScenicDetailSubjectLableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailSubjectLableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailSubjectLableCell nil");
        }
        return cell;
    }
    else{//address
        static NSString *cellIdentifier = @"LBB_ScenicTextTableViewCell";
        LBB_ScenicTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicTextTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicTextTableViewCell nil");
        }
        [cell setLineInset:16 andHeight:0.6];
        [cell.sepLineView setBackgroundColor:ColorLightGray];
        return cell;
        
    }
}
#pragma 专题项
-(UITableViewCell*)tableView:(UITableView *)tableView cellForSubjectsRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_ScenicDetailSubjectContentCell";
    LBB_ScenicDetailSubjectContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicDetailSubjectContentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicDetailSubjectContentCell nil");
    }
    [cell setModel:nil];
    return cell;
    
}

#pragma 达人收藏
-(UITableViewCell*)tableView:(UITableView *)tableView cellForSubjectFavoriteRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        static NSString *cellIdentifier = @"LBB_ScenicDetailVipFavoriteCell";
        LBB_ScenicDetailVipFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailVipFavoriteCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailVipFavoriteCell nil");
        }
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_ScenicDetailCommentsCell";
        LBB_ScenicDetailCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailCommentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailCommentsCell nil");
        }
        return cell;
    }
    
}

#pragma 周边推荐
-(UITableViewCell*)tableView:(UITableView *)tableView cellForTravelRecommendRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_ScenicDetailTravelRecommendCell";
    LBB_ScenicDetailTravelRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicDetailTravelRecommendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicDetailTravelRecommendCell nil");
    }
    [cell setModel:nil];
    cell.priceLable.hidden = YES;
    [cell.styleButton setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
    cell.styleButton.layer.borderColor = ColorBtnYellow.CGColor;
    return cell;
    
}
/*
 *  对每个section的cell heigt进行分开封装
 */
#pragma header 部分
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
            [cell setCycleScrollViewHeight:AutoSize(386/2)];
            [cell setCycleScrollViewUrls:nil];
        }];
    }
    else if (indexPath.row == 1 || indexPath.row == 2){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailSubjectLableCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailSubjectLableCell* cell){
            
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicTextTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicTextTableViewCell* cell){
        }];
    }
}

#pragma 专题项
-(CGFloat)tableView:(UITableView *)tableView heightForSubjectsRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailSubjectContentCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailSubjectContentCell* cell){
        [cell setModel:nil];
    }];
    
}


#pragma 达人收藏
-(CGFloat)tableView:(UITableView *)tableView heightForSubjectFavoriteRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailVipFavoriteCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailVipFavoriteCell* cell){
            
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailCommentsCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailCommentsCell* cell){
            
        }];
    }
}
#pragma 周边推荐
-(CGFloat)tableView:(UITableView *)tableView heightForTravelRecommendRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailTravelRecommendCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailTravelRecommendCell* cell){
        [cell setModel:nil];
        cell.priceLable.hidden = YES;
    }];
}
@end
