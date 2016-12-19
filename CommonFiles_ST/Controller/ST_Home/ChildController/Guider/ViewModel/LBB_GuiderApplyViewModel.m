//
//  LBB_GuiderApplyViewModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderApplyViewModel.h"

@implementation LBB_GuiderApplyTagsObject


@end

@implementation LBB_GuiderApplyObject

-(id)init{
    
    if (self = [super init]) {
        self.auditTags = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

-(void)setAuditTags:(NSMutableArray<LBB_GuiderApplyTagsObject *> *)auditTags{
    NSMutableArray *array = (NSMutableArray *)[auditTags map:^id(NSDictionary *element) {
        return [LBB_GuiderApplyTagsObject mj_objectWithKeyValues:element];
    }];
    _auditTags = array;
}

@end

@implementation LBB_GuiderAuditResultObject

-(id)init{
    
    if (self = [super init]) {
        self.tourAuditReason = @"";
    }
    return self;
}


@end

@implementation LBB_GuiderApplyViewModel

-(id)init{
    
    if (self = [super init]) {
        self.applyObject = [[LBB_GuiderApplyObject alloc] init];
        self.applyResult = [[LBB_GuiderAuditResultObject alloc] init];
    }
    return self;
}


 /**
 3.7.7 导游 –申请（已测）
 
 @param idCardFrontImage      身份证正面照片
 @param idCardBackImage       身份证反面照片
 @param tourPicImage          导游证照片
 @param otherCertificateImage 其他证件照片
 @param block                 回调
 */
-(void)saveTour:(UIImage*)idCardFrontImage
idCardBackImage:(UIImage*)idCardBackImage
   tourPicImage:(UIImage*)tourPicImage
otherCertificateImage:(UIImage*)otherCertificateImage
          block:(void (^)(NSError *error))block{

    
    NSMutableArray *tagsArray = (NSMutableArray *)[self.applyObject.auditTags map:^id(LBB_GuiderApplyTagsObject *element) {
        
        NSDictionary* dic = @{@"tagId":@(element.tagId)};
        return dic;
    }];

    
    //上传身份证正面照片
    [[BC_ToolRequest sharedManager] uploadfile:@[idCardFrontImage] block:^(NSArray *files, NSError *error) {
        
        if (error) {
            return;
        }
        self.applyObject.idCardFrontUrl = [files firstObject];
        if (!self.applyObject.idCardFrontUrl || [self.applyObject.idCardFrontUrl length] == 0) {
            return;
        }
        else{
            NSLog(@"saveTour上传身份证正面照片 成功");
            //上传身份证反面照片
            [[BC_ToolRequest sharedManager] uploadfile:@[idCardBackImage] block:^(NSArray *files, NSError *error) {
                if (error) {
                    return;
                }
                self.applyObject.idCardBackUrl = [files firstObject];
                if (!self.applyObject.idCardBackUrl || [self.applyObject.idCardBackUrl length] == 0) {
                    return;
                }
                else{
                    NSLog(@"saveTour上传身份证反面照片 成功");
                    //导游证照片
                    [[BC_ToolRequest sharedManager] uploadfile:@[tourPicImage] block:^(NSArray *files, NSError *error) {
                        if (error) {
                            return;
                        }
                        self.applyObject.tourPicUrl = [files firstObject];
                        if (!self.applyObject.tourPicUrl || [self.applyObject.tourPicUrl length] == 0) {
                            return;
                        }
                        else{
                            NSLog(@"saveTour上传导游证照片 成功");
                            NSArray* uploadImageArray = @[];
                            if (otherCertificateImage) {
                                uploadImageArray = @[otherCertificateImage] ;
                            }
                            //其他证件照片
                            [[BC_ToolRequest sharedManager] uploadfile:uploadImageArray block:^(NSArray *files, NSError *error) {
                                
                                if (error) {
                                    return;
                                }
                                
                                if (files.count <= 0) {
                                    self.applyObject.otherCertificateUrl = @"";
                                }
                                else{
                                    self.applyObject.otherCertificateUrl = [files firstObject];
                                }
                 
                                NSLog(@"saveTour上传其他证件照片 成功");
                                
                                NSDictionary *paraDic = @{
                                                          @"realName"           :self.applyObject.realName,//真实姓名
                                                          @"idCard"             :self.applyObject.idCard,//身份证号
                                                          @"tourIdCard"         :self.applyObject.tourIdCard,//导游证号码
                                                          @"tourStartTime"      :self.applyObject.tourStartTime,//从业时间yyyy-MM-dd
                                                          @"genderKey"          :@(self.applyObject.genderKey),//性别key
                                                          @"phoneNum"           :self.applyObject.phoneNum,//联系电话
                                                          @"tourAWords"         :self.applyObject.tourAWords,//一句话介绍
                                                          @"tourDetails"        :self.applyObject.tourDetails,//详情介绍
                                                          @"auditTags"          :tagsArray,//认证标签
                                                          @"idCardFrontUrl"     :self.applyObject.idCardFrontUrl,//身份证正面照片URL
                                                          @"idCardBackUrl"      :self.applyObject.idCardBackUrl,//身份证反面照片URL
                                                          @"tourPicUrl"         :self.applyObject.tourPicUrl,//导游证照片
                                                          @"otherCertificateUrl":self.applyObject.otherCertificateUrl//其他证件照片
                                                          };
                                NSLog(@"saveTour paraDic:%@",paraDic);
                                
                                NSString *postUrl = [NSString stringWithFormat:@"%@/tour/save",BASEURL];
                                // __weak typeof(self) temp = self;
                                [[BC_ToolRequest sharedManager] POST:postUrl parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
                                    NSDictionary *dic = responseObject;
                                    NSNumber *codeNumber = [dic objectForKey:@"code"];
                                    if(codeNumber.intValue == 0)
                                    {
                                        NSLog(@"saveTour成功:%d",[codeNumber intValue]);
                                        block(nil);
                                    }
                                    else
                                    {
                                        NSString *errorStr = [dic objectForKey:@"remark"];
                                        NSDictionary *result = [dic objectForKey:@"result"];
                                        errorStr = [result objectForKey:@"auditMessage"];
                                        NSLog(@"saveTour失败:%d errorStr:%@",[codeNumber intValue],errorStr);
                                        
                                        block([NSError errorWithDomain:errorStr
                                                                  code:codeNumber.intValue
                                                              userInfo:nil]);
                                    }
                                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                    NSLog(@"saveTour失败 error :%@ ",error.domain);
                                    block(error);
                                }];
                                
                            }];
                        
                        }
                    }];
                
                }
            
            }];
        }
    }];
}

/**
 3.7.9 导游 –认证结果（已测）
 
 @param block 回调
 */
-(void)getTourAuditResult:(void (^)(NSError *error))block{

    __weak typeof(self) temp = self;
    NSString *postUrl = [NSString stringWithFormat:@"%@/tour/auditResult",BASEURL];
    // __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] GET:postUrl parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            temp.applyResult = [LBB_GuiderAuditResultObject mj_objectWithKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTourAuditResult成功:%d result:%@",[codeNumber intValue],dic);

            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTourAuditResult失败:%d errorStr:%@",[codeNumber intValue],errorStr);
            
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTourAuditResult失败 error :%@ ",error.domain);
        block(error);
    }];
}

@end
