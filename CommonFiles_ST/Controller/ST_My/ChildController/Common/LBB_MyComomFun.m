//
//  LBB_MyComomFun.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyComomFun.h"

@implementation LBB_MyComomFun

NSString* getNumTitleStr(int num)
{
    NSString *numstr = @"";
    int tmpNum = num;
    
    int wan = num/10000;
    num = num%10000;
    int qian = num/1000;
    num = num%1000;
    int bai = num/100;
    num = num%100;
    int shi = num/10;
    num = num%10;
    
    if (wan > 0) {
        if (bai > 0) {
            numstr = [NSString stringWithFormat:@"%@.%@%@W",@(wan),@(qian),@(bai)];
        }else if(qian > 0){
            numstr = [NSString stringWithFormat:@"%@.%@W",@(wan),@(qian)];
        }else {
            numstr = [NSString stringWithFormat:@"%@",@(wan)];
        }
    }
    else if (qian > 0) {
        if (shi > 0) {
            numstr = [NSString stringWithFormat:@"%@.%@%@K",@(qian),@(bai),@(shi)];
        }else if(bai > 0){
            numstr = [NSString stringWithFormat:@"%@.%@K",@(qian),@(bai)];
        }else {
            numstr = [NSString stringWithFormat:@"%@K",@(qian)];
        }
        
    }else {
        numstr = [NSString stringWithFormat:@"%@",@(tmpNum)];
    }
    return numstr;
}

@end
