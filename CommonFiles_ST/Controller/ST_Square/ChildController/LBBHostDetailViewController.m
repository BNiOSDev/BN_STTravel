//
//  LBBHostDetailViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHostDetailViewController.h"
#import "ST_TabBarController.h"

@interface LBBHostDetailViewController ()

@end

@implementation LBBHostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [(ST_TabBarController*)self.tabBarController setTabBarHidden:YES animated:YES];
}

- (void)loadCustomNavigationButton
{
    ;
}

@end
