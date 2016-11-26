//
//  LBB_TravelCommentCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelCommentCell.h"
#import "PraiseView.h"
#import "CommentBoxView.h"
#import "ZJMCommentView.h"
#import "Header.h"

@implementation LBB_TravelCommentCell
{
    UIImageView     *headBackImage;
    UIImageView     *_iconImage;
    UILabel              *nameLabel;
    UILabel              *timeLabel;
    
    PraiseView                  *praiseView;         //
    ZJMCommentView      *commetView;      //
    CommentBoxView       *boxView;             //
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUp];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    headBackImage.image = nil;
    _iconImage.image = nil;
}
- (void)setUp
{
//    [self.contentView removeAllSubviews];
    
    headBackImage = [UIImageView new];
    _iconImage = [UIImageView new];
    nameLabel = [UILabel new];
    nameLabel.font = FONT(AUTO(12.0));
    nameLabel.textColor = LESSBLACKCOLOR;
    
    timeLabel = [UILabel new];
    timeLabel.font = FONT(AUTO(12.0));
    timeLabel.textColor = MORELESSBLACKCOLOR;
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    praiseView  = [PraiseView new];
    commetView = [ZJMCommentView new];
    commetView.maxWidth = DeviceWidth - 20;

    boxView = [CommentBoxView new];
    NSArray *views = @[headBackImage,_iconImage,nameLabel,timeLabel,praiseView,commetView,boxView];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    headBackImage.sd_layout
    .leftEqualToView(contentView)
    .topEqualToView(contentView)
    .rightEqualToView(contentView)
    .heightIs(AUTO(180));
    
    _iconImage.sd_layout
    .leftSpaceToView(contentView,20)
    .topSpaceToView(headBackImage,-AUTO(15))
    .widthIs(AUTO(40)).heightIs(AUTO(40));
    [_iconImage setSd_cornerRadius:@(AUTO(40) / 2.0)];
    
    nameLabel.sd_layout
    .leftSpaceToView(_iconImage,5)
    .topSpaceToView(headBackImage,5)
    .heightIs(AUTO(15))
    .rightSpaceToView(contentView,AUTO(-120));
    
    timeLabel.sd_layout
    .topSpaceToView(headBackImage,5)
    .leftSpaceToView(contentView,0)
    .rightSpaceToView(contentView,10)
    .heightIs(AUTO(15));
    
    praiseView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(_iconImage,10.0)
    .widthIs(DeviceWidth - 20);
    
    commetView.sd_layout
    .leftEqualToView(praiseView)
    .topSpaceToView(praiseView,10.0)
    .rightEqualToView(praiseView);
    
    boxView.sd_layout
    .leftEqualToView(commetView)
    .topSpaceToView(commetView,10.0)
    .rightEqualToView(commetView)
    .heightIs(AUTO(30));

}

- (void)setModel:(ZJMHostModel *)model
{
    _model = model;
    headBackImage.backgroundColor = [UIColor orangeColor];
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:DEFAULTIMAGE];
    nameLabel.text = model.userName;
    timeLabel.text = model.timeAgo;
    
    praiseView.praiseArray = model.praiseModelArray;
    
    commetView.commentArray = model.commentModelArray;
    
    [self setupAutoHeightWithBottomView:boxView bottomMargin:10];
}

@end
