//
//  LBB_MyPhotoViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_MyPhotoViewCell.h"
#import "LBBTravelContentImage.h"
#import "Header.h"

@interface LBB_MyPhotoViewCell()
{
    LBBTravelContentImage  *contentImage;
    UIButton    *zanBtn;
    UIButton    *pinBtn;
    UIButton    *deleteBtn;
    EnlargeButton    *collecdtionBtn; //收藏
}

@end

@implementation LBB_MyPhotoViewCell
 
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
}

- (void)setup
{
    contentImage = [[LBBTravelContentImage alloc]initWithFrame:CGRectMake(0, 0, AUTO(140),AUTO(140))];
    [self addSubview:contentImage];
    contentImage.backgroundColor = ColorLine;
    
    collecdtionBtn = [[EnlargeButton alloc]initWithFrame:CGRectMake(self.width - AUTO(35), AUTO(10), AUTO(20), AUTO(15))];
    collecdtionBtn.enlargeInset = UIEdgeInsetsMake(AUTO(10), AUTO(20), AUTO(15), AUTO(10));
    collecdtionBtn.titleLabel.font = FONT(AUTO(11.0));
    [collecdtionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [collecdtionBtn setImage:IMAGE(@"我的_小收藏") forState:UIControlStateNormal];
    [collecdtionBtn setImage:IMAGE(@"我的_小收藏-点击后") forState:UIControlStateSelected];
    [self addSubview:collecdtionBtn];
    [self bringSubviewToFront:collecdtionBtn];
    collecdtionBtn.hidden = YES;
    
    deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20, contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    deleteBtn.titleLabel.font = FONT(AUTO(10.0));
    [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [deleteBtn setImage:IMAGE(@"我的登录_删除") forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.width = [self getWidthWithContent:@"删除" height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    [self addSubview:deleteBtn];
    
    
    pinBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - deleteBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    pinBtn.titleLabel.font = FONT(AUTO(11.0));
    [pinBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [pinBtn setImage:IMAGE(@"zjmcomment") forState:UIControlStateNormal];
    [self addSubview:pinBtn];
    
    zanBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 20 - pinBtn.width - AUTO(5), contentImage.bottom + AUTO(5), AUTO(20), AUTO(15))];
    zanBtn.titleLabel.font = FONT(AUTO(11.0));
    [zanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [zanBtn setImage:IMAGE(@"zjmdianzan") forState:UIControlStateNormal];
    [self addSubview:zanBtn];
    
    
    //屏蔽两个按钮可以同时被点击
    deleteBtn.exclusiveTouch = YES;
    pinBtn.exclusiveTouch = YES;
    zanBtn.exclusiveTouch = YES;
    collecdtionBtn.exclusiveTouch = YES;
}

- (void)setModel:(LBB_MyPhotoModel *)model
{
    _model = model; 
    
    contentImage.imageUrl = model.coverImageUrl;
    
    CGFloat deleteWidth = 0.f;
    
    deleteBtn.left = self.width - 10 - deleteBtn.width;
    deleteWidth = deleteBtn.width;
    [deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [deleteBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
     NSString *pinTitle = [self getNumTitleStr:_model.totalComment];
    [pinBtn setTitle:pinTitle forState:UIControlStateNormal];
    pinBtn.width = [self getWidthWithContent:pinTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    pinBtn.left = self.width - deleteBtn.width - 10 - deleteWidth;
    [pinBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [pinBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *zanTitle = [self getNumTitleStr:_model.totalLike];
    
    [zanBtn setTitle:zanTitle forState:UIControlStateNormal];
    zanBtn.width = [self getWidthWithContent:zanTitle height:AUTO(15) font:AUTO(11.0)] + AUTO(20);
    zanBtn.left = self.width - deleteBtn.width - pinBtn.width - 10 - deleteWidth;
    [zanBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [zanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    collecdtionBtn.selected = _model.isCollected;
   
}
- (NSString *)getNumTitleStr:(int)num
{
    NSString *numstr = @"";
    int tmpNum = num;
    
    int wan = num/10000;
    num = num%10000;
    int qian = num/1000;
    num = num%1000;
    int bai = num/100;
    num = num%100;
    int shi = num/10;
    num = num%10;
    
    if (wan > 0) {
        if (bai > 0) {
            numstr = [NSString stringWithFormat:@"%@.%@%@W",@(wan),@(qian),@(bai)];
        }else if(qian > 0){
            numstr = [NSString stringWithFormat:@"%@.%@W",@(wan),@(qian)];
        }else {
            numstr = [NSString stringWithFormat:@"%@",@(wan)];
        }
    }
    else if (qian > 0) {
        if (shi > 0) {
            numstr = [NSString stringWithFormat:@"%@.%@%@K",@(qian),@(bai),@(shi)];
        }else if(bai > 0){
            numstr = [NSString stringWithFormat:@"%@.%@K",@(qian),@(bai)];
        }else {
            numstr = [NSString stringWithFormat:@"%@K",@(qian)];
        }
        
    }else {
        numstr = [NSString stringWithFormat:@"%@",@(tmpNum)];
    }
    return numstr;
}

- (void)setSquareType:(MySquareViewType)squareType
{
    _squareType = squareType;
    switch (_squareType) {
        case MySquarePhotoView:
        {
        }
            break;
        case MySquarePhotoViewFravorite:
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
         if(btn == pinBtn)
        {
            self.cellBlock(self.model,UICollectionViewCellComment);
        }else if(btn == zanBtn){
            self.cellBlock(self.model,UICollectionViewCellPraise);
        }else if(btn == deleteBtn){
            self.cellBlock(self.model,UICollectionViewCellDelete);
        }else if(btn == collecdtionBtn) {
             self.cellBlock(self.model,UICollectionViewCellCollection);
        }
    }
}

- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(999, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}

@end
