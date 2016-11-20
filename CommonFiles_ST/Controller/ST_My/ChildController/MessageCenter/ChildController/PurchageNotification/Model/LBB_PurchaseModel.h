//
//  LBB_PurchaseModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_PurchaseModel : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *imageURL;
@property(nonatomic,copy) NSString *dateStr;
@property(nonatomic,copy) NSString *content;

@end


@interface LBB_PurchaseDataModel : NSObject

- (NSMutableArray<LBB_PurchaseModel*>*)getData;

@end
