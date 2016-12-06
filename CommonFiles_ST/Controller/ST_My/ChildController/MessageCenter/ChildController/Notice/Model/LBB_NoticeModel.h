//
//  LBB_NoticeModel.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBB_NoticeModel : BN_BaseDataModel

@property(nonatomic,assign) long noticesId;//主键
@property(nonatomic,copy) NSString* title;//标题
@property(nonatomic,copy) NSString* content;//内容
@property(nonatomic,copy) NSString* createTime;//创建时间

@end

@interface LBB_NoticeViewModel : BN_BaseDataModel

@property(nonatomic,strong) NSMutableArray<LBB_NoticeModel*>* dataArray;

/**
 *3.10.7 公告列表(已测)
 */
- (void)getNoticeDataArray:(BOOL)isClear;

@end
