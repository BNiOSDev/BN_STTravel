//
//  LBB_TravelDetailViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDetailViewCell.h"
#import "Header.h"
#import "LBB_TravelDetailContentView.h"

@implementation LBB_TravelDetailViewCell
{
    LBB_TravelDetailContentView   *cellView;
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
    cellView = [LBB_TravelDetailContentView new];
    [self.contentView addSubview:cellView];
    
    line = [UIView new];
    line.backgroundColor = BLACKCOLOR;
    [self.contentView addSubview:line];
    
    cellView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topEqualToView(self.contentView);
    
    line.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(cellView,0)
    .bottomEqualToView(self.contentView)
    .widthIs(1.0);
    
    [self setupAutoHeightWithBottomView:cellView bottomMargin:AUTO(13)];
}

- (void)setModel:(TravelNotesDetails *)model
{
//    [self prepareForReuse];
    _model = model;
    cellView.model = model;
}


@end
