//
//  LBB_TagView.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "LBB_TagsViewModel.h"

@interface LBB_TagView : UIButton
@property(nonatomic,copy)NSString   *tagTitleStr;
@property(nonatomic,strong)LBB_SquareTags  *tagModel;//必须传
@property(nonatomic,copy)BlockAddTip   blockTagFunc;//修改位置用。使用自动布局可以忽略这个。
@end
