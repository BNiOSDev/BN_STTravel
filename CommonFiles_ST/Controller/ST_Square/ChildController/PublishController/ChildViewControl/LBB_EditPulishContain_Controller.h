//
//  LBB_EditPulishContain_Controller.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LBB_Pulish_ImageContain_View.h"
@interface LBB_EditPulishContain_Controller : Base_BaseViewController
@property(nonatomic,strong)LBB_Pulish_ImageContain_View  *imageContainView;
@property(nonatomic,strong)NSArray   *imageArray;
@property(nonatomic,strong)NSMutableArray *tagsViewArray;//图片顺序的标签顺序
@end
