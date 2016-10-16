//
//  QJTL_Utils.h
//  ShiJuRenClient
//
//  Created by xuwk on 15/12/14.
//  Copyright © 2015年 qijuntonglian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base_Utils : NSObject

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;
 
#pragma 获取对应路径文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath;
#pragma 获取对应路径文件夹大小
+ (CGFloat) folderSizeAtPath:(NSString *)folderPath;

@end
