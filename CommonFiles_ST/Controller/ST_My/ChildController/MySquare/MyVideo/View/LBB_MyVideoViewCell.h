//
//  LBB_MyVideoViewCell.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mine_Common.h"
#import "LBB_MyVideoModel.h"
#import "Mine_Common.h"

@interface LBB_MyVideoViewCell : UICollectionViewCell

@property(nonatomic,strong)LBB_MyVideoModel       *model;
@property(nonatomic,strong)CollectionViewCellBlock cellBlock;
@property(nonatomic,assign)MySquareViewType squareType;

@end
