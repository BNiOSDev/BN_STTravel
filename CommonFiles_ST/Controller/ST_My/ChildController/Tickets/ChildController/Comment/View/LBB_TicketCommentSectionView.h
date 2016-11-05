//
//  LBB_TicketCommentSectionView.h
//  Textdd
//
//  Created by dhxiang on 16/11/1.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LBB_TicketCommentSectionView : UICollectionReusableView

@property(nonatomic,strong) NSMutableDictionary *cellInfo;
@property(nonatomic,weak) UIViewController *parentVC;


@end
