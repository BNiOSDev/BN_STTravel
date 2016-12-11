//
//  LBB_Travel_Bill_Cell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Travel_Bill_Cell.h"
#import "Header.h"
#import "LBB_Bill_View.h"
@implementation LBB_Travel_Bill_Cell
{
    LBB_Bill_View   *cellView;
    UIView      *line;
    UIImageView  *checkImage;
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
    cellView = [LBB_Bill_View new];
    [self.contentView addSubview:cellView];
    
    line = [UIView new];
    line.backgroundColor = BLACKCOLOR;
    [self.contentView addSubview:line];
    
    checkImage = [UIImageView new];
    checkImage.image = IMAGE(@"zjmcheck");
    [self.contentView addSubview:checkImage];
    
    cellView.sd_layout
    .leftSpaceToView(self.contentView,20)
    .rightSpaceToView(self.contentView,20)
    .topEqualToView(self.contentView);
    
    line.sd_layout
    .leftSpaceToView(self.contentView,30)
    .topSpaceToView(cellView,0)
    .bottomEqualToView(self.contentView)
    .widthIs(1.0);
    
    checkImage.sd_layout
      .leftSpaceToView(self.contentView,20 - AUTO(7.5))
    .centerYEqualToView(cellView)
    .heightIs(AUTO(15))
    .widthIs(AUTO(15));
    
    [self setupAutoHeightWithBottomView:cellView bottomMargin:AUTO(13)];
}

- (void)setModel:(BN_SquareTravelNotesconsumeDetails *)model
{
    _model = model;
    cellView.model = model;
}

@end
