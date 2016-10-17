//
//  Director.h
//  HappyPenguin
//
//  Created by zhuangyihang on 12/30/15.
//  Copyright © 2015 zhuangyihang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoohDirector : NSObject

+ (id)sharedInstance;

/**
 *  App全局初始化
 */
- (void)setupApp;



@end
