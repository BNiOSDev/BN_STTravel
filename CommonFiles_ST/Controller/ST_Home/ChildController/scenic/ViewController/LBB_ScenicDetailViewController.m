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
#import "LBB_ScenicDetailADCell.h"
#import "LBB_PoohAttributedTextCell.h"

static const NSInteger kSearchButtonMarginRight = -10;
static const NSInteger kButtonWidth = 45;


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


@interface LBB_ScenicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* sectionArray;
@property (nonatomic, retain)LBB_ScenicDetailOrderConfirmView* popView;

@property (nonatomic, retain)UIButton* favoriteButton;
@property (nonatomic, retain)UIButton* shareButton;

@property (nonatomic, assign)  LBBPoohSegmCtrlType nearbyRecommendsSelectType;


@end

@implementation LBB_ScenicDetailViewController

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

    [self.spotModel getSpotDetailsData:YES];
    [self.spotModel.spotDetails.loadSupport setDataRefreshblock:^{
        
        /**
         3.2.8	周边推荐(已测)
         
         @param type 1.景点 2.美食 3.民宿
         @param longitude Y坐标
         @param dimensionality X坐标
         @param clear 是否清空原数据
         */
        [ws.spotModel.spotDetails getSpotNearbyRecommendsType:1 clearData:YES];
        [ws.spotModel.spotDetails getSpotNearbyRecommendsType:2 clearData:YES];
        [ws.spotModel.spotDetails getSpotNearbyRecommendsType:3 clearData:YES];
        
        
        
        UIView *view = [ws.view snapshotViewAfterScreenUpdates:NO];
        [ws.view addSubview:view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (ws.nearbyRecommendsSelectType) {
                case LBBPoohSegmCtrlFoodsType:
                    [ws.tableView setTableViewData:ws.spotModel.spotDetails.nearbyFoodRecommends];
                    break;
                case LBBPoohSegmCtrlHostelType:
                    [ws.tableView setTableViewData:ws.spotModel.spotDetails.nearbyHostelRecommends];
                    break;
                case LBBPoohSegmCtrlScenicType:
                    [ws.tableView setTableViewData:ws.spotModel.spotDetails.nearbySpotRecommends];
                    break;
                    
                default:
                    break;
            }
            [ws.tableView reloadData];//data reload
        });
        
    }];
    
    //附近数据更新时，刷新
    [self.spotModel.spotDetails.nearbySpotRecommends.loadSupport setDataRefreshblock:^{
       // NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:LBBScenicDetailSectionTravelRecommendType];
       // [ws.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
       // [ws.tableView reloadData];//data reload
        [ws reloadTableSnap];
    }];
    [self.spotModel.spotDetails.nearbyHostelRecommends.loadSupport setDataRefreshblock:^{
       // NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:LBBScenicDetailSectionTravelRecommendType];
      //  [ws.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
       // [ws.tableView reloadData];//data reload
        [ws reloadTableSnap];
    }];
    [self.spotModel.spotDetails.nearbyFoodRecommends.loadSupport setDataRefreshblock:^{
       // NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:LBBScenicDetailSectionTravelRecommendType];
        //[ws.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
      //  [ws.tableView reloadData];//data reload
        [ws reloadTableSnap];
    }];
    
    
    
    //3.1上拉和下拉的动作
    [self.tableView setHeaderRefreshDatablock:^{
        [ws.tableView.mj_header endRefreshing];
        
        [ws.spotModel getSpotDetailsData:YES];
        [ws.spotModel.spotDetails getSpotNearbyRecommendsType:1 clearData:YES];
        [ws.spotModel.spotDetails getSpotNearbyRecommendsType:2 clearData:YES];
        [ws.spotModel.spotDetails getSpotNearbyRecommendsType:3 clearData:YES];
        
    } footerRefreshDatablock:^{
        [ws.tableView.mj_footer endRefreshing];
        
        switch (ws.nearbyRecommendsSelectType) {
            case LBBPoohSegmCtrlFoodsType:
                [ws.spotModel.spotDetails getSpotNearbyRecommendsType:2 clearData:NO];
                break;
            case LBBPoohSegmCtrlHostelType:
                [ws.spotModel.spotDetails getSpotNearbyRecommendsType:3 clearData:NO];
                break;
            case LBBPoohSegmCtrlScenicType:
                [ws.spotModel.spotDetails getSpotNearbyRecommendsType:1 clearData:NO];
                break;
                
            default:
                break;
        }
        
    }];
    @weakify(self);
