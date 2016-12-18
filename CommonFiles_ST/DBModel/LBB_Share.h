//
//  LBB_Share.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_Share : NSObject

+(LBB_Share *)sharedManager;

- (void)shareTitle:(NSString*)tit url:(NSString*)u text:(NSString*)tex image:(UIImage*)imag viewController:(UIViewController*)viewController;

@end
