//
//  LBB_MineModel.h
//  ST_Travel
//
//  Created by dhxiang on 16/11/6.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mine_Common.h"

@interface LBB_MineUserInfo :NSObject

@property (nonatomic,copy) NSString *userID;//用户ID
@property (nonatomic,copy) NSString *userImagePath;//用户头像
@property (nonatomic,copy) UIImage *coverPicturePath; //封面图
@property (nonatomic,copy) NSString *userName;//用户名
@property (nonatomic,assign) NSInteger lvLevel; //等级
@property (nonatomic,assign) BOOL isGuideAuth;//是否导游认证
@property (nonatomic,copy) NSString *signature; //签名
@end

@interface LBB_MineDetaiInfo : NSObject
@property(nonatomic,assign) NSInteger detailType;//类型
@property(nonatomic,copy) NSString *detailContent; //描述
@property(nonatomic,copy) NSString *detailImage; //icon图标
@property(nonatomic,assign) NSInteger newNum; //新增未查看数量

@end

@interface LBB_MineSectionInfo :NSObject

@property(nonatomic,assign) NSInteger setcionType;//类别
@property(nonatomic,copy) NSString *sectionContent;//类别内容
@property(nonatomic,assign) BOOL needCheckAll; //是否有查看全部
@property(nonatomic,strong) NSMutableArray<LBB_MineDetaiInfo*>* detailArary;

@end


@interface LBB_MineModelData : NSObject

@property(nonatomic,strong)LBB_MineUserInfo *userInfo;
@property(nonatomic,strong) NSMutableArray<LBB_MineSectionInfo*> *sectionInfo;

@end

@interface LBB_MineModel : NSObject

- (LBB_MineModelData*)getData;

@end
