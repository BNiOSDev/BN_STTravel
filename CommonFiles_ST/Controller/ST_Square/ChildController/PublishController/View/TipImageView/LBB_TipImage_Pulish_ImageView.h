//
//  LBB_TipImage_Pulish_ImageView.h
//  ST_Travel
//
//  Created by dawei che on 2016/11/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface LBB_TipImage_Pulish_ImageView : UIImageView
@property(nonatomic,strong)NSMutableArray      *tipArray;
@property(nonatomic,strong)BlockAddTip  _blockAddTip;
@end
