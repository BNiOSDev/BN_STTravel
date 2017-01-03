//
//  LBB_MyTravelTableViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyTravelTableViewCell.h"
#import "Header.h"
#import "LBB_MyContentImgView.h"

@implementation LBB_MyTravelTableViewCell
{
    LBB_MyContentImgView  *contentImage;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *heartBtn;
    UIButton    *deleteBtn;
    EnlargeButton    *collecdtionBtn; //收藏
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        [self setup];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [contentImage prepareForReuse];
    zanBtn.selected = NO;
    heartBtn.selected = NO;
    collecdtionBtn.selected = NO;
}

- (void)setup
{
    contentImage = [[LBB_MyContentImgView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth,AUTO(180))];
    [self addSubview:contentImage];
    
    collecdtionBtn = [[EnlargeButton alloc]initWithFrame:CGRectMake(DeviceWidth - AUTO(35), AUTO(10), AUTO(20), AUTO(15))];
    collecdtionBtn.enlargeInset = UIEdgeInsetsMake(AUTO(10), AUTO(20), AUTO(15), AUTO(10));
    collecdtionBtn.titleLabel.font = FONT(AUTO(11.0));
    [collecdtionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [collecdtionBtn setImage:IMAGE(@"我的_小收藏") forState:UIControlStateNormal];
    [collecdtionBtn setImage:IMAGE(@"我的_小收藏-点击后") forState:UIControlStateSelected];
    [self addSubview:collecdtionBtn];
    [self bringSubviewToFront:collecdtionBtn];
    collecdtionBtn.hidden = YES;
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, DeviceWidth - 40, AUTO(20))];
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.font = FONT(AUTO(17.0));
    [self addSubview:contentLabel];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, contentLabel.bottom + AUTO(10), DeviceWidth - 40, AUTO(20))];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = FONT(AUTO(13.0));
    [self addSubview:timeLabel]; 
    
    deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20, contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    deleteBtn.titleLabel.font = FONT(AUTO(10.0));
    [deleteBtn setTitleColor:[UIColor grayColor] forState:0];
    [deleteBtn setImage:IMAGE(@"我的登录_删除") forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.width = [self getWidthWithContent:@"删除" height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    [self addSubview:deleteBtn];
    
    heartBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - deleteBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    heartBtn.titleLabel.font = FONT(AUTO(11.0));
    [heartBtn setTitleColor:[UIColor grayColor] forState:0];
    [heartBtn setImage:IMAGE(@"我的_小收藏") forState:UIControlStateNormal];
    [heartBtn setImage:IMAGE(@"我的_小收藏-点击后") forState:UIControlStateSelected];
    [self addSubview:heartBtn];
    
    pinBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - heartBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    pinBtn.titleLabel.font = FONT(AUTO(11.0));
    [pinBtn setTitleColor:[UIColor grayColor] forState:0];
    [pinBtn setImage:IMAGE(@"我的_评论") forState:0];
    [self addSubview:pinBtn];
    
    zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - pinBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    zanBtn.titleLabel.font = FONT(AUTO(11.0));
    [zanBtn setTitleColor:[UIColor grayColor] forState:0];
    [zanBtn setImage:IMAGE(@"我的_点赞") forState:UIControlStateNormal];
    [zanBtn setImage:IMAGE(@"我的_点赞_点击后") forState:UIControlStateSelected];
    [self addSubview:zanBtn];
    
    //屏蔽两个按钮可以同时被点击
    deleteBtn.exclusiveTouch = YES;
    heartBtn.exclusiveTouch = YES;
    pinBtn.exclusiveTouch = YES;
    zanBtn.exclusiveTouch = YES;
}

- (void)setViewType:(MyTravelsViewType)viewType
{
    _viewType = viewType;
    switch (_viewType) {
        case MyTravelsViewDownloaed://我的下载-游记
        case MyTravelsViewGuideDownloaed: //我的下载-攻略
        {
            deleteBtn.hidden = NO;
        }
            break;
        case MyTravelsViewRoute:
        {
            zanBtn.hidden = YES;
            pinBtn.hidden = YES;
            heartBtn.hidden = YES;
            deleteBtn.hidden = NO;
        }
            break;
        case MyTravelsGuideViewFravorite:
        {
            zanBtn.hidden = NO;
            pinBtn.hidden = NO;
            heartBtn.hidden = NO;
            deleteBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)setSquareType:(MySquareViewType)squareType
{
    _squareType = squareType;
    switch (_squareType) {
        case MySquareView:
        {
            deleteBtn.hidden = NO;
            pinBtn.hidden = NO;
            zanBtn.hidden = NO;
            heartBtn.hidden = NO;
        }
            break;
        case MySquareViewFravorite:
        {
            deleteBtn.hidden = YES;
            pinBtn.hidden = YES;
            zanBtn.hidden = YES;
            heartBtn.hidden = YES;
            collecdtionBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)setModel:(LBB_TravelModel *)model
{
    _model = model;
    contentImage.imageURL = model.travelNotePicUrl;
    contentLabel.text  = model.travelNoteName;
    
    timeLabel.text = [NSString stringWithFormat:@"%@",model.releaseDate];
    if(model.dayCount > 0)
    {
          timeLabel.text = [NSString stringWithFormat:@"%@  %@天",model.releaseDate,@(model.dayCount)];
    }
    
    CGFloat deleteWidth = 0.f;
    CGFloat interval = 15.f;
    
    collecdtionBtn.selected = _model.isCollected;
    [collecdtionBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    deleteBtn.left = DeviceWidth - 10 - deleteBtn.width;
    deleteWidth = deleteBtn.width;
    [deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [deleteBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.viewType == MyTravelsGuideViewFravorite) {
        deleteWidth = 0;
        deleteBtn.hidden = YES;
    }
    NSString *heartTitle = getNumTitleStr(_model.totalCollected);
    [heartBtn setTitle:heartTitle forState:0];
    heartBtn.width = [self getWidthWithContent:heartTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    heartBtn.left = DeviceWidth - interval - heartBtn.width - deleteWidth;
    [heartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [heartBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    heartBtn.selected = _model.isCollected;
    
    NSString *pinTitle = getNumTitleStr(_model.totalComment);
    [pinBtn setTitle:pinTitle forState:0];
    pinBtn.width = [self getWidthWithContent:pinTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    pinBtn.left = heartBtn.left - pinBtn.width  - interval;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *zanTitle = getNumTitleStr(_model.totalLike);
    [zanBtn setTitle:zanTitle forState:0];
    zanBtn.width = [self getWidthWithContent:zanTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = pinBtn.left - heartBtn.width - interval;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    zanBtn.selected = _model.isLiked;
    
}

- (void)setGuideModel:(LBB_TravelGuideModel *)guideModel
{
    _guideModel = guideModel;
    contentImage.imageURL = _guideModel.coverImageUrl;
    contentLabel.text  = _guideModel.name;
    timeLabel.text = [NSString stringWithFormat:@"%@",_guideModel.releaseDate];
//    if (_guideModel.releaseDate) {
//        timeLabel.text = [NSString stringWithFormat:@"%@  %@天",_guideModel.releaseDate,@(_guideModel.dayCount)];
//    }

    CGFloat deleteWidth = 0.f;
    CGFloat interval = 15.f;
    
    collecdtionBtn.selected = _guideModel.isCollected;
    [collecdtionBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.left = DeviceWidth - 10 - deleteBtn.width;
    deleteWidth = deleteBtn.width;
    [deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [deleteBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.viewType == MyTravelsGuideViewFravorite) {
        deleteWidth = 0;
        deleteBtn.hidden = YES;
    }
    NSString *heartTitle = getNumTitleStr(_guideModel.collecteNum);
    [heartBtn setTitle:heartTitle forState:0];
    heartBtn.width = [self getWidthWithContent:heartTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    heartBtn.left = DeviceWidth - interval - heartBtn.width - deleteWidth;
    [heartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [heartBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    heartBtn.selected = _guideModel.isCollected;
    
    NSString *pinTitle = getNumTitleStr(_guideModel.commentsNum);
    [pinBtn setTitle:pinTitle forState:0];
    pinBtn.width = [self getWidthWithContent:pinTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    pinBtn.left = heartBtn.left - pinBtn.width  - interval ;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *zanTitle = getNumTitleStr(_guideModel.likeNum);
    [zanBtn setTitle:zanTitle forState:0];
    zanBtn.width = [self getWidthWithContent:zanTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = pinBtn.left - zanBtn.width  - interval ;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    zanBtn.selected = _guideModel.isLiked;
}

- (void)btnFunc:(UIButton *)btn
{
    if (self.viewType == MyTravelsGuideViewFravorite) { //我的收藏-攻略
        if (self.guideCellBlock) {
            if (btn == heartBtn) {
                self.guideCellBlock(self.guideModel,UICollectionViewCellHeart);
            }else if(btn == pinBtn){
                self.guideCellBlock(self.guideModel,UICollectionViewCellComment);
            }else if(btn == zanBtn){
                self.guideCellBlock(self.guideModel,UICollectionViewCellPraise);
            }else if(btn == deleteBtn){
                self.guideCellBlock(self.guideModel,UICollectionViewCellDelete);
            }else if(btn == collecdtionBtn){
                self.guideCellBlock(self.guideModel,UICollectionViewCellCollection);
            }
        }
    }else{
        if (self.cellBlock) {
            if (btn == heartBtn) {
                self.cellBlock(self.model,UICollectionViewCellHeart);
            }else if(btn == pinBtn){
                self.cellBlock(self.model,UICollectionViewCellComment);
            }else if(btn == zanBtn){
                self.cellBlock(self.model,UICollectionViewCellPraise);
            }else if(btn == deleteBtn){
                self.cellBlock(self.model,UICollectionViewCellDelete);
            }else if(btn == collecdtionBtn){
                self.cellBlock(self.model,UICollectionViewCellCollection);
            }
        }
    }
   
}

- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGSize size = sizeOfString(content, CGSizeMake(9999, 35.f), [UIFont systemFontOfSize:font]);
    return size.width;
}

@end
