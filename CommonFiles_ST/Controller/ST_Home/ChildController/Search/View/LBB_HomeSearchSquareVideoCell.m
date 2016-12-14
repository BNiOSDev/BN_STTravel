//
//  LBBVideoTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/22.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HomeSearchSquareVideoCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PraiseView.h"
#import "ZJMCommentView.h"
#import "CommentBoxView.h"
#import "ContentImageView.h"
#import "Header.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "LBB_ZJMPhotoList.h"
#import "LBB_SquareSnsFollowViewController.h"


@implementation LBB_HomeSearchSquareVideoCell
{
    UIButton       *_iconImage;//大头像
    UIButton       *_playBtn;
    UILabel         *_nameLable;//用户名
    UILabel         *_timeLabel;//时间
    UILabel         *_addressNameLabel;//地址
    UILabel         *_contentLabel;//内容
    UIImageView        *_addressImage;//地址图标
    UIImageView        *_timeImage;//时间图标
    
    UIImageView      *_contentImage;//主图，内容图
    MPMoviePlayerViewController *moviePlayerView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        WS(ws);
        UIView *sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.right.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
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
    
    _contentImage = [UIImageView new];
    
    
    _playBtn =  [UIButton new];
    [_playBtn setImage:IMAGE(@"zjmbofang") forState:0];
    [_playBtn addTarget:self action:@selector(playFunc) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray   *views = @[_iconImage,_nameLable,_timeImage,_timeLabel,_addressImage,_addressNameLabel,_contentLabel,
    _contentImage,_playBtn];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    _addressImage.image = IMAGE(@"zjmaddress");
    _timeImage.image = IMAGE(@"zjmtime");
    UIImage *addressImage = IMAGE(@"zjmaddress");
    UIImage *timeImage = IMAGE(@"zjmtime");
    
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
    .topSpaceToView(_nameLable,5.0)
    .heightIs(timeImage.size.height)
    .widthIs(timeImage.size.width);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_timeImage, margin - 5)
    //    .topEqualToView(_timeImage)
    .centerYEqualToView(_timeImage)
    .heightIs(18);
    //        .widthIs(300);
    
    _addressImage.sd_layout
    .leftSpaceToView(_timeLabel,margin)
    .topSpaceToView(_nameLable,5.0)
    .heightIs(addressImage.size.height)
    .widthIs(addressImage.size.width);
    
    _addressNameLabel.sd_layout
    .leftSpaceToView(_addressImage, margin - 5)
    //    .topEqualToView(_addressImage)
    .centerYEqualToView(_addressImage)
    .heightIs(18);
    
    [_iconImage addTarget:self action:@selector(userShow) forControlEvents:UIControlEventTouchUpInside];
}

-(void)userShow{//点击头像，显示用户个人主页
    
    LBB_SquareSnsFollowViewController* vc = [[LBB_SquareSnsFollowViewController alloc] init];
    LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
    viewModel.userId = self.model.userId;
    vc.viewModel = viewModel;
    [[self getViewController].navigationController pushViewController:vc animated:YES];
    
}

- (void)setModel:(LBB_SearchSquareUgc *)model
{
    _model = model;
  
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl]  forState:UIControlStateNormal placeholderImage:DEFAULTIMAGE];
    _nameLable.text = model.userName;
    _addressImage.image = IMAGE(@"zjmaddress");
    _timeImage.image = IMAGE(@"zjmtime");
    _addressNameLabel.text = model.allSpotsName;
    _timeLabel.text = [NSString stringWithFormat:@"%ld 分钟前",model.timeDistance];
    _contentLabel.text = model.remark;//视频描述

    FZJPhotoTool  *tool = [[FZJPhotoTool alloc]init];
    __block UIImage  *videoImage;
    [tool getThumbnailImage:model.videoUrl Block:^(UIImage *resultImage) {
                videoImage = resultImage;
    }];
    if(!videoImage)
    {
        [_contentImage sd_setImageWithURL:[NSURL URLWithString:model.videoUrl] placeholderImage:DEFAULTIMAGE];
    }else{
        _contentImage.image = videoImage;
    }

    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_iconImage, 5);
    [_contentLabel autoFit:model.remark size:_contentLabel.font maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
    if(_contentLabel.text.length == 0)
    {
        _contentLabel.height = 0;
    }
    
    _contentImage.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_contentLabel, 5)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(AUTO(155));
    
    _playBtn.sd_layout
    .centerXEqualToView(_contentImage)
    .centerYEqualToView(_contentImage)
    .heightIs(50)
    .widthIs(50);


    [self setupAutoHeightWithBottomView:_contentImage bottomMargin:10];
}

- (void)playFunc
{
//    if(_blockBtnFunc)
//    {
//        self.blockBtnFunc(0);
//    }
    NSLog(@"我不让你看呀");
}


@end
