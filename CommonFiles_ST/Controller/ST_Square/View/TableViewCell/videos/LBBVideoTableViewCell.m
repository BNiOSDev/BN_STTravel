//
//  LBBVideoTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBVideoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PraiseView.h"
#import "ZJMCommentView.h"
#import "CommentBoxView.h"
#import "ContentImageView.h"
#import "Header.h"

@implementation LBBVideoTableViewCell
{
    UIButton       *_iconImage;//大头像
    UIButton       *_collectBtn;
    UILabel         *_nameLable;//用户名
    UILabel         *_timeLabel;//时间
    UILabel         *_addressNameLabel;//地址
    UILabel         *_contentLabel;//内容
    UIImageView        *_addressImage;//地址图标
    UIImageView        *_timeImage;//时间图标
    
    ContentImageView      *_contentImage;//主图，内容图
    PraiseView                  *praiseView;         //
    ZJMCommentView      *commetView;      //
    CommentBoxView       *boxView;             //
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{
    _iconImage = [UIButton new];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14.0];
    _nameLable.textColor = ColorBlack;
    
    _addressImage = [UIImageView new];
    
    _timeImage = [UIImageView new];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = ColorGray;
    _timeLabel.font = Font12;
    
    _addressNameLabel = [UILabel new];
    _addressNameLabel.textColor = ColorGray;
    _addressNameLabel.font = Font12;
    
    _contentLabel = [UILabel new];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = Font14;
    _contentLabel.textColor = ColorGray;
    
    _contentImage = [ContentImageView new];
    
    praiseView  = [PraiseView new];
    
    _collectBtn = [UIButton new];
    _collectBtn.backgroundColor = UIColorFromRGB(0xE0E1E2);
    [_collectBtn setImage:IMAGE(@"cancelFocus") forState:0];
    [_collectBtn setTitle:@"收藏" forState:0];
    [_collectBtn setTitleColor:UIColorFromRGB(0x888888) forState:0];
    _collectBtn.titleLabel.font = FONT(11.0);
    commetView = [ZJMCommentView new];
    
    boxView = [CommentBoxView new];
    
    NSArray   *views = @[_iconImage,_nameLable,_timeImage,_timeLabel,_addressImage,_addressNameLabel,_contentLabel,
    _contentImage,praiseView,_collectBtn,commetView,boxView];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconImage.sd_layout
    .leftSpaceToView(contentView, margin + 5)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLable.sd_layout
    .leftSpaceToView(_iconImage, margin)
    .topEqualToView(_iconImage)
    .heightIs(20)
    .widthIs(300);

    _timeImage.sd_layout
    .leftSpaceToView(_iconImage,margin)
    .topSpaceToView(_nameLable,2.0)
    .heightIs(18)
    .widthIs(18);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_timeImage, margin - 5)
    .topEqualToView(_timeImage)
    .heightIs(18);
//    .widthIs(300);
    
    _addressImage.sd_layout
    .leftSpaceToView(_timeLabel,margin)
    .topSpaceToView(_nameLable,2.0)
    .heightIs(18)
    .widthIs(12);
    
    _addressNameLabel.sd_layout
    .leftSpaceToView(_addressImage, margin - 5)
    .topEqualToView(_addressImage)
    .heightIs(18);
    
//    _contentLabel.sd_layout
//    .leftEqualToView(_nameLable)
//    .topSpaceToView(_iconImage, margin)
////    .rightSpaceToView(contentView, 40)
//    .autoHeightRatio(0);
    
}


- (void)setModel:(ZJMHostModel *)model
{
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]  forState:UIControlStateNormal placeholderImage:DEFAULTIMAGE];
    _nameLable.text = model.userName;
    _addressImage.image = IMAGE(@"zjmaddress");
    _timeImage.image = IMAGE(@"zjmtime");
    _addressNameLabel.text = model.address;
    _timeLabel.text = model.timeAgo;
    _contentLabel.text = model.content;

    _contentImage.imageArray = model.imageArray;
    praiseView.praiseArray = model.praiseModelArray;
    commetView.commentArray = model.commentModelArray;
    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_iconImage, 5);
    [_contentLabel autoFit:model.content size:_contentLabel.font maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
    
    _contentImage.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_contentLabel, 5)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(AUTO(155));
    
    praiseView.sd_layout
    .leftEqualToView(_contentImage)
    .topSpaceToView(_contentImage,5.0)
    .widthIs(300);
    
    _collectBtn.sd_layout
    .rightEqualToView(_contentImage)
    .topSpaceToView(_contentImage,5.0)
    .widthIs(AUTO(40))
    .heightIs(18);
    
    commetView.sd_layout
    .leftEqualToView(praiseView)
    .topSpaceToView(praiseView,10.0)
    .rightEqualToView(_contentImage);
    
    boxView.sd_layout
    .leftEqualToView(commetView)
    .topSpaceToView(commetView,10.0)
    .rightEqualToView(_contentImage)
    .heightIs(AUTO(30));

    [self setupAutoHeightWithBottomViewsArray:@[boxView,_contentLabel] bottomMargin:10];
    
}


@end
