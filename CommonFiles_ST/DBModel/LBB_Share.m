//
//  LBB_Share.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Share.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface LBB_Share()
{
    NSString *title;
    NSString *url;//@"http://wsq.umeng.com";
    NSString *text;
    UIImage *image;
    UIViewController *vvv;
}
@end

@implementation LBB_Share

static LBB_Share *share = nil;

+(LBB_Share *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[LBB_Share alloc]init];
    });
    return share;
}

- (void)shareTitle:(NSString*)tit url:(NSString*)u text:(NSString*)tex image:(UIImage*)imag viewController:(UIViewController*)viewController {
    
    title = tit;
    url = u;
    text = tex;
    image = imag;
    vvv = viewController;
    
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [weakSelf shareDataWithPlatform:platformType];
    }];
}

- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType
{
    // 创建UMSocialMessageObject实例进行分享
    // 分享数据对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    /* 以下分享类型，开发者可根据需求调用 */
    // 1、纯文本分享
    messageObject.text = text;
    
    // 2、 图片或图文分享
    // 图片分享参数可设置URL、NSData类型
    // 注意：由于iOS系统限制(iOS9+)，非HTTPS的URL图片可能会分享失败
    //    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:text thumImage:image];
    //    [shareObject setShareImage:image];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:image];
    [shareObject setWebpageUrl:url];
    
    
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vvv completion:^(id data, NSError *error) {
        
        NSString *message = nil;
        if (!error) {
        }
  
    }];
}

@end
