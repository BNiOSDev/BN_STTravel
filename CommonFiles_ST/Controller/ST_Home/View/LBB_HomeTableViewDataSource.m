//
//  LBB_HomeTableViewDataSource.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/5.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeTableViewDataSource.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBBHomeMenuTableViewCell.h"
#import "LBBHomeAnnouncementTableViewCell.h"
#import "LBBHomeHotestTableViewCell.h"
#import "LBBHomeTravelRecommendTableViewCell.h"
#import "LBBHomeSquareCenterTableViewCell.h"
#import "LBB_ScenicDetailSubjectViewController.h"

@interface LBB_HomeTableViewDataSource()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LBB_HomeTableViewDataSource




- (id)initWithTableView:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
        [self.tableView registerClass:[LBBHomeMenuTableViewCell class] forCellReuseIdentifier:@"LBBHomeMenuTableViewCell"];
        [self.tableView registerClass:[LBBHomeAnnouncementTableViewCell class] forCellReuseIdentifier:@"LBBHomeAnnouncementTableViewCell"];
        [self.tableView registerClass:[LBBHomeHotestTableViewCell class] forCellReuseIdentifier:@"LBBHomeHotestTableViewCell"];
        [self.tableView registerClass:[LBBHomeTravelRecommendTableViewCell class] forCellReuseIdentifier:@"LBBHomeTravelRecommendTableViewCell"];
        [self.tableView registerClass:[LBBHomeSquareCenterTableViewCell class] forCellReuseIdentifier:@"LBBHomeSquareCenterTableViewCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
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
            return [self tableView:tableView heightForMenuSectionRowAtIndexPath:indexPath];
            
        }
            break;
        case LBBHomeSectionHotestType:
        {
            return [self tableView:tableView heightForHotSectionRowAtIndexPath:indexPath];
        }
            break;
        case LBBHomeSectionTravelRecommendType:
        {

            return [self tableView:tableView heightForTravelRecommendSectionRowAtIndexPath:indexPath];

        }
            break;
        case LBBHomeSectionVipRecommendType:
        {

            return [self tableView:tableView heightForVipRecommendSectionRowAtIndexPath:indexPath];

        }
            break;
        case LBBHomeSectionSquareCenterType:
        {
            return [self tableView:tableView heightForSquareCenterSectionRowAtIndexPath:indexPath];

        }
            break;
        case LBBHomeSectionTravelProductType:
        {
            
            return [self tableView:tableView heightForTravelProductSectionRowAtIndexPath:indexPath];

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


/****************************************************************
 *
 *   获取页面的cell和 cell的高度
 *
 ****************************************************************/

#pragma tableViewCell getter

-(UITableViewCell*)tableView:(UITableView *)tableView menuSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
            
        }
        [cell setCycleScrollViewHeight:AutoSize(370/2)];
        

        [cell setAdModelArray:self.viewModel.advertisementArray];//设置model。首页广告的数据
        
       /* [cell setCycleScrollViewUrls:urls];
        [cell setEnableBlock:YES];
        cell.click = ^(NSNumber* index){
            
            //  NSInteger num = [index integerValue];
            LBB_ScenicDetailSubjectViewController* dest = [[LBB_ScenicDetailSubjectViewController alloc] init];
            [ws.parentViewController.navigationController pushViewController:dest animated:YES];
            
        };*/
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


-(CGFloat)tableView:(UITableView *)tableView heightForMenuSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    

        if (indexPath.row == 0) {
            return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
                
                [cell setCycleScrollViewHeight:AutoSize(370/2)];
            }];
        }
        else if (indexPath.row == 1){
            
            return [tableView fd_heightForCellWithIdentifier:@"LBBHomeMenuTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeMenuTableViewCell* cell){
                
            }];
        }
        else{
            return [tableView fd_heightForCellWithIdentifier:@"LBBHomeAnnouncementTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeAnnouncementTableViewCell* cell){
                
            }];
        }
}





#pragma  //热门推荐
-(UITableViewCell*)tableView:(UITableView *)tableView hotSectionCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
            
        }
        [cell setCycleScrollViewHeight:AutoSize(380/2)];
        [cell setCycleScrollViewUrls:nil];
        [cell setEnableBlock:YES];
        cell.click = ^(NSNumber* index){
            
            //  NSInteger num = [index integerValue];
            LBB_ScenicDetailSubjectViewController* dest = [[LBB_ScenicDetailSubjectViewController alloc] init];
            [ws.parentViewController.navigationController pushViewController:dest animated:YES];
            
        };
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
        return cell;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHotSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
            
            [cell setCycleScrollViewHeight:AutoSize(380/2)];
        }];
    }
    else{
     //   return [LBBHomeHotestTableViewCell getCellHeight];
        
          return [tableView fd_heightForCellWithIdentifier:@"LBBHomeHotestTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeHotestTableViewCell* cell){
              [cell setPagerViewHidden:YES];
         }];
    }
}

#pragma  //游记推荐
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

-(CGFloat)tableView:(UITableView *)tableView heightForTravelRecommendSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return [tableView fd_heightForCellWithIdentifier:@"LBBHomeTravelRecommendTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeTravelRecommendTableViewCell* cell){
            
        }];
}


#pragma  //达人推荐
-(UITableViewCell*)tableView:(UITableView *)tableView vipRecommendCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBBHomeHotestTableViewCell";
    LBBHomeHotestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBBHomeHotestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSLog(@"LBBHomeHotestTableViewCell nil");
    }
    [cell setPagerViewHidden:NO];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForVipRecommendSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBBHomeHotestTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeHotestTableViewCell* cell){
        [cell setPagerViewHidden:NO];
     
     }];
}

#pragma    //广场中心
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
-(CGFloat)tableView:(UITableView *)tableView heightForSquareCenterSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBBHomeSquareCenterTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeSquareCenterTableViewCell* cell){
        
    }];
}


#pragma    //伴手礼推荐
-(UITableViewCell*)tableView:(UITableView *)tableView travelProductCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"LBBPoohCycleScrollCell";
        LBBPoohCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBBPoohCycleScrollCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            NSLog(@"LBBPoohCycleScrollCell nil");
            
        }
        [cell setCycleScrollViewHeight:AutoSize(390/2)];
        [cell setCycleScrollViewUrls:nil];
        [cell setEnableBlock:YES];
        cell.click = ^(NSNumber* index){
            
            //  NSInteger num = [index integerValue];
            LBB_ScenicDetailSubjectViewController* dest = [[LBB_ScenicDetailSubjectViewController alloc] init];
            [ws.parentViewController.navigationController pushViewController:dest animated:YES];
            
        };
        
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
        cell.isMarket = YES;
        return cell;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForTravelProductSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
            
            [cell setCycleScrollViewHeight:AutoSize(390/2)];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBBHomeHotestTableViewCell" cacheByIndexPath:indexPath configuration:^(LBBHomeHotestTableViewCell* cell){
            [cell setPagerViewHidden:NO];
        }];
    }
}




#pragma 选择动作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
