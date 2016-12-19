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



@interface LBB_GuiderApplyViewModel : BN_BaseDataModel

@property(nonatomic, strong)LBB_GuiderApplyObject* applyObject;

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
          block:(void (^)(NSError *error))block;

@end
