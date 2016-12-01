//
//  LBB_Pulish_ImageContain_View.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

//获取屏幕宽高
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//屏幕适配
#define FB_FIX_SIZE_WIDTH(w) (((w) / 375.0) * SCREEN_WIDTH)
#define SET_FIX_SIZE_WIDTH (SCREEN_WIDTH /375.0)
//获取当前app版本
#define IOS_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

//获取适配后的数据大小
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

#define VIEWWIDTH    self.width
#define VIEWHEIGHT  self.height
#define MARGIN  5.0

#import "LBB_Pulish_ImageContain_View.h"
#import "LBB_TipImage_Pulish_ImageView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import <Photos/Photos.h>
#import "LBB_ZJMPhotoList.h"
#import "FZJPhotoModel.h"

@implementation LBB_Pulish_ImageContain_View

{
    LBB_TipImage_Pulish_ImageView         *oneImage;
    LBB_TipImage_Pulish_ImageView         *twoImage;
    LBB_TipImage_Pulish_ImageView         *threeImage;
    LBB_TipImage_Pulish_ImageView         *fourImage;
    LBB_TipImage_Pulish_ImageView         *fiveImage;
    LBB_TipImage_Pulish_ImageView         *sevenImage;
    LBB_TipImage_Pulish_ImageView         *sixImage;
    LBB_TipImage_Pulish_ImageView         *eightImage;
    LBB_TipImage_Pulish_ImageView         *nightImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {

//        self._blockAddTip = ^(UIView *view){
//            NSLog(@"块优质");
//        };
        [self setup];

    }
    return self;
}

- (void)setup
{
    oneImage = [LBB_TipImage_Pulish_ImageView new];
    oneImage.tag = 0;
    twoImage = [LBB_TipImage_Pulish_ImageView new];
    twoImage.tag = 1;
    threeImage = [LBB_TipImage_Pulish_ImageView new];
    threeImage.tag = 2;
    fourImage = [LBB_TipImage_Pulish_ImageView new];
    fourImage.tag = 3;
    fiveImage = [LBB_TipImage_Pulish_ImageView new];
    fiveImage.tag = 4;
    sixImage = [LBB_TipImage_Pulish_ImageView new];
    sixImage.tag = 5;
    sevenImage = [LBB_TipImage_Pulish_ImageView new];
    sevenImage.tag = 6;
    eightImage = [LBB_TipImage_Pulish_ImageView new];
    eightImage.tag = 8;
    nightImage = [LBB_TipImage_Pulish_ImageView new];
    nightImage.tag = 9;
}

- (void)set_blockAddTip:(BlockAddTip)_blockAddTip
{
    if(self._blockAddTip)
    {
        NSLog(@"这NO是空的");
    }
    oneImage._blockAddTip = self._blockAddTip;

    twoImage._blockAddTip = self._blockAddTip;
    
    threeImage._blockAddTip = self._blockAddTip;

    fourImage._blockAddTip = self._blockAddTip;

    fiveImage._blockAddTip = self._blockAddTip;

    sixImage._blockAddTip = self._blockAddTip;

    sevenImage._blockAddTip = self._blockAddTip;

    eightImage._blockAddTip = self._blockAddTip;

    nightImage._blockAddTip = self._blockAddTip;
}

