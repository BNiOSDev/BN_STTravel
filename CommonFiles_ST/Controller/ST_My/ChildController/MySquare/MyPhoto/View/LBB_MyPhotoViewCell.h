//
//  LBB_MyPhotoViewCell.h
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_MyPhotoModel.h"
#import "Mine_Common.h"

@interface LBB_MyPhotoViewCell : UICollectionViewCell

@property(nonatomic,strong)LBB_MyPhotoModel       *model;
@property(nonatomic,strong)CollectionViewCellBlock cellBlock;
@property(nonatomic,assign)MySquareViewType squareType;
@end
