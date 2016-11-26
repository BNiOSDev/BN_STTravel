//
//  LBB_PublishUgcViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PublishUgcViewModel.h"

@implementation BN_PublicPics



@end

@implementation LBB_PublishUgcViewModel

/**
     3.4.15 广场-广场主页-图片/视频发布（已测）
     
     @param type           int	1.照片 2.视频
     @param url            String	封面视频或图片地址
     @param remark         String	备注
     @param longitude      String	Y坐标
     @param dimensionality String	Y坐标
     @param allSpotsId     Long	关联场景
     @param tags           List	视频标签  @[ @"1",@"1",@"1",@"1",  ]
     参数字段	类型     说明
     tagId	Long	标签ID
     @param pics           List	图片集合(可为空) @[ @{
     @"imageUrl":图片地址
     @"imageDesc":图片描述
     @"tags":标签}
     ]
     参数字段   	类型     说明
     imageUrl	String	图片地址
     imageDesc	String	图片描述
     tags       List	标签
 */
-(void)setSquareUgc:(int)type
                url:(NSString*)url
             remark:(NSString*)remark
          longitude:(NSString*)longitude
     dimensionality:(NSString*)dimensionality
         allSpotsId:(long)allSpotsId
               tags:(NSMutableArray<NSNumber*>*)tags
               pics:(NSMutableArray<BN_PublicPics*>*)pics
              block:(void (^)(NSError *error))block{

    NSMutableArray *tagsArray = (NSMutableArray *)[tags map:^id(NSNumber *element) {
        
        NSDictionary* dic = @{@"tagId":element};
        return dic;
    }];
    
    NSLog(@"tagsArray:%@",tagsArray);
    
    NSMutableArray *picsArray = (NSMutableArray *)[pics map:^id(BN_PublicPics *element) {
        
        
        NSMutableArray *tagsArray = (NSMutableArray *)[element.tags map:^id(NSNumber *element) {
            
            NSDictionary* dic = @{@"tagId":element};
            return dic;
        }];
        
        NSDictionary* dic = @{
                              @"imageUrl":element.imageUrl,
                              @"imageDesc":element.imageDesc,
                              @"tags":element.tags//tagsArray,

                              };
        return dic;
    }];
    
    NSLog(@"picsArray:%@",picsArray);

    NSDictionary *paraDic = @{
                              @"type":@(type),
                              @"url":url,
                              @"remark":remark,
                              @"longitude":longitude,
                              @"dimensionality":dimensionality,
                              @"allSpotsId":@(allSpotsId),
                              @"tags":tags,//tagsArray,
                              @"pics":picsArray,

                              };
    NSLog(@"paraDic:%@",paraDic);

    NSString *postUrl = [NSString stringWithFormat:@"%@/square/ugc/save",BASEURL];
   // __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] POST:postUrl parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"setSquareUgc成功:%d",[codeNumber intValue]);
            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"setSquareUgc失败:%d errorStr:%@",[codeNumber intValue],errorStr);

            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"setSquareUgc失败 error :%@ ",error.domain);
        block(error);
    }];
    
}


#pragma test func

/*
 LBB_PublishUgcViewModel* model = [[LBB_PublishUgcViewModel alloc]init];
 
 NSMutableArray* arr = [NSMutableArray new];
 NSMutableArray* tagsArr = [NSMutableArray arrayWithObjects:@1,@2,@3, nil];
 for (int i = 0; i<3; i++) {
 BN_PublicPics* pic = [[BN_PublicPics alloc] init];
 pic.imageUrl = @"http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg";
 pic.imageDesc = @"照片描述";
 pic.tags = tagsArr;
 [arr addObject:pic];
 }
 [model setSquareUgc:1 url:@"http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg" remark:@"标注啦" longitude:@"-1" dimensionality:@"-1" allSpotsId:0 tags:tagsArr pics:arr block:^(NSError* error){
 
 }];
 */

@end
