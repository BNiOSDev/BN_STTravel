//
//  LBB_DiscoveryMainModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_DiscoveryMainModel : NSObject

@property(nonatomic, retain)NSURL* imageUrl;
@property(nonatomic, retain)NSString* title;
@property(nonatomic, retain)NSString* content;
@property(nonatomic, retain)NSString* time;
@property(nonatomic, assign)NSInteger greatNum;
@property(nonatomic, assign)NSInteger commentsNum;



@end
