//
//  LBB_TicketCommentSectionView.h
//  Textdd
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LBB_TicketCommentSectionView : UICollectionReusableView

@property(nonatomic,strong) NSMutableDictionary *cellInfo;
@property(nonatomic,weak) UIViewController *parentVC;


@end
