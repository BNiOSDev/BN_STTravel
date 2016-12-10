//
//  LBB_ShopRecoder_Cell.h
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BN_SquareTravelNotesBillModel.h"
@interface LBB_ShopRecoder_Cell : UITableViewCell
@property(nonatomic,strong)NSDictionary  *dataaArray;
@property(nonatomic,strong)BN_SquareTravelNotesConsumeRatios  *model;
@end
