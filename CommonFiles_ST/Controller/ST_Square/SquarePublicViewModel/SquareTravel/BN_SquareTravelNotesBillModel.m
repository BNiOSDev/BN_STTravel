//
//  BN_SquareTravelNotesBillModel.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "BN_SquareTravelNotesBillModel.h"

/**
 消费比例
 */
@implementation BN_SquareTravelNotesConsumeRatios


@end


/**
 消费明细
 */
@implementation BN_SquareTravelNotesconsumeDetails

/**
 3.4.19 主页-游记消费编辑（已测）
 */
-(void)modifySquareTravelNotesConsumeDetails:(void (^)(NSError *error))block{

    NSDictionary *paraDic = @{
                              @"consumeDetailId":@(self.consumeDetailId),
                              @"consumptionType":@(self.consumptionType),
                              @"consumptionDesc":self.consumptionDesc,
                              @"amount":@([self.amount doubleValue]),

                              };
    NSLog(@"paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/consume/update",BASEURL];
    [[BC_ToolRequest sharedManager] POST:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"modifySquareTravelNotesConsumeDetails 成功");

            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"modifySquareTravelNotesConsumeDetails errorStr : %@",errorStr);
            
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"modifySquareTravelNotesConsumeDetails 失败 : %@",error.domain);
        
        block(error);

    }];
    
}

/**
 3.4.20 主页-游记消费删除（已测）
 
 @param block 操作回调
 */
-(void)deleteSquareTravelNotesConsumeDetails:(void (^)(NSError *error))block{
    
    NSDictionary *paraDic = @{
                              @"consumeDetailId":@(self.consumeDetailId),
                              };
    NSLog(@"paraDic:%@",paraDic);
    NSString *url = [NSString stringWithFormat:@"%@/square/travelNotes/consume/delete",BASEURL];
    __weak typeof(self) temp = self;

    [[BC_ToolRequest sharedManager] GET:url parameters:paraDic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        if(codeNumber.intValue == 0)
        {
            NSLog(@"deleteSquareTravelNotesConsumeDetails 成功");
            NSLog(@"deleteSquareTravelNotesConsumeDetails before:%lu",(unsigned long)temp.parentArray.count);
            [temp.parentArray removeObject:temp];
            NSLog(@"deleteSquareTravelNotesConsumeDetails 成功:%lu",(unsigned long)temp.parentArray.count);
            block(nil);
        }
        else
        {
            NSString *errorStr = [dic objectForKey:@"remark"];
            NSLog(@"deleteSquareTravelNotesConsumeDetails errorStr : %@",errorStr);
            
            block([NSError errorWithDomain:errorStr
                                      code:codeNumber.intValue
                                  userInfo:nil]);
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"deleteSquareTravelNotesConsumeDetails 失败 : %@",error.domain);
        
        block(error);
        
    }];
    
}

@end

/**
 3.4.18 主页-游记账单（已测）
 */
@implementation BN_SquareTravelNotesBillModel

-(void)setConsumeRatios:(NSMutableArray<BN_SquareTravelNotesConsumeRatios *> *)consumeRatios{

    NSMutableArray *array = [@[] mutableCopy];
    [consumeRatios enumerateObjectsUsingBlock:^(BN_SquareTravelNotesConsumeRatios * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        BN_SquareTravelNotesConsumeRatios *tag = [BN_SquareTravelNotesConsumeRatios mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _consumeRatios = array;
}

-(void)setConsumeDetails:(NSMutableArray<BN_SquareTravelNotesconsumeDetails *> *)consumeDetails{

    NSMutableArray *array = [@[] mutableCopy];
    [consumeDetails enumerateObjectsUsingBlock:^(BN_SquareTravelNotesconsumeDetails * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        BN_SquareTravelNotesconsumeDetails *tag = [BN_SquareTravelNotesconsumeDetails mj_objectWithKeyValues:dic];
        [array addObject:tag];
    }];
    _consumeDetails = array;
}

@end
