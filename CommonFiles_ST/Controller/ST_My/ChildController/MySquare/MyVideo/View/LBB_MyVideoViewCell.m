//
//  LBB_MyVideoViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyVideoViewCell.h"
#import "LBB_MyContentImgView.h"
#import "Header.h"

@interface LBB_MyVideoViewCell()
{
    LBB_MyContentImgView  *contentImage;
    UIImageView     *playImage;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *deleteBtn;
    EnlargeButton    *collecdtionBtn;
}

@end

@implementation LBB_MyVideoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        [self setup];
    }
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [contentImage prepareForReuse];
    zanBtn.selected = NO;
    collecdtionBtn.selected = NO;
}

- (void)setup
{
    contentImage = [[LBB_MyContentImgView alloc]initWithFrame:CGRectMake(0, 0, AUTO(140),AUTO(140))];
    [self addSubview:contentImage];
    
    collecdtionBtn = [[EnlargeButton alloc]initWithFrame:CGRectMake(self.width - AUTO(35), AUTO(10), AUTO(20), AUTO(15))];
    collecdtionBtn.enlargeInset = UIEdgeInsetsMake(AUTO(10), AUTO(20), AUTO(15), AUTO(10));
    collecdtionBtn.titleLabel.font = FONT(AUTO(11.0));
    [collecdtionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [collecdtionBtn setImage:IMAGE(@"我的_小收藏") forState:UIControlStateNormal];
    [collecdtionBtn setImage:IMAGE(@"我的_小收藏-点击后") forState:UIControlStateSelected];
    [self addSubview:collecdtionBtn];
    [self bringSubviewToFront:collecdtionBtn];
    collecdtionBtn.hidden = YES;

    
    UIImage *tmpImage = IMAGE(@"我的_播放");
    playImage = [[UIImageView alloc] initWithImage:tmpImage];
    playImage.frame = CGRectMake((contentImage.bounds.size.width - tmpImage.size.width)/2.0, (contentImage.bounds.size.height - tmpImage.size.height)/2.0, tmpImage.size.width, tmpImage.size.height);
    [contentImage addSubview:playImage];
    
    deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20, contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    deleteBtn.titleLabel.font = FONT(AUTO(10.0));
    [deleteBtn setTitleColor:[UIColor grayColor] forState:0];
    [deleteBtn setImage:IMAGE(@"我的登录_删除") forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.width = [self getWidthWithContent:@"删除" height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    [self addSubview:deleteBtn];
    
    
    pinBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - deleteBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
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
    pinBtn.exclusiveTouch = YES;
    zanBtn.exclusiveTouch = YES;
}

- (void)setModel:(LBB_MyVideoModel *)model
{
    _model = model;
    
    contentImage.imageURL = model.videoUrl;
    NSMutableArray *tagList = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < _model.tags.count; i++) {
        LBB_MyVideoTagModel *tagModel = _model.tags[i];
        [tagList addObject:tagModel.tagName];
    } 
    contentImage.tagList = tagList;
    collecdtionBtn.selected = _model.isCollected;
    [collecdtionBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat deleteWidth = 0.f;
    
    deleteBtn.left = self.width - 10 - deleteBtn.width;
    deleteWidth = deleteBtn.width;
    [deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [deleteBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *pinTitle = getNumTitleStr(_model.totalComment);
   
    [pinBtn setTitle:pinTitle forState:0];
    pinBtn.width = [self getWidthWithContent:pinTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    pinBtn.left = deleteBtn.left - pinBtn.width - 10;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *zanTitle = getNumTitleStr(_model.totalLike);
    [zanBtn setTitle:zanTitle forState:0];
    zanBtn.width = [self getWidthWithContent:zanTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = pinBtn.left - pinBtn.width - 10;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    zanBtn.selected = _model.isLiked;
}
 
- (void)setSquareType:(MySquareViewType)squareType
{
    _squareType = squareType;
    switch (_squareType) {
        case MySquareVideoView:
        {
            deleteBtn.hidden = NO;
            pinBtn.hidden = NO;
            zanBtn.hidden = NO;
        }
            break;
        case MySquareVideoViewFravorite:
        {
            deleteBtn.hidden = YES;
            pinBtn.hidden = YES;
            zanBtn.hidden = YES;
            collecdtionBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)btnFunc:(UIButton *)btn
{
    if (self.cellBlock) {
        if(btn == pinBtn){
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

- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGSize size = sizeOfString(content, CGSizeMake(9999, 35.f), [UIFont systemFontOfSize:font]);
    return size.width;
}

@end
