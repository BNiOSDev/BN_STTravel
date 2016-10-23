//
//  NSObject+Common.h
//  HappyPenguin
//
//  Created by zhuangyihang on 1/25/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
typedef void (^NSObjectBlock)(void);

@interface NSObject(PoohCommon)

+ (void)runBlockAfterDelay:(dispatch_queue_t)queue delay:(NSTimeInterval)delay block:(NSObjectBlock)block;
+ (void)runBlockAfterDelay:(NSTimeInterval)delay block:(NSObjectBlock)block;
@end
