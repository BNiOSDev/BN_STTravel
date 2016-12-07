//
//  LBBSigninMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBSigninMainViewController.h"
#import "LBB_SignInListViewController.h"
#import "LBB_SignInRankListViewController.h"
#import "LBB_SigninPopView.h"
#import "LBB_NearViewModel.h"
#import <BN_MapView.h>
#import "LBB_NearSign.h"
@interface LBBSigninMainViewController ()

@property(nonatomic, retain)BN_MapView* mapView;

@property(nonatomic, retain)UILabel* noteLable;

@property(nonatomic, retain)LBB_SigninPopView* popView;
//地理位置管理
@property (nonatomic, retain)LBB_PoohCoreLocationManager* locationManager;
@property (nonatomic, strong)LBB_NearViewModel* viewModel;
@end

@implementation LBBSigninMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewModel{
    
    self.locationManager = [[LBB_PoohCoreLocationManager alloc] init];
    
    self.viewModel = [[LBB_NearViewModel alloc]init];
    
    @weakify(self);

    /**
     3.9.4	附近–签到信息(已测)
     */
    [self.viewModel getSignInfo];
    [RACObserve(self.viewModel, signInNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        [self.noteLable setText:[NSString stringWithFormat:@"您已完成%ld个景点，目前排名第%d名",self.viewModel.signInNum,self.viewModel.rank]];

    }];
    [RACObserve(self.viewModel, rank) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        [self.noteLable setText:[NSString stringWithFormat:@"您已完成%ld个景点，目前排名第%d名",self.viewModel.signInNum,self.viewModel.rank]];
    }];
    
    /**
     3.9.1	附近的商家 (已测)
     
     @param longitude Y坐标
     @param dimensionality X坐标
     */
    [RACObserve(self.locationManager, latitude) subscribeNext:^(NSString* num) {
        @strongify(self);
        
        [self.viewModel getNearSignInMapArrayClearData:self.locationManager.longitude dimensionality:self.locationManager.latitude clear:YES];
    }];
    
    [RACObserve(self.locationManager, longitude) subscribeNext:^(NSString* num) {
        @strongify(self);
        
        [self.viewModel getNearSignInMapArrayClearData:self.locationManager.longitude dimensionality:self.locationManager.latitude clear:YES];
    }];
    
    WS(ws);
    [self.viewModel.nearShopArray.loadSupport setDataRefreshblock:^{
    
        [ws.mapView removeAllAnnotation];
        [ws.mapView setDelta:0.2 Latitude:[ws.locationManager.latitude floatValue] longitude:[ws.locationManager.longitude floatValue]];
        for (LBB_NearShopModel* model in ws.viewModel.nearShopArray) {
            
            [ws.mapView andAnnotationLatitude:[model.dimensionality floatValue] longitude:[model.longitude floatValue]];
        }
    }];
    
    
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
 * setup navigation bar view
 */
-(void)loadCustomNavigationButton{
    
    WS(ws);
    self.title = @"旅游足迹";
    UIButton *sign = [[UIButton alloc] init];
    [sign setImage:IMAGE(@"ST_Sign_signIcon") forState:UIControlStateNormal];
    [sign setTitle:@"签到" forState:UIControlStateNormal];
    [sign setTitleColor:ColorLightGray forState:UIControlStateNormal];
    [sign.titleLabel setFont:Font15];
    [sign setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [sign setFrame:CGRectMake(0, 0, AutoSize(60), AutoSize(30))];
    [sign bk_addEventHandler:^(id sender){
        
        
        if (ws.viewModel.nearShopArray.count <= 0) {
            [ws showHudPrompt:@"附近没有可签到的信息"];
            return ;
        }
        
        
        LBB_NearShopModel* obj = [ws.viewModel.nearShopArray objectAtIndex:0];
        NSLog(@"sign touch");
        if (!ws.popView) {
            ws.popView = [[LBB_SigninPopView alloc]init];
        }
        [ws.popView showPopView:obj];
        [ws.popView.signinButton bk_addEventHandler:^(id sender){
            NSLog(@"ws.popView.signinButton touch");
            
            [LBB_NearSign signObjId:obj.allSpotsId type:/*(int)obj.allSpotsType*/0 block:^(NSError* error){
                if (!error) {
                    [ws.popView setSigninStatus:YES];
                }
                else{
                    [ws.popView setSigninStatus:NO];
                    [ws.popView.noteLabel setText:error.domain];
                }
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ws.popView.hidden = YES;
                [ws.popView resignKeyWindow];
                ws.popView = nil;
            });
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    

    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:sign];
    self.navigationItem.rightBarButtonItem = signItem;
}

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView* sep = [UIView new];

    UIButton *signList = [[UIButton alloc] init];
    [signList setImage:IMAGE(@"ST_Sign_signList") forState:UIControlStateNormal];
    [signList setTitle:@"签到列表" forState:UIControlStateNormal];
    [signList.titleLabel setFont:Font15];
    [signList setTitleColor:ColorGray forState:UIControlStateNormal];
    [signList setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    
    
    UIButton *signRank = [[UIButton alloc] init];
    [signRank setImage:IMAGE(@"ST_Sign_signRank") forState:UIControlStateNormal];
    [signRank setTitle:@"签到排行" forState:UIControlStateNormal];
    [signRank.titleLabel setFont:Font15];
    [signRank setTitleColor:ColorGray forState:UIControlStateNormal];
    [signRank setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    
    [sep setBackgroundColor:ColorLine];
    
    [self.view addSubview:signList];
    [self.view addSubview:signRank];
    [self.view addSubview:sep];

    [signList mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.top.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(TopSegmmentControlHeight));
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(signList);
        make.width.mas_equalTo(SeparateLineWidth);
        make.height.equalTo(@30);
        make.left.equalTo(signList.mas_right);
    }];
    [signRank mas_makeConstraints:^(MASConstraintMaker* make){
        make.right.top.equalTo(ws.view);
        make.height.width.equalTo(signList);
        make.left.equalTo(sep.mas_right);
    }];
    
    
    
    //map
    self.mapView = [[BN_MapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerX.bottom.width.equalTo(ws.view);
        make.top.equalTo(signList.mas_bottom);
      //  make.height.mas_equalTo(DeviceWidth*3/2);
    }];
    
    self.noteLable = [UILabel new];
    [self.noteLable setText:@"您已完成0个景点，目前排名第0名"];
    [self.noteLable setTextColor:[UIColor whiteColor]];
    [self.noteLable setTextAlignment:NSTextAlignmentCenter];
    [self.noteLable setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
    [self.noteLable setFont:Font15];
    [self.view addSubview:self.noteLable];
    [self.noteLable mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.top.equalTo(ws.mapView);
        make.height.mas_equalTo(AutoSize(TopSegmmentControlHeight));
    }];

    
    [signList bk_addEventHandler:^(id sender){
    
        LBB_SignInListViewController* v = [[LBB_SignInListViewController alloc]init];
        v.viewModel = ws.viewModel;
        [ws.navigationController pushViewController:v animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [signRank bk_addEventHandler:^(id sender){
        
        LBB_SignInRankListViewController* v = [[LBB_SignInRankListViewController alloc]init];
        v.viewModel = ws.viewModel;
        [ws.navigationController pushViewController:v animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [self initViewModel];
    
}
@end
