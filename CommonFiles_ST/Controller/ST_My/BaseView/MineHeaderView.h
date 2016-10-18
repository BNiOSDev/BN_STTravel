//
//  MineHeaderView.h
//  LUBABA
//
//  Created by Dianar on 16/10/8.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineHeaderViewDelegate <NSObject>

@optional
- (void)didClickSetting:(id)userInfo;
- (void)didClickMessage:(id)userInfo;
- (void)didClickPersonalCenter:(id)userInfo;

@end

@interface MineHeaderView : UIView

@property (nonatomic,weak) id<MineHeaderViewDelegate> delegate;
@property (nonatomic,strong) id userInfo;


@end
