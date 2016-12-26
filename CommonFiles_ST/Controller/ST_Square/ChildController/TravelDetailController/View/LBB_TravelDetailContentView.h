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
#import "BN_SquareTravelNotesModel.h"
#import "Header.h"

@interface LBB_TravelDetailContentView : UIView
@property(nonatomic,strong)TravelNotesDetails   *model;
@property(nonatomic,copy)CellBlockVIew   cellBlock;
@property(nonatomic,strong)BN_TravelNotesDetailsComments  *noteModel;
//- (void)prepareForReuse;

@end
