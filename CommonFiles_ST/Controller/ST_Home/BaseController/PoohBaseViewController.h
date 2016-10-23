//
//  PoohBaseViewController.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "PoohCommon.h"

@interface PoohBaseViewController : Base_BaseViewController

@property (nonatomic, strong) UIView *baseNavigationBarView;
@property (nonatomic, strong) UIView *baseContentView;
@property (nonatomic, strong) UILabel *baseNavigationBarLabel;
@property (nonatomic, strong) UIButton *baseLeftButton;
@property (nonatomic, strong) UIButton *baseRightButton;


- (void)addBackButton:(SEL)selector;
/**
 *  内容视图铺满屏幕，放在导航条的下方，用于导航条透明，如客户信息首页
 */
- (void)setupFullContentView;

- (void)dismiss;


#pragma base


/**
 *  是否显示导航条
 *
 *  param hidden
 */
- (void)setBaseNavigationBarHidden:(BOOL)hidden;
/**
 *  设置导航条标题
 *
 *  param barTitle
 */
- (void)setBaseNavigationBarTitle:(NSString *)barTitle;
/**
 *  设置导航条字体颜色
 *
 *  param barColor
 */
- (void)setBaseNavigationBarColor:(UIColor *)barColor;
/**
 *  设置导航条背景色
 *
 *  param barColor
 */
- (void)setBaseNavigationBarBackgroundColor:(UIColor *)barColor;

/**
 *  设置左按钮宽度
 *
 *  param width
 */
- (void)updateLeftButtonWidth:(CGFloat)width;
/**
 *  设置右按钮宽度
 *
 *  param width
 */
- (void)updateRightButtonWidth:(CGFloat)width;

/**
 *  添加左按钮事件响应
 *
 *  param selector
 */
- (void)addLeftButtonSelector:(SEL)selector;
/**
 *  添加右按钮事件响应
 *
 *  param selector
 */
- (void)addRightButtonSelector:(SEL)selector;

/**
 *  设置左按钮图片
 *
 *  param image
 */
- (void)setLeftButtonImage:(UIImage *)image;
/**
 *  设置右按钮图片
 *
 *  param image
 */
- (void)setRightButtonImage:(UIImage *)image;


/**
 *  设置状态条样式
 *
 *  param style
 */
- (void)setStatusBarStyle:(UIStatusBarStyle)style;

/**
 *  是否可以滑动后退
 *
 *  param enable
 */
- (void)enableInteractivePopGesture:(BOOL)enable;



@end
