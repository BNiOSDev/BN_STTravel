//
//  LBB_TraveNoteHead_View.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"


@interface LBB_TraveNoteHead_View : UIView<UITextFieldDelegate>
@property(nonatomic,copy)NSString   *coverImage;
@property(nonatomic,copy)NSString   *headImageUrl;
@property(nonatomic,copy)NSString     *travelName;
@property(nonatomic,copy)NSString     *travelTime;
@property(nonatomic,copy)BtnFuncTion btnFunction;
@property(nonatomic,strong)UITextField      *travelNameLabel;
@end
