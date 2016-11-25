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

- (void)getAddressList:(int)curPage PageNum:(int)pageNum IsClear:(BOOL)isClear
{
    NSString *url = [NSString stringWithFormat:@"%@/mime/address/list",BASEURL];
    
    NSMutableDictionary *parames = [[NSMutableDictionary alloc] init];
    [parames setObject:[NSNumber numberWithInt:curPage] forKey:@"curPage"];
    [parames setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    
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
            [weakSelf.addressArray addObjectsFromArray:returnArray];
            weakSelf.loadSupport.loadEvent = codeNumber.intValue;
        }else{
            weakSelf.loadSupport.netRemark = remark;
            weakSelf.loadSupport.loadFailEvent = codeNumber.intValue;
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        weakSelf.loadSupport.loadFailEvent = NetLoadFailedEvent;
    }];
    
}

@end

