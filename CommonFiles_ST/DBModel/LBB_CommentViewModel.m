//
//  LBB_CommentViewModel.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_CommentViewModel.h"

@implementation LBB_CommentViewModel


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
               block:(void (^)(NSDictionary*dic, NSError *error))block
{
    __weak typeof(self) temp = self;
    __weak NSString *block_remark = remark;
    [[BC_ToolRequest sharedManager] uploadfile:images block:^(NSArray *files, NSError *error) {
        
        NSMutableArray *imageArray = (NSMutableArray *)[files map:^id(NSString *element) {
            
            NSDictionary* dic = @{@"imageUrl":element,
                                  @"imageDesc":@""};
            return dic;
        }];
        
        NSLog(@"commentObjId imageArray:%@",imageArray);
        
        NSDictionary *paraDic = @{
                                  @"objId":@(objId),
                                  @"type":@(type),
                                  @"scores":@(scores),
                                  @"remark":remark,
                                  @"images":imageArray,
                                  @"parentId":@(parentId),
                                  };
        NSLog(@"commentObjId paraDic:%@",paraDic);

        NSString *url = [NSString stringWithFormat:@"%@/homePage/scienicSpots/comment",BASEURL];
        __weak typeof(self) temp = self;
        [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
            NSDictionary *dic = responseObject;
            NSNumber *codeNumber = [dic objectForKey:@"code"];
            if(codeNumber.intValue == 0)
            {
                block([dic objectForKey:@"result"],nil);
            }
            else
            {
                NSString *errorStr = [dic objectForKey:@"remark"];
                block(nil,[NSError errorWithDomain:errorStr
                                          code:codeNumber.intValue
                                      userInfo:nil]);
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            block(nil,error);
        }];
    }];
}

@end
