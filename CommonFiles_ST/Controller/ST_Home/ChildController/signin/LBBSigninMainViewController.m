//
//  LBBSigninMainViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBSigninMainViewController.h"
#import "LBBPoohGreatItemView.h"

@interface LBBSigninMainViewController ()

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
    self.title = @"旅游足迹";
    LBBPoohGreatItemView *sign = [[LBBPoohGreatItemView alloc] init];
    [sign.iconView setImage:IMAGE(@"poohGreat")];
    [sign.desLabel setText:@"签到"];
    [sign setFrame:CGRectMake(0, 0, 55, 25)];
    [sign bk_addEventHandler:^(id sender){
        
        NSLog(@"sign touch");
        
    } forControlEvents:UIControlEventTouchUpInside];
    

    UIBarButtonItem *signItem = [[UIBarButtonItem alloc] initWithCustomView:sign];
    self.navigationItem.rightBarButtonItem = signItem;
}

/*
 * setup UI
 */
-(void)buildControls{
    
    WS(ws);
    UIControl* ctr1 = [UIControl new];
    UIControl* ctr2 = [UIControl new];
    UIView* sep = [UIView new];
    [sep setBackgroundColor:[UIConstants getSeperatorLineColor]];
    
    [self.view addSubview:ctr1];
    [self.view addSubview:ctr2];
    [self.view addSubview:sep];

    [ctr1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.top.equalTo(ws.view);
        make.height.equalTo(@45);
    }];
    
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerY.equalTo(ctr1);
        make.width.equalTo(@1);
        make.height.equalTo(@30);
        make.left.equalTo(ctr1.mas_right);
    }];
    [ctr1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.right.top.equalTo(ws.view);
        make.height.width.equalTo(ctr1);
        make.left.equalTo(sep.mas_right);
    }];
    
    
    LBBPoohGreatItemView *signList = [[LBBPoohGreatItemView alloc] init];
    [signList.iconView setImage:IMAGE(@"poohGreat")];
    [signList.desLabel setText:@"签到列表"];
    
    LBBPoohGreatItemView *signRank = [[LBBPoohGreatItemView alloc] init];
    [signRank.iconView setImage:IMAGE(@"poohGreat")];
    [signRank.desLabel setText:@"签到排行"];
    
    [ctr1 addSubview:signList];
    [signList mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.equalTo(ctr1);
        make.height.equalTo(@25);
    }];
    
    [ctr2 addSubview:signRank];
    [signRank mas_makeConstraints:^(MASConstraintMaker* make){
        make.center.equalTo(ctr2);
        make.height.equalTo(signList);
    }];

}
@end