#pragma 数据绑定
    [RACObserve(self.spotModel.spotDetails, isCollected) subscribeNext:^(NSNumber* num) {
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
        
        [ws.spotModel.spotDetails collecte:^(NSError* error){
        
        }];
        
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
                          @"景点详情_达人秒拍",
                          @"景点详情_推荐理由",
                          @"景点详情_景点详情",
                          @"景点详情_景区设施",
                          @"景点详情_温馨提示",
                          @"景点详情_周边推荐",
                          ];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
    [self.baseContentView setBackgroundColor:[UIColor whiteColor]];
 
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
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
    
    
    if (self.homeType == LBBPoohHomeTypeScenic) {//景点页面才展示
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.top.centerX.equalTo(ws.view);
           // make.bottom.equalTo(ws.view);
        }];
        
        UIView* toolBar = [UIView new];
        toolBar.layer.borderColor = ColorBtnYellow.CGColor;
        toolBar.layer.borderWidth = 1;
        [self.baseContentView addSubview:toolBar];
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
        b.imageEdgeInsets = UIEdgeInsetsMake(0, AutoSize(110.55), 0, 0);
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
        b1.imageEdgeInsets = UIEdgeInsetsMake(0, AutoSize(112), 0, 0);
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
    [self.tableView registerClass:[LBB_ScenicDetailADCell class] forCellReuseIdentifier:@"LBB_ScenicDetailADCell"];
    
    //推荐理由
    [self.tableView registerClass:[LBB_ScenicTextTableViewCell class] forCellReuseIdentifier:@"LBB_ScenicTextTableViewCell"];

    //达人秒拍
    [self.tableView registerClass:[LBB_ScenicDetailVipMPaiCell class] forCellReuseIdentifier:@"LBB_ScenicDetailVipMPaiCell"];

    //景点详情 LBB_PoohAttributedTextCell.h
    [self.tableView registerClass:[LBB_PoohAttributedTextCell class] forCellReuseIdentifier:@"LBB_PoohAttributedTextCell"];

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
    WS(ws);
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
        segmentedControl.selectionIndicatorHeight = 1.0f;  // 线的高度
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:Font15,
                                                 NSForegroundColorAttributeName:ColorLightGray};
        segmentedControl.selectionIndicatorColor = ColorLightGray;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        [segmentedControl setSelectedSegmentIndex:self.nearbyRecommendsSelectType];
        [v addSubview:segmentedControl];
        [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(8);
            make.centerX.equalTo(v);
            make.height.mas_equalTo(AutoSize(25));
            make.width.equalTo(@200);
          //  make.bottom.equalTo(v);
        }];
        segmentedControl.indexChangeBlock = ^(NSInteger index){
            NSLog(@"segmentedControl select:%ld",index);
            
            UIView *view = [ws.view snapshotViewAfterScreenUpdates:NO];
            [ws.view addSubview:view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
            });
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ws.nearbyRecommendsSelectType = index;
                switch (ws.nearbyRecommendsSelectType) {
                    case LBBPoohSegmCtrlFoodsType:
                        [ws.tableView setTableViewData:ws.spotModel.spotDetails.nearbyFoodRecommends];
                        break;
                    case LBBPoohSegmCtrlHostelType:
                        [ws.tableView setTableViewData:ws.spotModel.spotDetails.nearbyHostelRecommends];
                        break;
                    case LBBPoohSegmCtrlScenicType:
                        [ws.tableView setTableViewData:ws.spotModel.spotDetails.nearbySpotRecommends];
                        break;
                        
                    default:
                        break;
                }
            });
            
