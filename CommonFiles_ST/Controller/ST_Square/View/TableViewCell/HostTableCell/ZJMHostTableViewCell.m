//
//  ZJMHostTableViewCell.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/19.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "ZJMHostTableViewCell.h"

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PraiseView.h"
#import "ZJMCommentView.h"
#import "CommentBoxView.h"
#import "ContentImageView.h"
#import "Header.h"
#import "PraiseModel.h"
#import "LBB_SquareSnsFollowViewController.h"

@implementation ZJMHostTableViewCell
{
    UIButton       *_iconImage;//大头像
    UIButton       *_collectBtn;
    UILabel         *_nameLable;//用户名
    UILabel         *_timeLabel;//时间
    UILabel         *_addressNameLabel;//地址
    UILabel         *_contentLabel;//内容
    UIImageView        *_addressImage;//地址图标
    UIImageView        *_timeImage;//时间图标
    
    ContentImageView      *_contentImage;   //主图，内容图
    PraiseView                  *praiseView;         //
    ZJMCommentView      *commetView;      //
    CommentBoxView       *boxView;             //
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //删除cell的栏，用来优化滑动流畅程度
        self.layer.shouldRasterize=YES;
        self.layer.rasterizationScale=[UIScreen mainScreen].scale;
        self.layer.drawsAsynchronously=YES;
        
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_contentImage prepareForReuse];
}

- (void)setup
{
    [self.contentView removeAllSubviews];
    _iconImage = [UIButton new];
    
    _nameLable = [UILabel new];
    _nameLable.font = [UIFont systemFontOfSize:14.0];
    _nameLable.textColor = ColorBlack;
//    [self showShadow:_nameLable];
    
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
    
    __weak typeof(self) weakSelf = self;
    praiseView  = [PraiseView new];
    praiseView.praiseBlock = ^(UIButton *btn,UITableViewCellViewSignal signal){
        if(weakSelf.btnBlock)
            weakSelf.btnBlock(btn,signal);
    };
    
    _collectBtn = [UIButton new];
    _collectBtn.backgroundColor = UIColorFromRGB(0xE0E1E2);
    [_collectBtn setTitle:@"收藏" forState:0];
    [_collectBtn setTitleColor:UIColorFromRGB(0x888888) forState:0];
    _collectBtn.titleLabel.font = FONT(11.0);
    [_collectBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    commetView = [ZJMCommentView new];
    
    boxView = [CommentBoxView new];
    boxView.sendBlock = ^(id object, UITableViewCellViewSignal signal){
        if(signal == UITableViewCellSendMessage)
        {
            if(weakSelf.btnBlock)
                weakSelf.btnBlock(object,signal);
        }
    };
    
    _addressImage.image = IMAGE(@"zjmaddress");
    _timeImage.image = IMAGE(@"zjmtime");
    UIImage *addressImage = IMAGE(@"zjmaddress");
    UIImage *timeImage = IMAGE(@"zjmtime");
    
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
    
    //    _contentLabel.sd_layout
    //    .leftEqualToView(_nameLable)
    //    .topSpaceToView(_iconImage, margin)
    ////    .rightSpaceToView(contentView, 40)
    //    .autoHeightRatio(0);
    
    [_iconImage addTarget:self action:@selector(userShow) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)userShow{//点击头像，显示用户个人主页

    LBB_SquareSnsFollowViewController* vc = [[LBB_SquareSnsFollowViewController alloc] init];
    vc.viewModel = self.model;
    [[self getViewController].navigationController pushViewController:vc animated:YES];
    
}

- (void)setModel:(LBB_SquareUgc *)model
{
    _model = model;
    
    if(model.isCollected == 1)
    {
        [_collectBtn setImage:IMAGE(@"景区列表_收藏HL") forState:0];
    }else
    {
        [_collectBtn setImage:IMAGE(@"景区列表_收藏") forState:0];
    }
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl]  forState:UIControlStateNormal placeholderImage:DEFAULTIMAGE];
    _nameLable.text = model.userName;
    
    _addressNameLabel.text = model.allSpotsName ;// 场景名称;
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.timeDistanceRemark];
    _contentLabel.text = model.picsRemark ;// 图片描述
    //图片集合
    NSMutableArray *imageArray = (NSMutableArray *)[model.pics map:^id(LBB_SquarePics *element) {
        
        NSString* dic = element.imageUrl;
        return dic;
    }];

    NSMutableArray *tagsArray = [[NSMutableArray alloc]init];
    if(model.pics.count == 1)
    {
        LBB_SquarePics *imageModel = model.pics[0];
        tagsArray = imageModel.tags;
    }
    
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
    //这两个的顺序不可以替换
    _contentImage.tagsArray = tagsArray;
    _contentImage.imageArray = imageArray;

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
    [_contentLabel autoFit:model.picsRemark size:_contentLabel.font maxSize:CGSizeMake(DeviceWidth - 75, DeviceHeight)];
    if(_contentLabel.text.length == 0)
    {
        _contentLabel.height = 0;
    }
    
    CGFloat   contentImageHeight;
    CGFloat   contentMargnHeight;
    if(imageArray.count == 0)
    {
        contentImageHeight = 0;
        contentMargnHeight = 0;
    }else{
        contentMargnHeight = 5.0;
        contentImageHeight = AUTO(250);
    }
    
    _contentImage.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_contentLabel, 5)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(contentImageHeight);
    
    praiseView.sd_layout
    .leftEqualToView(_contentImage)
    .topSpaceToView(_contentImage,contentMargnHeight)
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

- (void)btnFunc:(UIButton *)btn
{
    if(self.btnBlock)
    {
        self.btnBlock(btn,UITableViewCellCollect);
    }
}

//  加阴影
- (void)showShadow:(UIView*)view
{
    CALayer *layer = [view layer];
    layer.shadowOffset = CGSizeMake(1.f, 1.f);
    layer.shadowRadius = .5f;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.7;
}


@end
