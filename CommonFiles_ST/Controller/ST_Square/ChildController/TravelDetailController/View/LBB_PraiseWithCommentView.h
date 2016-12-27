//
//  LBB_PraiseWithCommentView.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface LBB_PraiseWithCommentView : UIView

@property(nonatomic, copy)NSString      *praiseNum;
@property(nonatomic, copy)NSString      *commentNum;
@property(nonatomic, copy)CellBlockVIew   cellBlock;
@property(nonatomic, strong)UIImage    *dianzanImage;
@end
