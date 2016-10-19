//
//  CommonFunc.h
//  LUBABA
//
//  Created by Diana on 16/10/14.
//  Copyright © 2016年 Diana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonFunc : NSObject

/**
 *  获取对应路径文件大小
 *
 *  @param filePath 文件路径
 *
 *  @return 文件大小
 */
long long fileSizeAtPath(NSString *filePath);

/**
 *  获取对应路径文件夹大小
 *
 *  @param folderPath 文件夹路径
 *
 *  @return 文件夹大小（返回以B为单位）
 */
CGFloat folderSizeAtPath(NSString *folderPath);

@end
