//
//  CommonFunc.m
//  LUBABA
//
//  Created by 晨曦 on 16/10/14.
//  Copyright © 2016年 晨曦. All rights reserved.
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


/**
 *	@brief	计算字符串size
 *
 *	@param 	str 	字符串
 *	@param 	constranedSize 	限制size
 *	@param 	font 	字体
 *
 *	@return	字符串size
 */
CGSize sizeOfString(NSString *str, CGSize constranedSize, UIFont *font)
{
    if (constranedSize.width && constranedSize.height) {
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        CGSize size = [str boundingRectWithSize:constranedSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes context:nil].size;
        
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        
        return size;
    } else {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        CGSize size = [str sizeWithAttributes:attributes];
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        
        return size;
    }
}

/**
 *	@brief	计算字符串size
 *
 *	@param 	str 	字符串
 *	@param 	constranedSize 	限制size
 *	@param 	font 	字体
 *
 *	@return	字符串size
 */
CGSize sizeOfStringByWordWrapping(NSString *str, CGSize constranedSize, UIFont *font)
{
    if (constranedSize.width && constranedSize.height) {
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        CGSize size = [str boundingRectWithSize:constranedSize
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes context:nil].size;
        
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        
        return size;
    } else {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        CGSize size = [str sizeWithAttributes:attributes];
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        
        return size;
    }
}


@end