- (void)setImageArray:(NSArray *)imageArray
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    NSMutableArray *pureImageArray = [[NSMutableArray alloc]init];
    for(int i = 0; i < imageArray.count ;i++)
    {
        FZJPhotoModel *model = imageArray[i];
        PHAsset * asset = model.asset;
        [[FZJPhotoTool defaultFZJPhotoTool] getImageByAsset:asset makeSize:CGSizeMake(asset.pixelWidth * scale, asset.pixelHeight * scale) makeResizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *AssetImage) {
            [pureImageArray addObject:AssetImage];
        }];
    }
    _imageArray = [pureImageArray copy];
    
    switch (imageArray.count) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            NSArray *views = @[oneImage];
            [self sd_addSubviews:views];
            [self setImageFor_One];
        }
            break;
        case 2:
        {
            
            NSArray *views = @[oneImage,twoImage];
            [self sd_addSubviews:views];
            [self setImageFor_Two];
        }
            break;
        case 3:
        {
            NSArray *views = @[oneImage,twoImage,threeImage];
            [self sd_addSubviews:views];
            [self setImageFor_Three];
        }
            break;
        case 4:
        {
            NSArray *views = @[oneImage,twoImage,threeImage,fourImage];
            [self sd_addSubviews:views];
            [self setImageFor_Four];
        }
            break;
        case 5:
        {
            NSArray *views = @[oneImage,twoImage,threeImage,fourImage,fiveImage,];
            [self sd_addSubviews:views];
            [self setImageFor_Five];
        }
            break;
        case 6:
        {
            NSArray *views = @[oneImage,twoImage,threeImage,fourImage,fiveImage,sixImage];
            [self sd_addSubviews:views];
            [self setImageFor_Fix];
        }
            break;
        case 7:
        {
            NSArray *views = @[oneImage,twoImage,threeImage,fourImage,fiveImage,sixImage,sevenImage];
            [self sd_addSubviews:views];
            [self setImageFor_Seven];
        }
            break;
        case 8:
        {
            NSArray *views = @[oneImage,twoImage,threeImage,fourImage,fiveImage,sixImage,sevenImage,eightImage];
            [self sd_addSubviews:views];
            [self setImageFor_Eight];
        }
            break;
        case 9:
        {
            NSArray *views = @[oneImage,twoImage,threeImage,fourImage,fiveImage,sixImage,sevenImage,eightImage,nightImage,];
            [self sd_addSubviews:views];
            [self setImageFor_Night];
        }
            break;
        default:
            break;
    }
}

- (void)setImageFor_One
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    oneImage.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0);
    
}
- (void)setImageFor_Two
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,self.width / 2.0 + 2.5)
    .bottomSpaceToView(self,0);
    
    twoImage.sd_layout
    .leftSpaceToView(oneImage,2.5)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0);
    
}
- (void)setImageFor_Three
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[2]];
    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    twoImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,self.width / 2.0 + 2.5)
    .bottomSpaceToView(self,0);
    
    threeImage.sd_layout
    .leftSpaceToView(twoImage,2.5)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0);
    
}
- (void)setImageFor_Four
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[2]];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[3]];
    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,self.width / 2.0 + 2.5)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    twoImage.sd_layout
    .leftSpaceToView(oneImage,2.5)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    threeImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,self.width / 2.0 + 2.5)
    .bottomSpaceToView(self,0);
    
    fourImage.sd_layout
    .leftSpaceToView(threeImage,2.5)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0);
}

