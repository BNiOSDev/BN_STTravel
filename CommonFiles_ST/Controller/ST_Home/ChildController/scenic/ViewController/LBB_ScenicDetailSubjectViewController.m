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

static const NSInteger kSearchButtonMarginRight = -10;
static const NSInteger kButtonWidth = 45;
typedef NS_ENUM(NSInteger, LBBScenicDetailSubSectionType) {
    LBBScenicDetailSectionHeaderType = 0,//header部分
    LBBScenicDetailSectionSubjectType,//专题项
    LBBScenicDetailSectionSubjectFavoriteType,//专题收藏
    LBBScenicDetailSectionSubjectRecommendType,//专题推荐
    
    LBBScenicDetailSectionTotal,//总数
    
};


@interface LBB_ScenicDetailSubjectViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* sectionArray;
@property (nonatomic, retain)UIButton* favoriteButton;
@property (nonatomic, retain)UIButton* shareButton;

@end

@implementation LBB_ScenicDetailSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton:nil];
    [self setBaseNavigationBarHidden:NO];
    [self setBaseNavigationBarBackgroundColor:[UIColor clearColor]];
    [self setupFullContentView];
    [self setupNavigationUI];
    [self setupUI];
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


-(void)reloadTableSnap{
    
    UIView *view = [self.view snapshotViewAfterScreenUpdates:NO];
    [self.view addSubview:view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
}

-(void)initViewModel{
    WS(ws);
    
    if (!self.spotModel) {
        self.spotModel = [[LBB_SpotSpecialDetailsViewModel alloc] init];
    }
    
    [self.spotModel getSpotSpecialDetailsData];
    [self.spotModel.spotSpecialDetails.loadSupport setDataRefreshblock:^{
        
        [ws reloadTableSnap];
    }];
    
    [self.spotModel getSpotSpecialListArray:YES];
    
    [self.spotModel.spotSpecialList.loadSupport setDataRefreshblock:^{
        
        [ws reloadTableSnap];
    }];
    
    [self.tableView setTableViewData:self.spotModel.spotSpecialList];
    
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        
        [ws.spotModel getSpotSpecialDetailsData];
        [ws.spotModel getSpotSpecialListArray:YES];

        
    } footerRefreshDatablock:^{
        [ws.tableView.mj_footer endRefreshing];
        
        [ws.spotModel getSpotSpecialListArray:NO];

    }];
    @weakify(self);
#pragma 数据绑定
    [RACObserve(self.spotModel.spotSpecialDetails, isCollected) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        BOOL status = [num boolValue];
        if (status) {
            UIImage* image1 = [[UIImage imageNamed:@"景点详情_收藏HL"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.favoriteButton setImage:image1 forState:UIControlStateNormal];
            [self.favoriteButton.imageView setTintColor:[UIColor redColor]];
        }
        else{
            UIImage* image1 = [[UIImage imageNamed:@"景点详情_收藏"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.favoriteButton setImage:image1 forState:UIControlStateNormal];
            [self.favoriteButton.imageView setTintColor:[UIColor whiteColor]];
        }
    }];
    
}
/*
 * setup Navigation UI
 */
-(void)setupNavigationUI{
    
    WS(ws);
    UIButton *share = [[UIButton alloc] init];
    UIImage* image = [[UIImage imageNamed:@"景点详情_分享"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [share setImage:image forState:UIControlStateNormal];
    [self.baseNavigationBarView addSubview:share];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(kButtonWidth);
        make.bottom.equalTo(ws.baseNavigationBarView);
        make.right.equalTo(ws.baseNavigationBarView).offset(kSearchButtonMarginRight);
    }];
    [share bk_addEventHandler:^(id sender){
        
        
    }forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = share;
    UIButton *favorite = [[UIButton alloc] init];
    UIImage* image1 = [[UIImage imageNamed:@"景点详情_收藏"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [favorite setImage:image1 forState:UIControlStateNormal];
    [self.baseNavigationBarView addSubview:favorite];
    [favorite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(kButtonWidth);
        make.bottom.equalTo(ws.baseNavigationBarView);
        make.right.equalTo(share.mas_left).offset(kSearchButtonMarginRight);
    }];
    
    [favorite bk_addEventHandler:^(id sender){
        
    }forControlEvents:UIControlEventTouchUpInside];
    self.favoriteButton = favorite;
    
    [self.shareButton.imageView setTintColor:[UIColor whiteColor]];
    [self.favoriteButton.imageView setTintColor:[UIColor whiteColor]];
}


/*
 * setup UI
 */

-(void)setupUI{
    
    WS(ws);
    
    
    self.sectionArray = @[
                          @"",
                          @"",
                          @"",
                          @"景点专题_专题推荐",

                          ];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.baseContentView setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerTableViewCell];
    [self initViewModel];
    [self.baseContentView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.top.centerX.equalTo(ws.baseContentView);
        make.bottom.equalTo(ws.baseContentView);
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
            return 3;
            break;
        case LBBScenicDetailSectionSubjectType://专题项
            return self.spotModel.spotSpecialList.count;
            break;
        case LBBScenicDetailSectionSubjectFavoriteType:///专题收藏
            return 2;
            break;
        case LBBScenicDetailSectionSubjectRecommendType://专题推荐
            return self.spotModel.spotSpecialDetails.recommendSpecials.count;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == LBBScenicDetailSectionSubjectRecommendType) {
        LBB_ScenicDetailSubjectViewController* dest = [[LBB_ScenicDetailSubjectViewController alloc]init];
        LBB_SpotSpecialDetailsViewModel* spotModel = [[LBB_SpotSpecialDetailsViewModel alloc] init];
        LBB_SpotSpecialRecommendSpecials* recommendModel = self.spotModel.spotSpecialDetails.recommendSpecials[indexPath.row];
        spotModel.specialId = recommendModel.specialId;
        dest.spotModel = spotModel;
        //type;//	Int	1美食 2 民宿 3 景点  4 伴手礼
        
        switch (recommendModel.type) {
                
            case 1://美食
                dest.homeType = LBBPoohHomeTypeFoods;
                break;
            case 2://民宿
                dest.homeType = LBBPoohHomeTypeHostel;
                break;
            case 3://景点
                dest.homeType = LBBPoohHomeTypeScenic;
                break;
            case 4://伴手礼
                dest.homeType = LBBPoohHomeTypeProduct;
                break;
        }
        if (dest) {
            [self.navigationController pushViewController:dest animated:YES];
        }
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
        [cell setCycleScrollViewUrls:@[self.spotModel.spotSpecialDetails.coverImagesUrl]];
        return cell;
        
    }
    else if(indexPath.row == 1){//msg
        
        static NSString *cellIdentifier = @"LBB_ScenicDetailSubjectLableCell";
        LBB_ScenicDetailSubjectLableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailSubjectLableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailSubjectLableCell nil");
        }
        [cell setTags:self.spotModel.spotSpecialDetails.tags];
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
        cell.contentLabel.text = self.spotModel.spotSpecialDetails.content;
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
    [cell setModel:self.spotModel.spotSpecialList[indexPath.row]];
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
        [cell setCollectedRecord:self.spotModel.spotSpecialDetails.collectedRecord];
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_ScenicDetailCommentsCell";
        LBB_ScenicDetailCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailCommentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailCommentsCell nil");
        }
      //  [cell setCommentsRecord:self.spotModel.spotSpecialDetails.commentsRecord];
        [cell setSpotSpecialDetails:self.spotModel.spotSpecialDetails];
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
    [cell setSpecialsModel:self.spotModel.spotSpecialDetails.recommendSpecials[indexPath.row]];
    
    return cell;
    
}
/*
 *  对每个section的cell heigt进行分开封装
 */
