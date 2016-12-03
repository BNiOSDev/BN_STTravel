//
//  LBB_MyUserHeaderView.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_MineModel.h"

@protocol LBB_MyUserHeaderViewDelegate <NSObject>

@optional
- (void)didClickSetting:(id)userInfo;
- (void)didClickMessage:(id)userInfo;
- (void)didClickPersonalCenter:(id)userInfo IsLogin:(BOOL)isLogin;
- (void)didClickConverPicture:(id)userInfo IsLogin:(BOOL)isLogin;

@end

@interface LBB_MyUserHeaderView : UICollectionReusableView

@property (nonatomic,weak) id<LBB_MyUserHeaderViewDelegate> delegate;
@property (nonatomic,strong) LBB_MineViewModel* viewModel;
@property (nonatomic,assign) BOOL isLogin;

@end
