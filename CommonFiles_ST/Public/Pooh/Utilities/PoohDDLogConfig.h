//
//  PoohDDLogConfig.h
//
//
//  Created by Pooh on 1/25/16.
//  Copyright © 2016 Pooh. All rights reserved.
//

#ifndef PoohDDLogConfig_h
#define PoohDDLogConfig_h

#if DEBUG
static const NSUInteger LOG_LEVEL_DEF = DDLogLevelAll;
//static const NSUInteger LOG_LEVEL_DEF = DDLogLevelAll;
static const NSUInteger HTTP_REQUEST_NUM = 15;

#else

static const NSUInteger LOG_LEVEL_DEF = DDLogLevelOff;
static const NSUInteger HTTP_REQUEST_NUM = 15;

#endif

#endif /* PoohDDLogConfig_h */
