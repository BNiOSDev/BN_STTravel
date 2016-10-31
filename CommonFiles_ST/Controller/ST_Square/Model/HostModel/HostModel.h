//
//  HostModel.h
//  ForXiaMen
//
//  Created by dawei che on 2016/10/24.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostModel : NSObject
@property(nonatomic, copy)NSString      *iconUrl;
@property(nonatomic, copy)NSString      *userName;
@property(nonatomic, copy)NSString      *timeAgo;
@property(nonatomic, copy)NSString      *address;
@property(nonatomic, copy)NSString      *content;
@property(nonatomic, copy)NSString      *hostImageUrl;
@property(nonatomic, strong)NSArray<NSString *>            *imageArray;
@property(nonatomic, strong)NSArray<NSString *>            *commentArray;
@end
