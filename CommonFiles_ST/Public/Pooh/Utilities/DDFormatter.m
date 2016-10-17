//
//  DDFormatter.m
//  Kangaroo
//
//  Created by zhuangyihang on 4/29/15.
//  Copyright (c) 2015 zhuangyihang. All rights reserved.
//

#import "DDFormatter.h"

@interface DDFormatter ()

@end

@implementation DDFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    
    NSString *logLevel = nil;
    switch (logMessage.flag)
    {
        case DDLogFlagError:
            logLevel = @"[ERROR] >  ";
            break;
        case DDLogFlagWarning:
            logLevel = @"[WARN]  >  ";
            break;
        case DDLogFlagInfo:
            logLevel = @"[INFO]  >  ";
            break;
        case DDLogFlagDebug:
            logLevel = @"[DEBUG] >  ";
            break;
        default:
            logLevel = @"[VBOSE] >  ";
            break;
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%@[%@ %@][line %lu] %@",
                           logLevel, logMessage.fileName, logMessage.function,
                           (unsigned long)logMessage.line, logMessage.message];
    return formatStr;
}

@end
