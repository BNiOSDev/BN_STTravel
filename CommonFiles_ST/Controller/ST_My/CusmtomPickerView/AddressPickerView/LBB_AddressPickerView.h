//
//  LBB_AddressPickerView.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *address,NSArray *selections);

@interface LBB_AddressPickerView : UIView

@property (nonatomic,strong) NSArray *selections; //!< 选择的三个下标
@property (nonatomic,copy) NSString *pushAddress; //!< 展示的地址
@property (nonatomic,copy) MyBlock myBlock; //!< 回调地址的block

/* 初始化地址选择器
 * parma title  选择标题
 * parma showCancelButton 取消按钮
 * parma parentView 父视图
 * parma showStreet 是否显示区
 *
 */
- (instancetype)initWithTitle:(NSString *)title
             showCancelButton:(BOOL)showCancelButton
                       parentView:(UIView *)parentView
                   showStreet:(BOOL)isShowStreet;

- (void)showPickerView;

@end
