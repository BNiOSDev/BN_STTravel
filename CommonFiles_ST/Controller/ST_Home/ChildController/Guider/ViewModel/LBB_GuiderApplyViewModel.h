//
//  LBB_GuiderApplyViewModel.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LBB_GuiderApplyTagsObject : BN_BaseDataModel

@property(nonatomic, assign)long tagId;//	Long	标签ID
@property(nonatomic, strong)NSString* tagName;//	String	标签名称
@end


@interface LBB_GuiderApplyObject : BN_BaseDataModel

@property(nonatomic, strong)NSString* realName;//	String	真实姓名
@property(nonatomic, strong)NSString* idCard;//	String	身份证号
@property(nonatomic, strong)NSString* tourIdCard;//	String	导游证号码
@property(nonatomic, strong)NSString* tourStartTime;//	String	从业时间yyyy-MM-dd
@property(nonatomic, assign)int genderKey;//	int	性别key
@property(nonatomic, strong)NSString* phoneNum;//	String	联系电话
@property(nonatomic, strong)NSString* tourAWords;//	String	一句话介绍
@property(nonatomic, strong)NSString* tourDetails;//	String	详情介绍
@property(nonatomic, strong)NSMutableArray<LBB_GuiderApplyTagsObject*>* auditTags;//	List	认证标签
@property(nonatomic, strong)NSString* idCardFrontUrl;//	String	身份证正面照片URL
@property(nonatomic, strong)NSString* idCardBackUrl;//	String	身份证反面照片URL
@property(nonatomic, strong)NSString* tourPicUrl;//	String	导游证照片
@property(nonatomic, strong)NSString* otherCertificateUrl;//	String	其他证件照片

@end


@interface LBB_GuiderAuditResultObject : BN_BaseDataModel

@property(nonatomic, assign)int tourAuditState;//	Int	0  未提交实名认证 1  已提交实名认证，正在审核 2、认证成功 3、认证失败
@property(nonatomic, strong)NSString* tourAuditReason;//	String	驳回理由

@end

@interface LBB_GuiderApplyViewModel : BN_BaseDataModel

@property(nonatomic, strong)LBB_GuiderApplyObject* applyObject;

@property(nonatomic, strong)LBB_GuiderAuditResultObject* applyResult;

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
          error:(void (^)(NSError *error))errorBlock;




/**
 3.7.9 导游 –认证结果（已测）

 @param block 回调
 */
-(void)getTourAuditResult:(void (^)(NSError *error))block;


/**
  3.7.8 导游 –编辑页面

 @param succBlock  succ block 回调
 @param faileBlock faile block 回调
 @param errorBlock errlo block 回调
 */
-(void)getTourAuditStatus:(void(^)(LBB_GuiderApplyObject* applyObject))succBlock
                    faile:(void(^)(LBB_GuiderAuditResultObject* resultObject))faileBlock
                    error:(void (^)(NSError *error))errorBlock;

@end
