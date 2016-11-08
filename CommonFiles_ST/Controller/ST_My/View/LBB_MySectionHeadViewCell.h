//
//  LBB_MySectionHeadViewCell.h
//  ST_Travel
//
//  Created by 晨曦 on 16/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_MineModel.h"

@protocol LBB_MySectionHeadViewDelegate <NSObject>

@optional

- (void)didClickDetailActionDelegate:(NSInteger)viewType;

@end

@interface LBB_MySectionHeadViewCell : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic,weak) id<LBB_MySectionHeadViewDelegate> delegate;
@property (nonatomic,strong) LBB_MineSectionInfo* userInfo;
@property (nonatomic,assign) NSInteger viewType;

@end
