//
//  Director.m
//  HappyPenguin
//
//  Created by zhuangyihang on 12/30/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import "PoohDirector.h"

/*
#import "AppConstants.h"

#import "HUD.h"
#import <KVNProgress/KVNProgress.h>
#import "WXApi.h"
#import "MobClick.h"

*/
#import "DDFormatter.h"


@interface PoohDirector()

@end

@implementation PoohDirector

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (void)setupApp{
    //设置api地址
   // [[HttpClient client] setHttpBaseUrl:[AppConstants apiUrl]];
  //  [WXApi registerApp:[AppConstants wechatAppKey] withDescription:@"wechatMaster"];

  //  [MobClick startWithAppkey:[AppConstants umengAppKey] reportPolicy:BATCH   channelId:@""];
   // [UMFeedback setAppkey:[AppConstants umengAppKey]];

    [self setupTool];
    
  //  [[HUD hud] setupHud];
    
}

- (void)setupTool{
    DDFormatter *formatter = [[DDFormatter alloc] init];
    [[DDASLLogger sharedInstance] setLogFormatter:formatter];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

@end
