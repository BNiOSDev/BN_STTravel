//
//  LBB_LocalSearchRecordManager.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PoohCommon.h"

@interface LBB_LocalSearchRecordManager : NSObject

@property(nonatomic,strong) FMDatabaseQueue *dbQueue;
//+(LBB_LocalSearchRecordManager*) sharedInstance;

@property(nonatomic,strong)ClickBlock resBlock;
@property(nonatomic,strong)ClickBlock deleteBlock;

//查询关键字信息是否在数据库
- (BOOL)isKeyWordExist:(NSString*)keyWord ;

//插入关键字数据数据到sqlite
- (void)insertKeyWord:(NSString*)keyWord ;

//查询关键字列表
- (void)queryKeyWordList;

//删除数据
- (void)deleteKeyWord:(NSString*)keyWord;
- (void)deleteKeyWordList;



@end
