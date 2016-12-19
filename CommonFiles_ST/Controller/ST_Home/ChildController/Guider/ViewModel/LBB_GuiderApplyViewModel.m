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
        self.realName = @"";//	String	真实姓名
        self.idCard = @"";//	String	身份证号
        self.tourIdCard = @"";//	String	导游证号码
        self.tourStartTime = @"";//	String	从业时间yyyy-MM-dd
        self.genderKey = 1;//	int	性别key
        self.phoneNum = @"";//	String	联系电话
        self.tourAWords = @"";//	String	一句话介绍
        self.tourDetails = @"";//	String	详情介绍
        self.idCardFrontUrl = @"";//	String	身份证正面照片URL
        self.idCardBackUrl = @"";//	String	身份证反面照片URL
        self.tourPicUrl = @"";//	String	导游证照片
        self.otherCertificateUrl = @"";//	String	其他证件照片
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
 @param succBlock                 回调
 @param faileBlock                 回调
 @param errorBlock                 回调
 
 */
-(void)saveTour:(UIImage*)idCardFrontImage
idCardBackImage:(UIImage*)idCardBackImage
   tourPicImage:(UIImage*)tourPicImage
otherCertificateImage:(UIImage*)otherCertificateImage
           succ:(void(^)(LBB_GuiderApplyObject* applyObject))succBlock
          faile:(void(^)(LBB_GuiderAuditResultObject* resultObject))faileBlock
          error:(void (^)(NSError *error))errorBlock{

    
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
                                        NSLog(@"saveTour成功:%d Restlt:%@",[codeNumber intValue],[dic objectForKey:@"result"]);
                                        
                                        succBlock(nil);
                                    }
                                    else
                                    {
                                        NSString *errorStr = [dic objectForKey:@"remark"];
                                        NSLog(@"saveTour失败:%d errorStr:%@",[codeNumber intValue],errorStr);
                                        NSDictionary* result = [dic objectForKey:@"result"];
                                        LBB_GuiderAuditResultObject* resultObject = [[LBB_GuiderAuditResultObject alloc] init];
                                        resultObject.tourAuditState = [[result objectForKey:@"auditState"] intValue];
                                        resultObject.tourAuditReason = [result objectForKey:@"auditMessage"];
                                      //  resultObject = [LBB_GuiderAuditResultObject mj_objectWithKeyValues:[dic objectForKey:@"result"]];
                                        
                                        faileBlock(resultObject);
                                    }
                                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                    NSLog(@"saveTour失败 error :%@ ",error.domain);
                                    errorBlock(error);
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


/**
 3.7.8 导游 –编辑页面
 
 @param succBlock  succ block 回调
 @param faileBlock faile block 回调
 @param errorBlock errlo block 回调
 */
-(void)getTourAuditStatus:(void(^)(LBB_GuiderApplyObject* applyObject))succBlock
                    faile:(void(^)(LBB_GuiderAuditResultObject* resultObject))faileBlock
                    error:(void (^)(NSError *error))errorBlock{

    NSString *postUrl = [NSString stringWithFormat:@"%@/tour/edit",BASEURL];
    // __weak typeof(self) temp = self;
    [[BC_ToolRequest sharedManager] GET:postUrl parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSLog(@"getTourAuditStatus result:%@",dic);

        if(codeNumber.intValue == 0)
        {
            LBB_GuiderApplyObject* applyObject = [[LBB_GuiderApplyObject alloc] init];
            applyObject = [LBB_GuiderApplyObject mj_objectWithKeyValues:[dic objectForKey:@"result"]];
            NSLog(@"getTourAuditStatus成功:%d result:%@",[codeNumber intValue],dic);
            
            succBlock(applyObject);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"getTourAuditStatus失败:%d errorStr:%@",[codeNumber intValue],errorStr);
            
            
            NSDictionary* result = [dic objectForKey:@"result"];
            
            if (!result) {//nil的时候
                errorBlock([NSError errorWithDomain:errorStr
                                          code:codeNumber.intValue
                                      userInfo:nil]);
            }
            else{
                LBB_GuiderAuditResultObject* resultObject = [[LBB_GuiderAuditResultObject alloc] init];
                resultObject.tourAuditState = [[result objectForKey:@"auditState"] intValue];
                resultObject.tourAuditReason = [result objectForKey:@"auditMessage"];
                // resultObject = [LBB_GuiderAuditResultObject mj_objectWithKeyValues:[dic objectForKey:@"result"]];
                faileBlock(resultObject);
            }
 
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"getTourAuditStatus失败 error :%@ ",error.domain);
        errorBlock(error);
    }];

}

@end
