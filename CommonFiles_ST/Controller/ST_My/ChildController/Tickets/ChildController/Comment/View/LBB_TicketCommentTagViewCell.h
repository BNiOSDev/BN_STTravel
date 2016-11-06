//
//  LBB_TicketCommentTagViewCell.h
//  Textdd
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 晨曦. All rights reserved.
//

#import <UIKit/UIKit.h>

CGFloat commentTagCellWith(NSString* content,BOOL close);

@interface LBB_TicketCommentTagViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property(nonatomic,strong) NSDictionary *cellInfo;
@property(nonatomic,assign) BOOL isDefault;


@end
