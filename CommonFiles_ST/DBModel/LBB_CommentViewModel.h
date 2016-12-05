//
//  LBB_CommentViewModel.h
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LBB_CommentViewModel : NSObject

/**
 3.1.10	评论(已测)
 
 @param objId 场景ID
 @param type 1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题
 @param scores 采用100分制，20分一颗星，100分5颗星
 @param remark 评论备注
 @param images 图片集合
 @param parentId 父评论
 @param block 回调
 */
+ (void)commentObjId:(long)objId
                type:(int)type
              scores:(int)scores
              remark:(NSString*)remark
              images:(NSArray<UIImage*>*)images
            parentId:(long)parentId
               block:(void (^)(NSDictionary*dic, NSError *error))block;

@end
