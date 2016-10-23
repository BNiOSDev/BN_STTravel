//
//  ZJMHostModel.h
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PraiseModel.h"
#import "CommentModel.h"

@interface ZJMHostModel : NSObject

@property(nonatomic, copy)NSString      *iconUrl;
@property(nonatomic, copy)NSString      *userName;
@property(nonatomic, copy)NSString      *timeAgo;
@property(nonatomic, copy)NSString      *address;
@property(nonatomic, copy)NSString      *content;
@property(nonatomic, copy)NSString      *hostImageUrl;
@property(nonatomic, strong)NSArray<PraiseModel *>      *praiseModelArray;
@property(nonatomic, strong)NSArray<CommentModel *>      *commentModelArray;
@property(nonatomic, strong)NSArray<NSString *>            *imageArray;
//@property(nonatomic, copy)NSString
//@property(nonatomic, copy)NSString

@end
