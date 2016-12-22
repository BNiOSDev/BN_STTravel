//
//  LBB_HostDetailTableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HostDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PraiseView.h"
#import "ZJMCommentView.h"
#import "CommentBoxView.h"
#import "ContentImageView.h"
#import "Header.h"

@implementation LBB_HostDetailTableViewCell

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
    
    __weak typeof(self)  weakSelf = self;
    praiseView  = [PraiseView new];
    praiseView.praiseBlock = ^(UIButton *btn,UITableViewCellViewSignal signal){
        weakSelf.cellBtnBlock(btn,signal);
    };
    
    _collectBtn = [UIButton new];
    _collectBtn.backgroundColor = UIColorFromRGB(0xE0E1E2);
    [_collectBtn setTitle:@"收藏" forState:0];
    [_collectBtn setTitleColor:UIColorFromRGB(0x888888) forState:0];
    _collectBtn.titleLabel.font = FONT(10.0);
    [_collectBtn addTarget:self action:@selector(collectFunc:) forControlEvents:UIControlEventTouchUpInside];
    commetView = [ZJMCommentView new];
    
    boxView = [CommentBoxView new];
    boxView.sendBlock = ^(NSString *str,UITableViewCellViewSignal signal){
        weakSelf.cellBtnBlock(str,signal);
    };
    
    NSArray   *views = @[_iconImage,_nameLable,_timeImage,_timeLabel,_addressImage,_addressNameLabel,_contentLabel,
                         _contentImage,praiseView,_collectBtn,commetView,boxView];
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


- (void)setModel:(LBB_SquareDetailViewModel *)model
{
    
    _model = model;
    
    /*
     
     @property (nonatomic,assign)long ugcId ;// 主键
     @property (nonatomic, strong)NSString *shareUrl ;// 分享URL
     @property (nonatomic, strong)NSString *shareTitle ;// 分享标题
     @property (nonatomic, strong)NSString *shareContent ;// 分享内容
     @property (nonatomic, assign)int type ;// 1.照片 2.视频
     @property (nonatomic, strong)NSString *videoUrl ;// 视频地址(类型为2)
     @property (nonatomic,assign)long userId ;// 用户ID
     @property (nonatomic, strong)NSString *userName ;// 用户名称
     @property (nonatomic, strong)NSString *createTime ;// 创建时间
     @property (nonatomic, strong)NSString *timeDistance ;// 时间距离
     @property (nonatomic,assign)long allSpotsId ;// 场景ID
     @property (nonatomic, strong)NSString *allSpotsName ;// 场景名称
     @property (nonatomic, strong)NSMutableArray<LBB_SquarePics *> *pics ;// 图片集合
     @property (nonatomic, strong)NSMutableArray<LBB_SquareTags *> *tags ;// 视频标签
     @property (nonatomic, assign)int picNum ;// 图片总数
     @property (nonatomic, strong)NSString *picsRemark ;// 图片描述
     @property (nonatomic, strong)NSString *videoRemark ;// 视频描述
     @property (nonatomic, assign)int likeNum ;// 点赞次数
     @property (nonatomic, assign)int isLiked ;// 是否点赞
     @property (nonatomic, strong)NSMutableArray<LBB_SquareLikeList *> *likeList ;// 点赞集合
     @property (nonatomic, assign)int isCollected ;// 是否收藏
     @property (nonatomic, strong)NSMutableArray<LBB_SquareComments *> *comments ;// 评论集合
     */
    
    if(model.isCollected == 1)
    {
        [_collectBtn setImage:IMAGE(@"景区列表_收藏HL") forState:0];
    }else
    {
        [_collectBtn setImage:IMAGE(@"景区列表_收藏") forState:0];
    }

    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl]  forState:UIControlStateNormal placeholderImage:DEFAULTIMAGE];
    _nameLable.text = model.userName;
    NSLog(@"model.userName:%@",model.userName);
    _addressImage.image = IMAGE(@"zjmaddress");
    _timeImage.image = IMAGE(@"zjmtime");
    _addressNameLabel.text = model.allSpotsName;// 场景名称
    _timeLabel.text = model.createTime;
    if (model.type == 1) {//照片
        _contentLabel.text = model.picsRemark;
    }
    else{//视频
        _contentLabel.text = model.videoRemark;
    }
    
    //图片集合
    NSMutableArray *imageArray = (NSMutableArray *)[model.pics map:^id(LBB_SquarePics *element) {
        
        NSString* dic = element.imageUrl;
        return dic;
    }];
    _contentImage.imageArray = imageArray;
    
    //点赞人数
    NSMutableArray *praiseModelArray = (NSMutableArray *)[model.likeds map:^id(LBB_SquareLikeList *element) {
        
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
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,5)
    .topSpaceToView(_iconImage, 2.5);
    if (model.type == 1) {//照片
        [_contentLabel autoFit:model.picsRemark size:_contentLabel.font maxSize:CGSizeMake(DeviceWidth - 15, DeviceHeight)];
    }
    else{//视频
        [_contentLabel autoFit:model.videoRemark size:_contentLabel.font maxSize:CGSizeMake(DeviceWidth - 15, DeviceHeight)];
    }
    if(_contentLabel.text.length == 0)
    {
        _contentLabel.height = 0;
    }
    _contentImage.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(_contentLabel, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(AUTO(320));
    
    praiseView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(_contentImage,5.0)
    .widthIs(300);
    
    _collectBtn.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_contentImage,5.0)
    .widthIs(AUTO(40))
    .heightIs(18);
    
    commetView.sd_layout
    .leftEqualToView(praiseView)
    .topSpaceToView(praiseView,10.0)
    .rightSpaceToView(self.contentView,10);
    
    boxView.sd_layout
    .leftEqualToView(commetView)
    .topSpaceToView(commetView,10.0)
    .rightSpaceToView(self.contentView,10)
    .heightIs(40);
    
    [self setupAutoHeightWithBottomViewsArray:@[boxView,_contentLabel] bottomMargin:10];
}

- (void)collectFunc:(UIButton *)btn
{
    self.cellBtnBlock(btn,UITableViewCellCollect);
}

@end
