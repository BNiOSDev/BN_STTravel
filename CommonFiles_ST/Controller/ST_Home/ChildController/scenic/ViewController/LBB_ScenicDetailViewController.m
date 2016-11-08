//
//  LBB_ScenicDetailViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailViewController.h"
#import "LBB_ScenicDetailPriceMsgCell.h"
#import "LBB_ScenicDetailAddressCell.h"
#import "LBBPoohCycleScrollCell.h"
#import "LBB_ScenicTextTableViewCell.h"
#import "LBB_ScenicDetailVipMPaiCell.h"
#import "LBB_ScenicDetailEquipmentCell.h"
#import "LBB_ScenicDetailBookStatusCell.h"
#import "LBB_ScenicDetailVipFavoriteCell.h"
#import "LBB_ScenicDetailCommentsCell.h"
#import "LBB_ScenicDetailTravelRecommendCell.h"
#import "LBB_OrderWaitPayViewController.h"
#import "LBB_ScenicDetailOrderConfirmView.h"
#import "LBB_NewOrderViewController.h"


typedef NS_ENUM(NSInteger, LBBScenicDetailSectionType) {
    LBBScenicDetailSectionHeaderType = 0,//header部分
    LBBScenicDetailSectionVipMPaiType,//达人秒拍
    LBBScenicDetailSectionRecommendReasonType,//推荐理由
    LBBScenicDetailSectionSpotType,//景点详情
    LBBScenicDetailSectionEquipmentType,//景区设施
    LBBScenicDetailSectionWarmPromptType,//温馨提示
    LBBScenicDetailSectionTravelRecommendType,//周边推荐
    
    LBBScenicDetailSectionTotal,//总数

};


@interface LBB_ScenicDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* sectionArray;
@property(nonatomic, retain)LBB_ScenicDetailOrderConfirmView* popView;


@end

