//
//  AppDelegate.m
//  ST_Travel
//
//  Created by newman on 16/9/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreData+MagicalRecord.h"
#import "LBB_LoginManager.h"
#import "WXApi.h"
#import <UMSocialCore/UMSocialCore.h>
#import "SPKitExample.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [[LBB_LoginManager shareInstance] weiXinRegisterApp];
    self.window.backgroundColor = ColorWhite;
    //向微信注册wxd930ea5d5a258f4f
//    [WXApi registerApp:@"wx94b0ac5b1ba8e1c3" withDescription:@"demo 2.0"];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx94b0ac5b1ba8e1c3" appSecret:@"1ef86c4ca4dcbe00b93064c4186bda4b" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105843602"  appSecret:@"b6NYFS4PEqyI7vh2" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"4151346704"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // YWSDK快速接入接口，程序启动后调用这个接口
    [[SPKitExample sharedInstance] callThisInDidFinishLaunching];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([LBB_LoginManager shareInstance].loginType == eLoginQQ) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return  [WXApi handleOpenURL:url delegate:[LBB_LoginManager shareInstance]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([LBB_LoginManager shareInstance].loginType == eLoginQQ) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return [WXApi handleOpenURL:url delegate:[LBB_LoginManager shareInstance]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
