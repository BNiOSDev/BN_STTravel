//
//  LBB_TravelDetailContentView.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelDetailContentView.h"
#import "Header.h"
#import "LBB_TravelImageContentView.h"

@implementation LBB_TravelDetailContentView
{
    LBB_TravelImageContentView     *vistImage;
    UIImageView     *timeImage;
    UILabel              *contentLabel;
    UILabel              *timeLabel;
    LBB_AddressTipView  *addressTip;
    LBB_PraiseWithCommentView  *praiseCommentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        LRViewBorderRadius(self, 0, 0.5, LINECOLOR);
        [self setup];
    }
    return self;
}

- (void)setup
{
    vistImage = [LBB_TravelImageContentView new];
    
    timeImage = [UIImageView new];
    timeImage.image = IMAGE(@"zjmtime");
    
    contentLabel = [UILabel new];
    contentLabel.font = FONT(AUTO(13.0));
    contentLabel.textColor = LESSBLACKCOLOR;
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    timeLabel = [UILabel new];
    timeLabel = [UILabel new];
    timeLabel.font = FONT(AUTO(13.0));
    timeLabel.textColor = MORELESSBLACKCOLOR;
    __weak typeof(self) weakSelf = self;
    praiseCommentView = [LBB_PraiseWithCommentView new];
    praiseCommentView.cellBlock = ^(id obj,UITableViewCellViewSignal signal)
    {
       if(weakSelf.cellBlock)
        {
            weakSelf.cellBlock(obj,signal);
        }
    };
    
    addressTip = [LBB_AddressTipView new];
    
    NSArray *views = @[vistImage,contentLabel,timeImage,timeLabel,addressTip];
    [self sd_addSubviews:views];
   
}

- (void)setModel:(TravelNotesDetails *)model
{
    _model = model;

    NSMutableArray *imageArray = (NSMutableArray *)[model.pics map:^id(TravelNotesPics *element) {
        NSString* dic = element.imageUrl;
        return dic;
    }];
    CGFloat  vistImageHeigh = AUTO(230);
    vistImage.imageArray = imageArray;
    if(imageArray.count <= 0)
    {
        vistImageHeigh = 0;
    }
    if(model.isLiked == 1)
    {
        praiseCommentView.dianzanImage = IMAGE(@"我的_点赞_点击后");
    }else{
        praiseCommentView.dianzanImage = IMAGE(@"zjmwhitePraise");
    }
    praiseCommentView.praiseNum = [NSString stringWithFormat:@"%d",model.likeNum];
    praiseCommentView.commentNum =  [NSString stringWithFormat:@"%d",model.commentsNum];
    
    if(model.isLiked == 0)
    {
        NSLog(@"没有点赞");
    }else{
        NSLog(@"点赞");
    }
    
    contentLabel.text = model.picRemark;
    [contentLabel autoFit:contentLabel.text size:contentLabel.font maxSize:CGSizeMake(DeviceWidth - 30, DeviceHeight)];
    timeLabel.text = [NSString stringWithFormat:@"%@ %@",model.releaseDate,model.releaseTime];
    addressTip.address = model.allSpotsTypeName;
    
    vistImage.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(vistImageHeigh);
    
    [vistImage addSubview:praiseCommentView];
    
    contentLabel.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(vistImage,5)
    .rightSpaceToView(self,5)
    .heightIs(contentLabel.height);
    
    timeImage.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(contentLabel,10)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
    timeLabel.sd_layout
    .leftSpaceToView(timeImage,5)
    .centerYEqualToView(timeImage)
    .rightEqualToView(self)
    .heightIs(AUTO(15));
    
    addressTip.sd_layout
    .centerYEqualToView(timeImage)
    .rightSpaceToView(self,10);
    
    praiseCommentView.sd_layout
    .bottomSpaceToView(vistImage,10)
    .rightSpaceToView(vistImage,10);
    
    [self setupAutoHeightWithBottomView:timeImage bottomMargin:15];
}

- (void)setNoteModel:(BN_TravelNotesDetailsComments *)noteModel
{
    _noteModel = noteModel;
    
//   NSMutableArray *imageArray = (NSMutableArray *)[_noteModel.pics map:^id(TravelNotesPics *element) {
//       NSString* dic = element.imageUrl;
//        return dic;
//    }];
   CGFloat  vistImageHeigh = AUTO(230);
    
    vistImage.imageArray = [[NSMutableArray alloc]init];
    
   if(vistImage.imageArray.count <= 0)
    {
        vistImageHeigh = 0;
    }
    
    contentLabel.text = _noteModel.picRemark;
    [contentLabel autoFit:contentLabel.text size:contentLabel.font maxSize:CGSizeMake(DeviceWidth - 30, DeviceHeight)];
    timeLabel.text = [NSString stringWithFormat:@"%@ %@",_noteModel.releaseDate,_noteModel.releaseTime];
    addressTip.address = _noteModel.allSpotsTypeName;
    
    vistImage.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(vistImageHeigh);
    
    contentLabel.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(vistImage,5)
    .rightSpaceToView(self,5)
    .heightIs(contentLabel.height);
    
    timeImage.sd_layout
    .leftSpaceToView(self,5)
    .topSpaceToView(contentLabel,10)
    .heightIs(AUTO(12))
    .widthIs(AUTO(12));
    
    timeLabel.sd_layout
    .leftSpaceToView(timeImage,5)
    .centerYEqualToView(timeImage)
    .rightEqualToView(self)
    .heightIs(AUTO(15));
    
    addressTip.sd_layout
    .centerYEqualToView(timeImage)
    .rightSpaceToView(self,10);
    
    praiseCommentView.sd_layout
    .bottomSpaceToView(vistImage,10)
    .rightSpaceToView(vistImage,10);
    
    [self setupAutoHeightWithBottomView:timeImage bottomMargin:15];
}


@end
