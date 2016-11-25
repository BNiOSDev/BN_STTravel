//
//  LBB_PublishUgcViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BN_PublicPics : NSObject

@property(nonatomic, strong)NSString* imageUrl;//图片地址
@property(nonatomic, strong)NSString* imageDesc;//图片描述
@property(nonatomic, strong)NSMutableArray* tags;// List标签   tagId	Long	标签ID

@end



@interface LBB_PublishUgcViewModel : BN_BaseDataModel
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
          longitude:(NSString*)	longitude
     dimensionality:(NSString*)dimensionality
         allSpotsId:(long)allSpotsId
               tags:(NSMutableArray<NSNumber*>*)tags
               pics:(NSMutableArray<BN_PublicPics*>*)pics
              block:(void (^)(NSError *error))block;

@end