//            [ws.tableView reloadData];
        //    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:LBBScenicDetailSectionTravelRecommendType];
          //  [ws.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
            return 1;
            break;
        case LBBScenicDetailSectionEquipmentType://景区设施
            return 1;
            break;
        case LBBScenicDetailSectionWarmPromptType://温馨提示
            return 4;
            break;
        case LBBScenicDetailSectionTravelRecommendType://周边推荐
        {
            switch (self.nearbyRecommendsSelectType) {
                case LBBPoohSegmCtrlFoodsType:
                    return self.spotModel.spotDetails.nearbyFoodRecommends.count;
                    break;
                case LBBPoohSegmCtrlHostelType:
                    return self.spotModel.spotDetails.nearbyHostelRecommends.count;
                    break;
                case LBBPoohSegmCtrlScenicType:
                    return self.spotModel.spotDetails.nearbySpotRecommends.count;
                    break;
                    
                default:
                    return 0;
                    break;
            }
        }
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
            return [self tableView:tableView heightForScenicDetailRowAtIndexPath:indexPath];
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
            return [self tableView:tableView cellForScenicDetailRowAtIndexPath:indexPath];
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
        
        LBB_SpotsNearbyRecommendData* obj;
        switch (self.nearbyRecommendsSelectType) {
            case LBBPoohSegmCtrlFoodsType:
                obj = self.spotModel.spotDetails.nearbyFoodRecommends[indexPath.row];
                break;
            case LBBPoohSegmCtrlHostelType:
                obj = self.spotModel.spotDetails.nearbyHostelRecommends[indexPath.row];
                break;
            case LBBPoohSegmCtrlScenicType:
                obj = self.spotModel.spotDetails.nearbySpotRecommends[indexPath.row];
                break;
            default:
                break;
        }
        
        LBB_ScenicDetailViewController* dest = [[LBB_ScenicDetailViewController alloc]init];
        LBB_SpotModel* spotModel = [[LBB_SpotModel alloc] init];
        spotModel.allSpotsId = obj.allSpotsId;
        dest.spotModel = spotModel;
        switch (obj.allSpotsType) {//场景类型 1美食 2 民宿 3 景点

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
                break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:dest animated:YES];
        
    }
}


/*
 *  对每个section的cell进行分开封装
 */
#pragma header 部分的cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {//ad
        static NSString *cellIdentifier = @"LBB_ScenicDetailADCell";
        LBB_ScenicDetailADCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailADCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            NSLog(@"LBB_ScenicDetailADCell nil");
        }
        [cell setCycleScrollViewHeight:AutoSize(386/2)];
        [cell setAllSpotsPics:self.spotModel.spotDetails.allSpotsPics];
      //  [cell setPurchaseRecords:self.spotModel.spotDetails.purchaseRecords];
        NSString* url = @"";
        if (self.spotModel.spotDetails.allSpotsPics.count > 0) {
            LBB_SpotsPics* pic = self.spotModel.spotDetails.allSpotsPics[0];
            url = pic.imageUrl;
        }
        [cell showOrderMessage:self.spotModel.spotDetails.purchaseRecords andImageUrl:url];
        return cell;
        
    }
    else if(indexPath.row == 1){//msg
        
        static NSString *cellIdentifier = @"LBB_ScenicDetailPriceMsgCell";
        LBB_ScenicDetailPriceMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailPriceMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailPriceMsgCell nil");
        }
        [cell setModel:self.spotModel.spotDetails];
        return cell;
    }
    else{//address
        static NSString *cellIdentifier = @"LBB_ScenicDetailAddressCell";
        LBB_ScenicDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailAddressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailAddressCell nil");
        }
        [cell setModel:self.spotModel.spotDetails];
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
    [cell setUgc:self.spotModel.spotDetails.ugc];

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
    [cell setContentLabelText:self.spotModel.spotDetails.recommendedReason];
    return cell;
        
}

#pragma 景点详情
-(UITableViewCell*)tableView:(UITableView *)tableView cellForScenicDetailRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LBB_PoohAttributedTextCell";
    LBB_PoohAttributedTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LBB_PoohAttributedTextCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        NSLog(@"LBB_PoohAttributedTextCell nil");
    }
    [cell setAttributedText:self.spotModel.spotDetails.details];
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
    [cell setFacilities:self.spotModel.spotDetails.facilities];
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
        [cell setContentLabelText:self.spotModel.spotDetails.warmPrompt];

        return cell;
    }
    else if(indexPath.row == 1){
        
        static NSString *cellIdentifier = @"LBB_ScenicDetailBookStatusCell";
        LBB_ScenicDetailBookStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailBookStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailBookStatusCell nil");
        }
        [cell setSpotDetailModel:self.spotModel.spotDetails];
        return cell;
    }
    else if(indexPath.row == 2){
        static NSString *cellIdentifier = @"LBB_ScenicDetailVipFavoriteCell";
        LBB_ScenicDetailVipFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailVipFavoriteCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailVipFavoriteCell nil");
        }
        [cell setCollectedRecord:self.spotModel.spotDetails.collectedRecord];
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"LBB_ScenicDetailCommentsCell";
        LBB_ScenicDetailCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[LBB_ScenicDetailCommentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            NSLog(@"LBB_ScenicDetailCommentsCell nil");
        }
       // [cell setCommentsRecord:self.spotModel.spotDetails.commentsRecord];
        [cell setSpotDetails:self.spotModel.spotDetails];
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
    
    LBB_SpotsNearbyRecommendData* obj;
    switch (self.nearbyRecommendsSelectType) {
        case LBBPoohSegmCtrlFoodsType:
            obj = self.spotModel.spotDetails.nearbyFoodRecommends[indexPath.row];
            break;
        case LBBPoohSegmCtrlHostelType:
            obj = self.spotModel.spotDetails.nearbyHostelRecommends[indexPath.row];
            break;
        case LBBPoohSegmCtrlScenicType:
            obj = self.spotModel.spotDetails.nearbySpotRecommends[indexPath.row];
            break;
            
        default:
            break;
    }
    
    [cell setModel:obj];
    return cell;
    
}
/*
 *  对每个section的cell heigt进行分开封装
 */
