//
//  LBB_Date_SengeMent.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface LBB_Date_SengeMent : UIButton
@property(nonatomic,copy)NSString  *dateStr;
@property(nonatomic,copy)NSString  *timeStr;
@property(nonatomic,copy)BtnFuncTion  blockDatepick;
@end