- (void)setImageFor_Five
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[2]];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[3]];
    [fiveImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[4]];
    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,self.width / 2.0 + 2.5)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    twoImage.sd_layout
    .leftSpaceToView(oneImage,2.5)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    threeImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,(VIEWWIDTH - 5)/3*2 + 5)
    .bottomSpaceToView(self,0);
    
    fourImage.sd_layout
    .leftSpaceToView(threeImage,2.5)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,(VIEWWIDTH - 5)/3 + 2.5)
    .bottomSpaceToView(self,0);
    
    fiveImage.sd_layout
    .leftSpaceToView(fourImage,2.5)
    .topSpaceToView(oneImage,2.5)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0);
}
- (void)setImageFor_Fix
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[2]];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[3]];
    [fiveImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[4]];
    [sixImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[5]];
    
    CGFloat cellWith = (VIEWWIDTH - 5)/3.0;
    CGFloat cellHeight = (VIEWHEIGHT - 5)/3.0;
    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,cellWith + 2.5)
    .bottomSpaceToView(self,cellHeight + 2.5);
    
    twoImage.sd_layout
    .leftSpaceToView(oneImage,2.5)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(cellHeight);
    
    threeImage.sd_layout
    .leftSpaceToView(oneImage,2.5)
    .topSpaceToView(twoImage,2.5)
    .rightSpaceToView(self,0)
    .heightIs(cellHeight);
    
    fourImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(oneImage,2.5)
    .widthIs(cellWith)
    .bottomSpaceToView(self,0);
    
    fiveImage.sd_layout
    .leftSpaceToView(fourImage,2.5)
    .topSpaceToView(oneImage,2.5)
    .widthIs(cellWith)
    .bottomSpaceToView(self,0);
    
    sixImage.sd_layout
    .leftSpaceToView(fiveImage,2.5)
    .topSpaceToView(oneImage,2.5)
    .widthIs(cellWith)
    .bottomSpaceToView(self,0);
}
- (void)setImageFor_Seven
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[2]];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[3]];
    [fiveImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[4]];
    [sixImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[5]];
    [sevenImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[6]];
    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    UIView  *lastTopView = oneImage;
    UIView  *lastLeftView = self;
    CGFloat cellWith = (VIEWWIDTH - 5)/3.0;
    CGFloat cellHeight = ((VIEWHEIGHT-2.5)/2 - 5)/2.0;
    
    for(int i = 1; i < _imageArray.count;i++)
    {
        LBB_TipImage_Pulish_ImageView  *image = [[LBB_TipImage_Pulish_ImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:nil];
        image._blockAddTip = self._blockAddTip;
        image.tag = i;
        [self addSubview:image];
        CGFloat cellMargin = (i == 1 || i == 4) ? 0:2.5;
        image.sd_layout
        .leftSpaceToView(lastLeftView,cellMargin)
        .topSpaceToView(lastTopView,2.5)
        .widthIs(cellWith)
        .heightIs(cellHeight);
        
        lastLeftView = image;
        if(i == 3)
        {
            lastTopView = image;
            lastLeftView = self;
        }
    }
    
}
- (void)setImageFor_Eight
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[0]];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[1]];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[2]];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[3]];

    
    oneImage.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,self.width / 2.0 + 2.5)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    twoImage.sd_layout
    .leftSpaceToView(oneImage,2.5)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,self.height / 2.0 + 2.5);
    
    UIView  *lastTopView = oneImage;
    UIView  *lastLeftView = self;
    CGFloat cellWith = (VIEWWIDTH - 5)/3.0;
    CGFloat cellHeight = ((VIEWHEIGHT-2.5)/2 - 5)/2.0;
    
    for(int i = 2; i < _imageArray.count;i++)
    {
        LBB_TipImage_Pulish_ImageView  *image = [[LBB_TipImage_Pulish_ImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[i]];
        image._blockAddTip = self._blockAddTip;
        image.tag = i;
        [self addSubview:image];
        CGFloat cellMargin = (i == 2 || i == 5) ? 0:2.5;
        image.sd_layout
        .leftSpaceToView(lastLeftView,cellMargin)
        .topSpaceToView(lastTopView,2.5)
        .widthIs(cellWith)
        .heightIs(cellHeight);
        
        lastLeftView = image;
        if(i == 4)
        {
            lastTopView = image;
            lastLeftView = self;
        }
    }
    
}
- (void)setImageFor_Night
{
    UIView  *lastTopView = self;
    UIView  *lastLeftView = self;
    CGFloat cellWith = (VIEWWIDTH - 5)/3.0;
    CGFloat cellHeight = (VIEWHEIGHT - 5)/3.0;
    
    for(int i = 0; i < _imageArray.count;i++)
    {
        LBB_TipImage_Pulish_ImageView  *image = [[LBB_TipImage_Pulish_ImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:_imageArray[i]];
        image._blockAddTip = self._blockAddTip;
        image.tag = i;
        [self addSubview:image];
        CGFloat cellMargin = (i % 3 == 0) ? 0:2.5;
        image.sd_layout
        .leftSpaceToView(lastLeftView,cellMargin)
        .topSpaceToView(lastTopView,2.5)
        .widthIs(cellWith)
        .heightIs(cellHeight);
        
        lastLeftView = image;
        if((i + 1) % 3 == 0)
        {
            lastTopView = image;
            lastLeftView = self;
        }
    }
    
}


@end
