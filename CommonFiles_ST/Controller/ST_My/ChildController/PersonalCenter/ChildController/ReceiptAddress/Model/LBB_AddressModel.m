//
//  LBB_AddressModel.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddressModel.h"
#import "LBB_LoginManager.h"

@implementation LBB_AddressModel

/**
 3.5.33 我的-收货地址修改/保存
 */
- (void)updateAddress
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/address/update",BASEURL];
    
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                                     @"name":self.name,
                                                                                     @"phone":self.phone,
                                                                                     @"provinceId":@(self.provinceId),
                                                                                     @"cityId":@(self.cityId),
                                                                                     @"districtId":@(self.districtId),
                                                                                     @"address":self.address,
                                                                                     @"zipcode":self.zipcode
                                                                                     }];
    if (self.addressId) {
        [parames setObject:@(self.addressId) forKey:@"addressId"];
    }
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.5.34 我的-收货地址设置默认（已测）
 */

- (void)setDefaultAddress
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/address/default/update",BASEURL];
    
    NSDictionary *parames = @{@"addressId" : @(self.addressId)};;

    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] POST:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

/**
 3.5.35 我的-收货地址删除（已测）
 */
- (void)deleteAddress
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/address/delete",BASEURL];
    
    NSDictionary *parames = @{@"addressId" : @(self.addressId)};;
    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadEvent = NetLoadFailedEvent;
    }];
}

@end


@implementation LBB_AddressViewModel


- (id)init
{
    self = [super init];
    if (self) {
        self.addressArray = [[NSMutableArray alloc] initFromNet];
    }
    return self;
}

- (void)getAddressList:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/address/list",BASEURL];
    
    int curPage = isClear == YES ? 0 : floor(self.addressArray.count/10.0);

    NSDictionary *parames = @{
                              @"curPage":[NSNumber numberWithInt:curPage],
                              @"pageNum":[NSNumber numberWithInt:10],
                              };

    
    __weak typeof(self) weakSelf = self;
    [[BC_ToolRequest sharedManager] GET:url parameters:parames success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSNumber *codeNumber = [dic objectForKey:@"code"];
        NSString *remark = [dic objectForKey:@"remark"];
        NSLog(@"responseObject = %@",responseObject);
        if(codeNumber.intValue == 0)
        {
            NSArray *array = [dic objectForKey:@"rows"];
            NSArray *returnArray = [LBB_AddressModel mj_objectArrayWithKeyValuesArray:array];
            if (isClear) {
              [weakSelf.addressArray removeAllObjects];
            }
            for (LBB_AddressModel *result in returnArray) {
                BOOL isExit = NO;
                for (int i = 0; i < weakSelf.addressArray.count; i++) {
                    LBB_AddressModel *orignModel = weakSelf.addressArray[i];
                    if (orignModel.addressId == result.addressId) {
                        [weakSelf.addressArray replaceObjectAtIndex:i withObject:result];
                        isExit = YES;
                        break;
                    }
                }
                
                if (!isExit) {
                    [weakSelf.addressArray addObject:result];
                }
            }
            weakSelf.addressArray.networkTotal = [dic objectForKey:@"total"];
            weakSelf.addressArray.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.addressArray.loadSupport.netRemark = remark;
            weakSelf.addressArray.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        weakSelf.addressArray.networkTotal = [dic objectForKey:@"total"];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadFailEvent = NetLoadFailedEvent;
    }];
    
}

@end

