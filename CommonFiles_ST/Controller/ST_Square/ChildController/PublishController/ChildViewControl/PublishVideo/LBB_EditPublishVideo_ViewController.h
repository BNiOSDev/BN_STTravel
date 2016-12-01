//
//  LBB_EditPublishVideo_ViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "LBB_Pulish_ImageContain_View.h"
#import "LBB_TipImage_Pulish_ImageView.h"

@interface LBB_EditPublishVideo_ViewController : Base_BaseViewController
@property(nonatomic,strong)LBB_TipImage_Pulish_ImageView  *imageContainView;
@property(nonatomic,strong)NSArray   *imageArray;
@property(nonatomic,strong)NSMutableArray *tagsViewArray;//图片顺序的标签顺序
@end
