//
//  LBB_LocalSearchRecordManager.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LocalSearchRecordManager.h"
@implementation LBB_LocalSearchRecordManager
/*
+(LBB_LocalSearchRecordManager*) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
*/
-(id)init
{
    self = [super init];
    if(self){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *database_path = [documents stringByAppendingPathComponent:@"LBB_LocalSearchRecord.db"];
        NSLog(@"database_path:%@",database_path);
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:database_path];
        [self createTable];
    }
    return self;
}


/*******************************************************************************************
 *
 *   数据库操作
 *
 *******************************************************************************************/
#pragma arguments 查询数据库表是否存在
- (BOOL)isTableExist:(NSString *)tableName
{
    __block  BOOL isExist = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
        while ([rs next])
        {
            // just print out what we've got in a number of formats.
            NSInteger count = [rs intForColumn:@"count"];
            NSLog(@"isTableExist %ld", count);
            if (0 == count)
            {
                isExist = NO;
            }
            else
            {
                isExist = YES;
            }
        }
        [rs close];
    }];
    return isExist;
}


//创建本地数据库表
- (void)createTable {
    
    // [self dropTable:@"LBB_LocalSearchRecordTable"]; //先删除表格，在新建
    if (![self isTableExist:@"LBB_LocalSearchRecordTable"]) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            
            NSString * sql = @"CREATE TABLE 'LBB_LocalSearchRecordTable' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'key_word' TEXT)";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating LBB_LocalSearchRecordTable");
            } else {
                NSLog(@"succ to creating LBB_LocalSearchRecordTable");
            }
        }];
    }
}


//查询关键字信息是否在数据库
- (BOOL)isKeyWordExist:(NSString*)keyWord{
    __block BOOL isExist = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sql = [NSString stringWithFormat:@"select * from LBB_LocalSearchRecordTable where key_word = '%@'",keyWord];
        FMResultSet * rs = [db executeQuery:sql];
        
        if ([rs next]) {//查询到数据
            isExist = YES;
        }
        else{
            isExist = NO;
        }
        [rs close];
    }];
    return isExist;
}

//插入关键字数据数据到sqlite
- (void)insertKeyWord:(NSString*)keyWord{
    
    if ([self isKeyWordExist:keyWord]) {//如果数据在数据库了，不做处理
    }
    
    else{//否则插入数据
        
        if (keyWord.length > 0) {
            [self.dbQueue inDatabase:^(FMDatabase *db) {
                NSString * sql = @"insert into LBB_LocalSearchRecordTable (key_word) values(?)";
                BOOL res = [db executeUpdate:sql, keyWord];
                if (!res) {
                    NSLog(@"error to insert data into LBB_LocalSearchRecordTable:%@",keyWord);
                } else {
                    NSLog(@"succ to insert data into LBB_LocalSearchRecordTable:%@",keyWord);
                }
            }];
        }
    }
}
//查询关键字列表
- (void)queryKeyWordList{
    WS(ws);
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString * sql = [NSString stringWithFormat:@"select * from LBB_LocalSearchRecordTable"];
        FMResultSet * rs = [db executeQuery:sql];
        NSMutableArray* array = [NSMutableArray array];
        while([rs next]) {
            NSString* keyWord = [rs stringForColumn:@"key_word"];

            [array addObject:keyWord];
        }
        [rs close];
        ws.resBlock(array);//回调查询到的数据
    }];
}

//删除数据
- (void)deleteKeyWord:(NSString*)keyWord{
    WS(ws);
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString* sql = [NSString stringWithFormat:@"delete from LBB_LocalSearchRecordTable where key_word = '%@'",keyWord];
        
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete data into LBB_LocalSearchRecordTable:%@",keyWord);
            ws.deleteBlock(nil);//删除失败
        } else {
            NSLog(@"succ to delete data into LBB_LocalSearchRecordTable:%@",keyWord);
            ws.deleteBlock(keyWord);//删除成功
        }
    }];
}
- (void)deleteKeyWordList{
    WS(ws);
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString* sql = [NSString stringWithFormat:@"delete from LBB_LocalSearchRecordTable"];
        
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete data into LBB_LocalSearchRecordTable");
            ws.deleteBlock(nil);//删除失败
        } else {
            NSLog(@"succ to delete data into LBB_LocalSearchRecordTable");
            ws.deleteBlock(@"success");//删除成功
        }
    }];
}


@end
