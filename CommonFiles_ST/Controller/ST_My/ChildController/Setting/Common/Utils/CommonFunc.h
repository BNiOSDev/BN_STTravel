//
//  CommonFunc.h
//  LUBABA
//
//  Created by 晨曦 on 16/10/14.
//  Copyright © 2016年 晨曦. All rights reserved.
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


/**
 *	@brief	计算字符串size
 *
 *	@param 	str 	字符串
 *	@param 	constranedSize 	限制size
 *	@param 	font 	字体
 *
 *	@return	字符串size
 */
CGSize sizeOfString(NSString *str, CGSize constranedSize, UIFont *font);

/**
 *	@brief	计算字符串size
 *
 *	@param 	str 	字符串
 *	@param 	constranedSize 	限制size
 *	@param 	font 	字体
 *
 *	@return	字符串size
 */
CGSize sizeOfStringByWordWrapping(NSString *str, CGSize constranedSize, UIFont *font);


@end
