//
//  LBB_NewOrderViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderViewController.h"
#import "LBB_NewOrderPlayTimeSelectView.h"

@interface LBB_NewOrderViewController ()

@property (nonatomic, retain) UIScrollView *mainScrollView;

@property (nonatomic, retain)LBB_NewOrderPlayTimeSelectView* playTimeView;

@end

@implementation LBB_NewOrderViewController

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


-(void)loadCustomNavigationButton{
    self.title = @"确认订单";
}

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainScrollView = [UIScrollView new];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.mainScrollView setContentSize:CGSizeMake(0, UISCREEN_HEIGTH)];
    NSLog(@"height:%f",UISCREEN_HEIGTH);
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
    }];
    
    CGFloat margin = 8;
    
    self.playTimeView = [[LBB_NewOrderPlayTimeSelectView alloc]init];
    [self.view addSubview:self.playTimeView];
    [self.playTimeView mas_makeConstraints:^(MASConstraintMaker* make){
    
        make.centerX.top.width.equalTo(ws.mainScrollView);
        make.height.mas_equalTo(AutoSize(138/2));
    }];
    

}


@end
