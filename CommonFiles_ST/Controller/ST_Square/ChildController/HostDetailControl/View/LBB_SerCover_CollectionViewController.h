//
//  LBB_SerCover_CollectionViewController.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "BN_SquareTravelNotesModel.h"

@interface LBB_SerCover_CollectionViewController : UICollectionViewController
@property(nonatomic,strong)NSMutableArray<TravelNotesPics *>   *imageArray;
@property(nonatomic,copy)BlockAddTip             setCoverBlock;
@end
