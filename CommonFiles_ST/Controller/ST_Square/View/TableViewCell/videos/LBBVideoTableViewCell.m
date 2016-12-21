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
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import "LBB_ZJMPhotoList.h"
#import "LBB_TagView.h"

@implementation LBBVideoTableViewCell
{
    UIButton       *_iconImage;//大头像
    UIButton       *_collectBtn;
    UIButton       *_playBtn;
    UILabel         *_nameLable;//用户名
    UILabel         *_timeLabel;//时间
    UILabel         *_addressNameLabel;//地址
    UILabel         *_contentLabel;//内容
    UIImageView        *_addressImage;//地址图标
    UIImageView        *_timeImage;//时间图标
    
    UIImageView      *_contentImage;//主图，内容图
    PraiseView                  *praiseView;         //
    ZJMCommentView      *commetView;      //
    CommentBoxView       *boxView;             //
    MPMoviePlayerViewController *moviePlayerView;
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
    
    __weak typeof(self) weakSelf = self;
    _contentImage = [UIImageView new];
    
    praiseView  = [PraiseView new];
    praiseView.praiseBlock = ^(UIButton *btn,UITableViewCellViewSignal signal){
        weakSelf.sendCommentBolck(btn,signal);
    };
    
    _collectBtn = [UIButton new];
    _collectBtn.backgroundColor = UIColorFromRGB(0xE0E1E2);
    [_collectBtn setImage:IMAGE(@"cancelFocus") forState:0];
    [_collectBtn setTitle:@"收藏" forState:0];
    [_collectBtn setTitleColor:UIColorFromRGB(0x888888) forState:0];
    _collectBtn.titleLabel.font = FONT(11.0);
    [_collectBtn addTarget:self action:@selector(collectFunc:) forControlEvents:UIControlEventTouchUpInside];
    commetView = [ZJMCommentView new];
    
    boxView = [CommentBoxView new];
    boxView.sendBlock = ^(NSString *str,UITableViewCellViewSignal signal){
        if(weakSelf.sendCommentBolck)//判断是否实现了块
                weakSelf.sendCommentBolck(str,signal);
    };
    
    
    _playBtn =  [UIButton new];
    [_playBtn setImage:IMAGE(@"zjmbofang") forState:0];
    [_playBtn addTarget:self action:@selector(playFunc) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray   *views = @[_iconImage,_nameLable,_timeImage,_timeLabel,_addressImage,_addressNameLabel,_contentLabel,
    _contentImage,praiseView,_collectBtn,commetView,boxView,_playBtn];
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

}


- (void)setModel:(LBB_SquareUgc *)model
{
    _model = model;
    
    /*
     
     @property (nonatomic, assign)long ugcId ;// 主键
     @property (nonatomic, assign)int ugcType ;// 1.照片 2.视频
     @property (nonatomic, strong)NSString *videoUrl ;// 视频地址(类型为2)
     @property (nonatomic, assign)long userId ;// 用户ID
     @property (nonatomic, strong)NSString *userName ;// 用户名称
     @property (nonatomic, strong)NSString *userPicUrl ;// 用户头像
     @property (nonatomic, assign)long timeDistance ;// 时间距离(分)
     @property (nonatomic, assign)long allSpotsId ;// 场景ID
     @property (nonatomic, strong)NSString *allSpotsName ;// 场景名称
     @property (nonatomic, strong)NSMutableArray<LBB_SquarePics *> *pics ;// 图片集合
     @property (nonatomic, strong)NSMutableArray<LBB_SquareTags *> *tags ;// 视频标签
     @property (nonatomic, assign)int picNum ;// 图片总数
     @property (nonatomic, strong)NSString *picsRemark ;// 图片描述
     @property (nonatomic, strong)NSString *videoRemark ;// 视频描述
     @property (nonatomic, assign)int likeNum ;// 点赞次数
     @property (nonatomic, assign)int isLiked ;// 是否点赞 0 否 1是
     @property (nonatomic, strong)NSMutableArray<LBB_SquareLikeList *> *likeList ;// 点赞集合
     @property (nonatomic, assign)int isCollected ;// 是否收藏0 否 1是
     @property (nonatomic, strong)NSMutableArray<LBB_SquareComments *> *comments ;// 评论集合
     
     @property (nonatomic, strong)LBB_SquareDetailViewModel *squareDetailViewModel;
     
     @property (nonatomic, strong)LBB_UserShowViewModel *userShowViewModel;
     */
    
    if(model.isCollected == 1)
    {
        [_collectBtn setImage:IMAGE(@"景区列表_收藏HL") forState:0];
    }
    else
    {
        [_collectBtn setImage:IMAGE(@"景区列表_收藏") forState:0];
    }
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl]  forState:UIControlStateNormal placeholderImage:DEFAULTIMAGE];
    _nameLable.text = model.userName;
    _addressImage.image = IMAGE(@"zjmaddress");
    _timeImage.image = IMAGE(@"zjmtime");
    _addressNameLabel.text = model.allSpotsName;
    _timeLabel.text = [NSString stringWithFormat:@"%ld 分钟前",model.timeDistance];
    _contentLabel.text = model.videoRemark;//视频描述
    
    [_contentImage sd_setImageWithURL:[NSURL URLWithString:model.videoUrl] placeholderImage:DEFAULTIMAGE];

    //点赞人数
    NSMutableArray *praiseModelArray = (NSMutableArray *)[model.likeList map:^id(LBB_SquareLikeList *element) {
        PraiseModel* dic = [[PraiseModel alloc] init];
        dic.iconUrl = element.portrait;
        dic.userID = [NSString stringWithFormat:@"%ld",element.userId];
        dic.likeId = element.likeId;
        return dic;
    }];
    
    praiseView.praiseArray = praiseModelArray;
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

    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_iconImage, 5);
    [_contentLabel autoFit:model.videoRemark size:_contentLabel.font maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
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
    [self setTagViews];
}

- (void)playFunc
{
    if(_blockBtnFunc)
    {
        self.blockBtnFunc(0);
    }
}

- (void)setTagViews
{
    for(UIView *view in [self subviews])
    {
        if([view isKindOfClass:[LBB_TagView class]])
        {
            [view removeFromSuperview];
        }
    }
    __block UIView *lastView = _contentImage;
    for(int i = 0;i < _model.tags.count;i++)
    {
        LBB_SquareTags  *tagsModel = [_model.tags objectAtIndex:i];
         __block LBB_TagView   *tagView = [[LBB_TagView alloc]initWithFrame:CGRectMake(0, _contentImage.height - AUTO(25) - (AUTO(25) * i), AUTO(80), AUTO(20))];
        [_contentImage addSubview:tagView];
        tagView.tagModel = tagsModel;
        __weak typeof(tagView) weakTagView = tagView;
        tagView.blockTagFunc = ^(LBB_TagView *view)
        {
//            weakTagView.left = _contentImage.width - view.width - 5;
            weakTagView.sd_layout
            .bottomSpaceToView(lastView,5)
            .rightSpaceToView(lastView,5)
            .heightIs(view.height)
            .widthIs(view.width);
        };
        tagView.tagTitleStr = tagsModel.tagName;
    }
}

- (void)collectFunc:(UIButton *)btn
{
        self.sendCommentBolck(btn,UITableViewCellCollect);
}

@end