#pragma header 部分
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    if (indexPath.row == 0) {
        
        return [tableView fd_heightForCellWithIdentifier:@"LBBPoohCycleScrollCell" cacheByIndexPath:indexPath configuration:^(LBBPoohCycleScrollCell* cell){
            [cell setCycleScrollViewHeight:AutoSize(386/2)];
            [cell setCycleScrollViewUrls:@[ws.spotModel.spotSpecialDetails.coverImagesUrl]];
        }];
    }
    else if (indexPath.row == 1){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailSubjectLableCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailSubjectLableCell* cell){
            [cell setTags:ws.spotModel.spotSpecialDetails.tags];

        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicTextTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicTextTableViewCell* cell){
            [cell setLineInset:16 andHeight:0.6];
            [cell.sepLineView setBackgroundColor:ColorLightGray];
            cell.contentLabel.text = ws.spotModel.spotSpecialDetails.content;
        }];
    }
}

#pragma 专题项
-(CGFloat)tableView:(UITableView *)tableView heightForSubjectsRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailSubjectContentCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailSubjectContentCell* cell){
        [cell setModel:ws.spotModel.spotSpecialList[indexPath.row]];
    }];
    
}


#pragma 达人收藏
-(CGFloat)tableView:(UITableView *)tableView heightForSubjectFavoriteRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    if(indexPath.row == 0){
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailVipFavoriteCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailVipFavoriteCell* cell){
            
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailCommentsCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailCommentsCell* cell){
            [cell setSpotSpecialDetails:ws.spotModel.spotSpecialDetails];

        }];
    }
}
#pragma 周边推荐
-(CGFloat)tableView:(UITableView *)tableView heightForTravelRecommendRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailTravelRecommendCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailTravelRecommendCell* cell){
        [cell setModel:nil];
        cell.priceLable.hidden = YES;
        [cell setSpecialsModel:ws.spotModel.spotSpecialDetails.recommendSpecials[indexPath.row]];

    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"offset---scroll:%f",self.tableView.contentOffset.y);
    UIColor *color=[UIColor whiteColor];
    CGFloat offset=scrollView.contentOffset.y;
    if (offset<=10) {
        //self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
        [self setBaseNavigationBarBackgroundColor:[UIColor clearColor]];
        [self.shareButton.imageView setTintColor:[UIColor whiteColor]];
        [self.baseLeftButton.imageView setTintColor:[UIColor whiteColor]];
        if(self.spotModel.spotSpecialDetails.isCollected == 1){
            [self.favoriteButton.imageView setTintColor:[UIColor redColor]];
        }
        else{
            [self.favoriteButton.imageView setTintColor:[UIColor whiteColor]];
        }

    }else {
        CGFloat alpha=1-((64-offset)/64);
        //  self.navigationController.navigationBar.backgroundColor=[color colorWithAlphaComponent:alpha];
        [self setBaseNavigationBarBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self.shareButton.imageView setTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self.baseLeftButton.imageView setTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        if(self.spotModel.spotSpecialDetails.isCollected == 1){
            [self.favoriteButton.imageView setTintColor:[[UIColor redColor]colorWithAlphaComponent:alpha]];
        }
        else{
            [self.favoriteButton.imageView setTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        }
    }
}
@end
