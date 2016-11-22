//
//  LBB_ScenicDetailBookStatusCell.h
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBPoohBaseTableViewCell.h"
#import "LBB_SpotDetailsViewModel.h"
@interface LBB_ScenicDetailBookStatusCell : LBBPoohBaseTableViewCell


@property(nonatomic, retain)UIButton* status1View;
@property(nonatomic, retain)UIButton* status2View;
@property(nonatomic, retain)LBB_SpotDetailsViewModel* spotDetailModel;

@end
