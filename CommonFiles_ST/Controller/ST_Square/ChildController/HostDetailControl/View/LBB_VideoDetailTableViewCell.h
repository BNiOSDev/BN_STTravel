//
//  LBB_VideoDetailTableViewCell.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/7.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJMHostModel.h"
#import "UIView+SDAutoLayout.h"
#import "LBB_SquareDetailViewModel.h"
#import "Header.h"
#import "ZFPlayer.h"

typedef void(^PlayBtnCallBackBlock)(UIButton *);

@interface LBB_VideoDetailTableViewCell : UITableViewCell
@property(nonatomic, strong) LBB_SquareDetailViewModel   *model;
@property(nonatomic, copy)CellBlockVIew       sendCommentBlock;
@property (nonatomic, copy  ) PlayBtnCallBackBlock          playBlock;
@property(nonatomic,strong) UIImageView      *contentImage;//主图，内容图
@property(nonatomic,strong)UIButton       *playBtn;
@end
