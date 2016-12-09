//
//  LBB_TravelNote_contentView.h
//  ST_Travel
//
//  Created by dawei che on 2016/12/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBB_PraiseWithCommentView.h"
#import "LBB_AddressTipView.h"
#import "ZJMTravelModel.h"
#import "LBB_SquareTravelListViewModel.h"

@interface LBB_TravelNote_contentView : UIView
{
    UIImageView     *timeImage;
    UIImageView     *rowImage;
    UILabel              *contentLabel;
    UILabel              *timeLabel;
    LBB_AddressTipView  *addressTip;
    UIScrollView   *imagesScroll;
}
@property(nonatomic,strong)TravelNotesDetails *model;
@end
