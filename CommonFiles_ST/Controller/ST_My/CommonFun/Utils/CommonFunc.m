//
//  CommonFunc.m
//  LUBABA
//
//  Created by dhxiang on 16/10/14.
//  Copyright © 2016年 dhxiang. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc

/**
 *  获取对应路径文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
long long fileSizeAtPath(NSString *filePath)
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        //        NSDictionary<NSString *, id> *fileDict = [manager attributesOfItemAtPath:filePath error:nil];
        //
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/**
 *  获取对应路径文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 文件夹大小（返回以B为单位）
 */
CGFloat folderSizeAtPath(NSString *folderPath)
{
    NSFileManager* manager = [NSFileManager defaultManager];
    //    BOOL isFileExit = [manager fileExistsAtPath:folderPath];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += fileSizeAtPath(fileAbsolutePath);
    }
    return folderSize;
}


@end
