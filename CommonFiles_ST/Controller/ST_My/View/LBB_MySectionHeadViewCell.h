//
//  LBB_MySectionHeadViewCell.h
//  ST_Travel
//
//  Created by Diana on 16/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@property (nonatomic,strong) id userInfo;
@property (nonatomic,assign) NSInteger viewType;

@end
