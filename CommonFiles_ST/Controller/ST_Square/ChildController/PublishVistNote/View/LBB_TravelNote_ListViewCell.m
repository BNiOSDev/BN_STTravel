//
//  LBB_TravelNote_ListViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelNote_ListViewCell.h"
#import "Header.h"
#import "LBB_TravelNote_contentView.h"
@implementation LBB_TravelNote_ListViewCell
{
    UILabel  *contentLabel;
    LBB_TravelNote_contentView  *contentView;
    UIView      *line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    contentView = [LBB_TravelNote_contentView new];
    [self.contentView addSubview:contentView];
    
    line = [UIView new];
    line.backgroundColor = BLACKCOLOR;
    [self.contentView addSubview:line];
    
    contentView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topEqualToView(self.contentView);
    
    line.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(contentView,0)
    .bottomEqualToView(self.contentView)
    .widthIs(1.0);
    
    [self setupAutoHeightWithBottomView:contentView bottomMargin:AUTO(13)];
}

- (void)setModel:(TravelNotesDetails *)model
{
    _model = model;
    contentView.model = model;
}


@end