@implementation LBB_ScenicDetailViewController

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
    [share setImage:IMAGE(@"景点详情_分享") forState:UIControlStateNormal];
    share.frame = CGRectMake(0, 0, 45, 45);
    [share bk_addEventHandler:^(id sender){

    }forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    UIButton *favorite = [[UIButton alloc] init];
    [favorite setImage:IMAGE(@"景点详情_收藏") forState:UIControlStateNormal];
    favorite.frame = CGRectMake(0, 0, 45, 45);
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
                          @"景点详情_达人秒拍",
                          @"景点详情_推荐理由",
                          @"景点详情_景点详情",
                          @"景点详情_景区设施",
                          @"景点详情_温馨提示",
                          @"景点详情_周边推荐",
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
    
    
    if (self.homeType == LBBPoohHomeTypeScenic) {//景点页面才展示
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.top.centerX.equalTo(ws.view);
           // make.bottom.equalTo(ws.view);
        }];
        
        UIView* toolBar = [UIView new];
        toolBar.layer.borderColor = ColorBtnYellow.CGColor;
        toolBar.layer.borderWidth = 1;
        [self.view addSubview:toolBar];
        [toolBar mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.equalTo(ws.view);
            make.height.mas_equalTo(AutoSize(75/2));
            make.top.equalTo(ws.tableView.mas_bottom);
            make.left.equalTo(ws.view).offset(-1);
            make.right.equalTo(ws.view).offset(1);
        }];
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        [toolBar addSubview:b];
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(toolBar.mas_left).offset(1);
            make.top.bottom.equalTo(toolBar);
        }];
        [b setTitle:@"景区电话" forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:@"景点详情_电话底部"] forState:UIControlStateNormal];
        [b setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
        b.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
        b.titleLabel.font = Font15;
        //  b.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [toolBar addSubview:b1];
        [b1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(b.mas_right);
            make.right.equalTo(toolBar.mas_right).offset(-1);
            make.top.bottom.equalTo(toolBar);
            make.width.equalTo(b);
        }];
        [b1 setTitle:@"立即购买" forState:UIControlStateNormal];
        [b1 setBackgroundColor:ColorBtnYellow];
        [b1 setImage:[UIImage imageNamed:@"景点详情_箭头Right"] forState:UIControlStateNormal];
        [b1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
        b1.imageEdgeInsets = UIEdgeInsetsMake(0, 130, 0, 0);
        b1.titleLabel.font = Font15;
        [b1 bk_addEventHandler:^(id sender){
            
            
            if (!ws.popView) {
                ws.popView = [[LBB_ScenicDetailOrderConfirmView alloc]init];
            }
            [ws.popView showPopView];
            // [ws.view addSubview:ws.popView];
            [ws.popView.confirmButton bk_addEventHandler:^(id sender){
                NSLog(@"ws.popView.confirmButton touch");
                
                ws.popView.hidden = YES;
                [ws.popView resignKeyWindow];
                ws.popView = nil;
                LBB_NewOrderViewController* dest = [[LBB_NewOrderViewController alloc]init];
                //  dest.isIntegral = YES;
                [ws.navigationController pushViewController:dest animated:YES];
            } forControlEvents:UIControlEventTouchUpInside];
            
            
            [ws.popView.closeButton bk_addEventHandler:^(id sender){
                NSLog(@"ws.popView.closeButton touch");
                
                ws.popView.hidden = YES;
                //  [ws.popView resignKeyWindow];
                ws.popView = nil;
            } forControlEvents:UIControlEventTouchUpInside];
            

            
        } forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)registerTableViewCell{
    //header part
    [self.tableView registerClass:[LBB_ScenicDetailPriceMsgCell class] forCellReuseIdentifier:@"LBB_ScenicDetailPriceMsgCell"];
    [self.tableView registerClass:[LBB_ScenicDetailAddressCell class] forCellReuseIdentifier:@"LBB_ScenicDetailAddressCell"];
    [self.tableView registerClass:[LBBPoohCycleScrollCell class] forCellReuseIdentifier:@"LBBPoohCycleScrollCell"];
    
    //推荐理由
    [self.tableView registerClass:[LBB_ScenicTextTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicTextTableViewCell"];

    //达人秒拍
    [self.tableView registerClass:[LBB_ScenicDetailVipMPaiCell class] forCellReuseIdentifier:@"LBB_ScenicDetailVipMPaiCell"];

    //景区设施
    [self.tableView registerClass:[LBB_ScenicDetailEquipmentCell class] forCellReuseIdentifier:@"LBB_ScenicDetailEquipmentCell"];

    //温馨提示
    [self.tableView registerClass:[LBB_ScenicDetailBookStatusCell class] forCellReuseIdentifier:@"LBB_ScenicDetailBookStatusCell"];
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
    if (section == LBBScenicDetailSectionHeaderType) {
        return 0.001;
    }
    if (section == LBBScenicDetailSectionTravelRecommendType) {
        return AutoSize(40)+ TopSegmmentControlHeight;
    }
    return AutoSize(40);
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == LBBScenicDetailSectionHeaderType) {
        return [UIView new];
    }
    
    UIView* v = [UIView new];
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
    if (section == LBBScenicDetailSectionTravelRecommendType) {
        
        
        [img mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(v);
            make.top.equalTo(v).offset(16);
        }];
        
        NSArray* segmentArray = @[@"景点",@"美食",@"民宿"];
        
        HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentArray];
        segmentedControl.selectionIndicatorHeight = 2.0f;  // 线的高度
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                                 NSForegroundColorAttributeName:ColorLightGray};
        segmentedControl.selectionIndicatorColor = ColorLightGray;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [v addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(8);
            make.centerX.equalTo(v);
            make.height.mas_equalTo(TopSegmmentControlHeight);
            make.width.equalTo(@200);
          //  make.bottom.equalTo(v);
        }];
        segmentedControl.indexChangeBlock = ^(NSInteger index){
            NSLog(@"segmentedControl select:%ld",index);
            
        };
    }

    return v;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return LBBScenicDetailSectionTotal;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case LBBScenicDetailSectionHeaderType://header部分
            return 3;
            break;
        case LBBScenicDetailSectionVipMPaiType://达人秒拍
            return 1;
            break;
        case LBBScenicDetailSectionRecommendReasonType://推荐理由
            return 1;
            break;
        case LBBScenicDetailSectionSpotType://景点详情
            return 3;
            break;
        case LBBScenicDetailSectionEquipmentType://景区设施
            return 1;
            break;
        case LBBScenicDetailSectionWarmPromptType://温馨提示
            return 4;
            break;
        case LBBScenicDetailSectionTravelRecommendType://周边推荐
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
        case LBBScenicDetailSectionVipMPaiType://达人秒拍
            return [self tableView:tableView heightForVipMPaiRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionRecommendReasonType://推荐理由
            return [self tableView:tableView heightForRecommendReasonRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSpotType://景点详情
            return [self tableView:tableView heightForHeaderSectionRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionEquipmentType://景区设施
            return [self tableView:tableView heightForEquipmentRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionWarmPromptType://温馨提示
            return [self tableView:tableView heightForWarmPromptRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionTravelRecommendType://周边推荐
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
        case LBBScenicDetailSectionVipMPaiType://达人秒拍
            return [self tableView:tableView cellForVipMPaiRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionRecommendReasonType://推荐理由
            return [self tableView:tableView cellForRecommendReasonRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionSpotType://景点详情
            return [self tableView:tableView cellForHeaderSectionRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionEquipmentType://景区设施
            return [self tableView:tableView cellForEquipmentRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionWarmPromptType://温馨提示
            return [self tableView:tableView cellForWarmPromptRowAtIndexPath:indexPath];
            break;
        case LBBScenicDetailSectionTravelRecommendType://周边推荐
            return [self tableView:tableView cellForTravelRecommendRowAtIndexPath:indexPath];
            break;
        default:
            return [self tableView:tableView cellForHeaderSectionRowAtIndexPath:indexPath];
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == LBBScenicDetailSectionTravelRecommendType) {//周边推荐
        LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
        dest.homeType = LBBPoohHomeTypeScenic;
        [self.navigationController pushViewController:dest animated:YES];
        
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
        [cell setCycleScrollViewHeight:AutoSize(386/2)];
        [cell setCycleScrollViewUrls:nil];
        [cell showOrderMessage];
        return cell;
        
    }
    else if(indexPath.row == 1){//msg
        
        static NSString *cellIdentifier = @"LBB_ScenicDetailPriceMsgCell";
        LBB_ScenicDetailPriceMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailPriceMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailPriceMsgCell nil");
        }
        [cell setModel:nil];
        return cell;
    }
    else{//address
        static NSString *cellIdentifier = @"LBB_ScenicDetailAddressCell";
        LBB_ScenicDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailAddressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailAddressCell nil");
        }
        return cell;
    
    }
}

#pragma 达人秒拍
-(UITableViewCell*)tableView:(UITableView *)tableView cellForVipMPaiRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_ScenicDetailVipMPaiCell";
    LBB_ScenicDetailVipMPaiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicDetailVipMPaiCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicDetailVipMPaiCell nil");
    }
    return cell;
    
}
#pragma 推荐理由
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRecommendReasonRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_ScenicTextTableViewCell";
    LBB_ScenicTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicTextTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicTextTableViewCell nil");
    }
    return cell;
        
}

#pragma 景区设施
-(UITableViewCell*)tableView:(UITableView *)tableView cellForEquipmentRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_ScenicDetailEquipmentCell";
    LBB_ScenicDetailEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_ScenicDetailEquipmentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_ScenicDetailEquipmentCell nil");
    }
    return cell;
    
}

