//
//  LBB_MessageCenterViewCell.h
//  ST_Travel
//
//  Created by dhxiang on 16/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBB_MessageCenterViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *iconImgView;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *contentLabel;
@property (nonatomic,weak) IBOutlet UILabel *dateLabel;

@property(nonatomic,strong) id cellInfo;

@end
