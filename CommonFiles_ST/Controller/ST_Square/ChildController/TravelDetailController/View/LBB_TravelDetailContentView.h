//
//  LBB_TravelDetailContentView.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_PraiseWithCommentView.h"
#import "LBB_AddressTipView.h"
#import "ZJMHostModel.h"

@interface LBB_TravelDetailContentView : UIView
@property(nonatomic,strong)ZJMHostModel   *model;//无实际作用，调试用

- (void)prepareForReuse;

@end