#pragma 温馨提示
-(UITableViewCell*)tableView:(UITableView *)tableView cellForWarmPromptRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        static NSString *cellIdentifier = @"LBB_ScenicTextTableViewCell";
        LBB_ScenicTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicTextTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicTextTableViewCell nil");
        }
        return cell;
    }
    else if(indexPath.row == 1){
        
        static NSString *cellIdentifier = @"LBB_ScenicDetailBookStatusCell";
        LBB_ScenicDetailBookStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailBookStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailBookStatusCell nil");
        }
        return cell;
    }
    else if(indexPath.row == 2){
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
    else if (indexPath.row == 1){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailPriceMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailPriceMsgCell* cell){
            
            [cell setModel:nil];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailAddressCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailAddressCell* cell){
            
        }];
    }
}

#pragma 达人秒拍
-(CGFloat)tableView:(UITableView *)tableView heightForVipMPaiRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailVipMPaiCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailVipMPaiCell* cell){
        
    }];
    
    NSLog(@"heightForVipMPaiRowAtIndexPath:%f",height);
    
    return height;
    
}
#pragma 推荐理由
-(CGFloat)tableView:(UITableView *)tableView heightForRecommendReasonRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicTextTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicTextTableViewCell* cell){
    }];
  
}

#pragma 景区设施
-(CGFloat)tableView:(UITableView *)tableView heightForEquipmentRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailEquipmentCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailEquipmentCell* cell){
    }];
}

#pragma 温馨提示
-(CGFloat)tableView:(UITableView *)tableView heightForWarmPromptRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"heightForWarmPromptRowAtIndexPath:%ld",indexPath.row);
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicTextTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicTextTableViewCell* cell){
        }];
    }
    else if(indexPath.row == 1){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailBookStatusCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailBookStatusCell* cell){
        
        }];
    }
    else if(indexPath.row == 2){
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
    }];
}
@end
