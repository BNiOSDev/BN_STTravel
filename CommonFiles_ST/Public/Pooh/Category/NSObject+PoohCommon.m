//
//  NSObject+Common.m
//  HappyPenguin
//
//  Created by zhuangyihang on 1/25/16.
//  Copyright © 2016 zhuangyihang. All rights reserved.
//

#import "NSObject+PoohCommon.h"

@implementation NSObject(PoohCommon)

+ (void)runBlockAfterDelay:(NSTimeInterval)delay block:(NSObjectBlock)block{
    [NSObject runBlockAfterDelay:dispatch_get_main_queue() delay:delay block:block];
}

+ (void)runBlockAfterDelay:(dispatch_queue_t)queue delay:(NSTimeInterval)delay block:(NSObjectBlock)block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay),
                   queue, block);
}

@end
