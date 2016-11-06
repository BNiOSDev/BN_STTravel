//
//  SettingPushViewController.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/10.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import "SettingPushViewController.h"

@interface SettingPushViewController ()

@end

@implementation SettingPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eSettingPush;
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.dataSourceArray = [[NSMutableArray alloc] initWithArray:@[
                                                                   @{@"Title": NSLocalizedString(@"推送消息震动提醒",nil),
                                                                     @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                     @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"推送消息声音提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:NO],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"精品内容推荐提醒提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"关注提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"私聊提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"点赞提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"收藏提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"评论提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:NO],
                                                                      @"Action":@"wallet"},
                                                                    @{@"Title": NSLocalizedString(@"夜间防骚扰提醒",nil),
                                                                      @"SwitchOn" : [NSNumber numberWithBool:YES],
                                                                      @"ShowDesc" : [NSNumber numberWithBool:YES],
                                                                      @"Action":@"wallet"}
                                                                   
                                                                   ]];
    
}


@end
