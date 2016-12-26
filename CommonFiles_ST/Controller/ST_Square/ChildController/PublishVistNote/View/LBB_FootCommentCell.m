//
//  LBB_FootCommentCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FootCommentCell.h"
#import "PraiseView.h"
#import "CommentBoxView.h"
#import "ZJMCommentView.h"
#import "Header.h"

@implementation LBB_FootCommentCell
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
    __weak typeof(self) weakSelf = self;
    praiseView  = [PraiseView new];
    
    praiseView.praiseBlock = ^(UIButton *btn,UITableViewCellViewSignal signal)
    {
        if(weakSelf.commentBlock)
        {
            weakSelf.commentBlock(btn,signal);
        }
    };
    
    commetView = [ZJMCommentView new];
    commetView.maxWidth = DeviceWidth - 20;
    
    boxView = [CommentBoxView new];
    
    boxView.sendBlock = ^(NSString *str,UITableViewCellViewSignal signal)
    {
        if(weakSelf.commentBlock)
        {
            weakSelf.commentBlock(str,signal);
        }
    };
    
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

- (void)setModel:(BN_TravelNotesDetailsComments *)model
{
    _model = model;
//    [headBackImage sd_setImageWithURL:[NSURL URLWithString:model.travelNotesPicUrl] placeholderImage:DEFAULTIMAGE];
//    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl] placeholderImage:DEFAULTIMAGE];
//    nameLabel.text = model.userName;
//    timeLabel.text = model.lastReleaseTime;
    
    praiseView.praiseArray = model.likeList;
    if(model.isLiked == 1)
    {
        [praiseView setBtnImage:IMAGE(@"zjmzhuyedianzaned")];
    }
    else
    {
        [praiseView setBtnImage:IMAGE(@"zjmzhuyedianzan")];
    }
    
    //评论内容
    NSMutableArray *commentModelArray = (NSMutableArray *)[model.comments map:^id(LBB_SquareComments *element) {
        
        CommentModel *model = [[CommentModel alloc]init];
        model.userName = element.userName;// 用户名称
        model.contentStr = element.remark;// 评论内容
        model.userID = [NSString stringWithFormat:@"%ld",element.commentId];// 评论ID
        return model;
    }];
    commetView.commentArray = commentModelArray;
    
    [self setupAutoHeightWithBottomView:boxView bottomMargin:10];
}


@end
