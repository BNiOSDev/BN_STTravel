//
//  LBB_NewOrderIntegralView.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/31.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_NewOrderIntegralView : UIView

@property(nonatomic, assign)NSInteger integralNum;
@property(nonatomic, assign)CGFloat rate;//兑换比例
@property(nonatomic, assign)CGFloat goodPrice;
@property(nonatomic, assign)CGFloat deductPrice;//抵扣金额

@property(nonatomic, retain)UIButton* checkButton;
@property(nonatomic, assign)BOOL isCheck;
@property(nonatomic, retain)UILabel* goodPriceLabel;
@property(nonatomic, retain)UILabel* deductPriceLabel;
@property(nonatomic, retain)UILabel* deductInfoLabel;


@end
