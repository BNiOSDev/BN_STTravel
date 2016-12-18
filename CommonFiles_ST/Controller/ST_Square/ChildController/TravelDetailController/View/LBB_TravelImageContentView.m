//
//  LBB_TravelImageContentView.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/11.
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

#import "LBB_TravelImageContentView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "LBB_TipImage_Pulish_ImageView.h"

@implementation LBB_TravelImageContentView
{
    UIImageView         *oneImage;
    UIImageView         *twoImage;
    UIImageView         *threeImage;
    UIImageView         *fourImage;
    UIImageView         *fiveImage;
    UIImageView         *sevenImage;
    UIImageView         *sixImage;
    UIImageView         *eightImage;
    UIImageView         *nightImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.width = SCREEN_WIDTH - 20;
        self.height = AUTO(230);
        [self setup];
    }
    return self;
}

- (void)setup
{
    oneImage = [UIImageView new];
    twoImage = [UIImageView new];
    threeImage = [UIImageView new];
    fourImage = [UIImageView new];
    fiveImage = [UIImageView new];
    sixImage = [UIImageView new];
    sevenImage = [UIImageView new];
    eightImage = [UIImageView new];
    nightImage = [UIImageView new];
    
    //    self.picArray = [temp copy];
}

- (void)setImageArray:(NSArray *)imageArray
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeAllSubviews];
    
    _imageArray = imageArray;
    switch (imageArray.count) {
        case 0:
        {
            self.height = 0;
            NSLog(@"没有图片哦");
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
    LBB_TipImage_Pulish_ImageView  *theOneImage = [[LBB_TipImage_Pulish_ImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:theOneImage];
    [theOneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];

    if(self.tagsArray.count > 0)
        theOneImage.tipArray = self.tagsArray;
    [theOneImage clearNotifi];
}
- (void)setImageFor_Two
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    
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
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:DEFAULTIMAGE];
    
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
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:DEFAULTIMAGE];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:DEFAULTIMAGE];
    
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
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:DEFAULTIMAGE];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:DEFAULTIMAGE];
    [fiveImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[4]] placeholderImage:DEFAULTIMAGE];
    
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
    UIImageView         *Image_1 = [UIImageView new];
    UIImageView         *Image_2 = [UIImageView new];
    UIImageView         *Image_3 = [UIImageView new];
    UIImageView         *Image_4 = [UIImageView new];
    UIImageView         *Image_5 = [UIImageView new];
    UIImageView         *Image_6 = [UIImageView new];
    NSArray   *array = @[Image_1,Image_2,Image_3,Image_4,Image_5,Image_6];
    [self sd_addSubviews:array];
    [Image_1 sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [Image_2 sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    [Image_3 sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:DEFAULTIMAGE];
    [Image_4 sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:DEFAULTIMAGE];
    [Image_5 sd_setImageWithURL:[NSURL URLWithString:_imageArray[4]] placeholderImage:DEFAULTIMAGE];
    [Image_6 sd_setImageWithURL:[NSURL URLWithString:_imageArray[5]] placeholderImage:DEFAULTIMAGE];
    
    CGFloat cellWith = (VIEWWIDTH - 5)/3.0;
    CGFloat cellHeight = (VIEWHEIGHT - 5)/3.0;
    
    Image_1.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,cellWith + 2.5)
    .bottomSpaceToView(self,cellHeight + 2.5);
    
    Image_2.sd_layout
    .leftSpaceToView(Image_1,2.5)
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .heightIs(cellHeight);
    
    Image_3.sd_layout
    .leftSpaceToView(Image_1,2.5)
    .topSpaceToView(Image_2,2.5)
    .rightSpaceToView(self,0)
    .heightIs(cellHeight);
    
    Image_4.sd_layout
    .leftSpaceToView(self,0)
    .topSpaceToView(Image_1,2.5)
    .widthIs(cellWith)
    .bottomSpaceToView(self,0);
    
    Image_5.sd_layout
    .leftSpaceToView(Image_4,2.5)
    .topSpaceToView(Image_1,2.5)
    .widthIs(cellWith)
    .bottomSpaceToView(self,0);
    
    Image_6.sd_layout
    .leftSpaceToView(Image_5,2.5)
    .topSpaceToView(Image_1,2.5)
    .widthIs(cellWith)
    .bottomSpaceToView(self,0);
}
- (void)setImageFor_Seven
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    //    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:nil];
    //    [threeImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:nil];
    //    [fourImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:nil];
    //    [fiveImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[4]] placeholderImage:nil];
    //    [sixImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[5]] placeholderImage:nil];
    //    [sevenImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[6]] placeholderImage:nil];
    
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
        UIImageView  *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:DEFAULTIMAGE];
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
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    //    [threeImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:nil];
    //    [fourImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:nil];
    
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
        UIImageView  *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:DEFAULTIMAGE];
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
        UIImageView  *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:DEFAULTIMAGE];
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
