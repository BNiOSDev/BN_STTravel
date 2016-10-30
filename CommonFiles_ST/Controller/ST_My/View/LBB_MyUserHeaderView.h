//
//  LBB_MyUserHeaderView.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LBB_MyUserHeaderViewDelegate <NSObject>

@optional
- (void)didClickSetting:(id)userInfo;
- (void)didClickMessage:(id)userInfo;
- (void)didClickPersonalCenter:(id)userInfo;

@end

@interface LBB_MyUserHeaderView : UICollectionReusableView

@property (nonatomic,weak) id<LBB_MyUserHeaderViewDelegate> delegate;
@property (nonatomic,strong) id userInfo;

@end
