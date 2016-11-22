//
//  LBB_PoohAttributedTextCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"

@interface LBB_PoohAttributedTextCell : LBBPoohBaseTableViewCell

//@property(nonatomic, retain)UILabel* attributedTextLabel;

-(void)setAttributedText:(NSString *)text;
@property(nonatomic, retain)UILabel* attributedTextLabel;

@end
