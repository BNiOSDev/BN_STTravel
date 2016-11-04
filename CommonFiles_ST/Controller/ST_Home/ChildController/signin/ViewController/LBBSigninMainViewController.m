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

@interface LBBSigninMainViewController ()

@property(nonatomic, retain)UIView* mapView;

@property(nonatomic, retain)UILabel* noteLable;

@property(nonatomic, retain)LBB_SigninPopView* popView;

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
        
        NSLog(@"sign touch");
        if (!ws.popView) {
            ws.popView = [[LBB_SigninPopView alloc]init];
        }
        [ws.popView showPopView];
        [ws.popView.signinButton bk_addEventHandler:^(id sender){
            NSLog(@"ws.popView.signinButton touch");
            
            [ws.popView setSigninStatus:NO];
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
    
    UIControl* ctr1 = [UIControl new];
    UIControl* ctr2 = [UIControl new];
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    
    [self.view addSubview:ctr1];
    [self.view addSubview:ctr2];
    [self.view addSubview:sep];

    [ctr1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.top.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(TopSegmmentControlHeight));
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(ctr1);
        make.width.equalTo(@1.5);
        make.height.equalTo(@30);
        make.left.equalTo(ctr1.mas_right);
    }];
    [ctr2 mas_makeConstraints:^(MASConstraintMaker* make){
        make.right.top.equalTo(ws.view);
        make.height.width.equalTo(ctr1);
        make.left.equalTo(sep.mas_right);
    }];
    
    
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

    [ctr1 addSubview:signList];
    [signList mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.equalTo(ctr1);
       // make.height.equalTo(@18);
    }];
    
    [ctr2 addSubview:signRank];
    [signRank mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.equalTo(ctr2);
      //  make.height.equalTo(signList);
    }];
    
    
    //map
    self.mapView = [UIView new];
    [self.mapView setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerX.width.equalTo(ws.view);
        make.top.equalTo(ctr1.mas_bottom);
        make.height.mas_equalTo(DeviceWidth*3/2);
    }];
    
    self.noteLable = [UILabel new];
    [self.noteLable setText:@"您已完成80个景点，目前排名第12名"];
    [self.noteLable setTextColor:[UIColor whiteColor]];
    [self.noteLable setTextAlignment:NSTextAlignmentCenter];
    [self.noteLable setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
    [self.noteLable setFont:Font15];
    [self.view addSubview:self.noteLable];
    [self.noteLable mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.width.top.equalTo(ws.mapView);
        make.height.mas_equalTo(AutoSize(TopSegmmentControlHeight));
    }];

    
    [ctr1 bk_whenTapped:^{
        LBB_SignInListViewController* v = [[LBB_SignInListViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
    }];
    
    
    [ctr2 bk_whenTapped:^{
        LBB_SignInRankListViewController* v = [[LBB_SignInRankListViewController alloc]init];
        [ws.navigationController pushViewController:v animated:YES];
    }];
}
@end
