//
//  SettingPrivaceViewController.m
//  LUBABA
//
//  Created by Diana on 16/10/10.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import "SettingPrivaceViewController.h"

@interface SettingPrivaceViewController ()

@end

@implementation SettingPrivaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eSettingPrivace;
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"向我推荐通讯录好友",nil),
                                                                     @"SwitchOn" : [NSNumber numberWithBool:YES]
                                                                     ,@"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"关注需要通过我审核",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:NO],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"好友动态红点提示",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"}
                                                                   ]];
    
}

@end