#pragma header 部分
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderSectionRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    if (indexPath.row == 0) {
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailADCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailADCell* cell){
            [cell setCycleScrollViewHeight:AutoSize(386/2)];
          //  [cell setCycleScrollViewUrls:nil];
        }];
    }
    else if (indexPath.row == 1){
        
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailPriceMsgCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailPriceMsgCell* cell){
            
            [cell setModel:ws.spotModel.spotDetails];
        }];
    }
    else{
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailAddressCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailAddressCell* cell){
            [cell setModel:ws.spotModel.spotDetails];

        }];
    }
}

#pragma 达人秒拍
-(CGFloat)tableView:(UITableView *)tableView heightForVipMPaiRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailVipMPaiCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailVipMPaiCell* cell){
        [cell setUgc:ws.spotModel.spotDetails.ugc];

    }];
    
    NSLog(@"heightForVipMPaiRowAtIndexPath:%f",height);

    return height;
    
}
#pragma 推荐理由
-(CGFloat)tableView:(UITableView *)tableView heightForRecommendReasonRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicTextTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicTextTableViewCell* cell){
        [cell setContentLabelText:ws.spotModel.spotDetails.recommendedReason];

    }];
  
}

#pragma 景点详情
-(CGFloat)tableView:(UITableView *)tableView heightForScenicDetailRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_PoohAttributedTextCell" cacheByIndexPath:indexPath configuration:^(LBB_PoohAttributedTextCell* cell){
        [cell setAttributedText:ws.spotModel.spotDetails.details];
        
    }];
    
}

#pragma 景区设施
-(CGFloat)tableView:(UITableView *)tableView heightForEquipmentRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailEquipmentCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailEquipmentCell* cell){
        
        [cell setFacilities:ws.spotModel.spotDetails.facilities];
    }];
}

#pragma 温馨提示
-(CGFloat)tableView:(UITableView *)tableView heightForWarmPromptRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    NSLog(@"heightForWarmPromptRowAtIndexPath:%ld",indexPath.row);
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicTextTableViewCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicTextTableViewCell* cell){
            [cell setContentLabelText:ws.spotModel.spotDetails.warmPrompt];

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
            [cell setSpotDetails:ws.spotModel.spotDetails];
        }];
    }
}
#pragma 周边推荐
-(CGFloat)tableView:(UITableView *)tableView heightForTravelRecommendRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(ws);
    return [tableView fd_heightForCellWithIdentifier:@"LBB_ScenicDetailTravelRecommendCell" cacheByIndexPath:indexPath configuration:^(LBB_ScenicDetailTravelRecommendCell* cell){
        LBB_SpotsNearbyRecommendData* obj;
        switch (ws.nearbyRecommendsSelectType) {
            case LBBPoohSegmCtrlFoodsType:
                obj = ws.spotModel.spotDetails.nearbyFoodRecommends[indexPath.row];
                break;
            case LBBPoohSegmCtrlHostelType:
                obj = ws.spotModel.spotDetails.nearbyHostelRecommends[indexPath.row];
                break;
            case LBBPoohSegmCtrlScenicType:
                obj = ws.spotModel.spotDetails.nearbySpotRecommends[indexPath.row];
                break;
                
            default:
                break;
        }
        
        [cell setModel:obj];
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

        if(self.spotModel.spotDetails.isCollected == 1){
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
        if(self.spotModel.spotDetails.isCollected == 1){
            [self.favoriteButton.imageView setTintColor:[[UIColor redColor]colorWithAlphaComponent:alpha]];
        }
        else{
            [self.favoriteButton.imageView setTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        }
    }
}
@end
