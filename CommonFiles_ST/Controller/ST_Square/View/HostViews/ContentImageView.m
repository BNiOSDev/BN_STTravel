//
//  ContentImageView.m
//  GSD_WeiXin(wechat)
//
//  Created by dawei che on 2016/10/20.
//  Copyright © 2016年 GSD. All rights reserved.
//

//获取屏幕宽高
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//获取当前app版本
#define IOS_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

//获取适配后的数据大小
#define AUTO(num)  num * SET_FIX_SIZE_WIDTH

#define VIEWWIDTH    self.width
#define VIEWHEIGHT  self.height
#define MARGIN  5.0

#import "ContentImageView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
#import "LBB_TipImage_Pulish_ImageView.h"


@implementation ContentImageView
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
     UITapGestureRecognizer  *tapGesture;//图片点击手势
     UIImageView          *currentImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.width = SCREEN_WIDTH - 75;
        self.height = AUTO(250);
        self.userInteractionEnabled = YES;
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    oneImage = [UIImageView new];
    oneImage.tag = 0;
    twoImage = [UIImageView new];
    twoImage.tag = 1;
    threeImage = [UIImageView new];
    threeImage.tag = 2;
    fourImage = [UIImageView new];
    fourImage.tag = 3;
    fiveImage = [UIImageView new];
    fiveImage.tag = 4;
    sixImage = [UIImageView new];
    sevenImage = [UIImageView new];
    eightImage = [UIImageView new];
    nightImage = [UIImageView new];
    oneImage.userInteractionEnabled = YES;
    twoImage.userInteractionEnabled = YES;
    threeImage.userInteractionEnabled = YES;
    fourImage.userInteractionEnabled = YES;
    fiveImage.userInteractionEnabled = YES;
    sixImage.userInteractionEnabled = YES;
    oneImage.contentMode = UIViewContentModeScaleAspectFill;
    oneImage.clipsToBounds = YES;
    twoImage.contentMode = UIViewContentModeScaleAspectFill;
    twoImage.clipsToBounds = YES;
    threeImage.contentMode = UIViewContentModeScaleAspectFill;
    threeImage.clipsToBounds = YES;
    fourImage.contentMode = UIViewContentModeScaleAspectFill;
    fourImage.clipsToBounds = YES;
    fiveImage.contentMode = UIViewContentModeScaleAspectFill;
    fiveImage.clipsToBounds = YES;
    sixImage.contentMode = UIViewContentModeScaleAspectFill;
    sixImage.clipsToBounds = YES;
//    self.picArray = [temp copy];
}

- (void)prepareForReuse
{
    oneImage.image = nil;
    twoImage.image = nil;
    threeImage.image = nil;
    fourImage.image = nil;
    fiveImage.image = nil;
    sixImage.image = nil;
    sevenImage.image = nil;
    eightImage.image = nil;
    nightImage.image = nil;
}

- (void)showViewSet:(UIView *)imageview
{
    for(UIView *view in [self subviews])
    {
        if(view == imageview)
        {
            view.hidden = NO;
        }else{
            view.hidden = YES;
        }
    }
}

- (void)setImageArray:(NSArray *)imageArray
{
    [self removeAllSubviews];
    [self setup];
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
            [self showViewSet:oneImage];
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
    theOneImage.contentMode = UIViewContentModeScaleAspectFill;
    theOneImage.clipsToBounds = YES;
    [self addSubview:theOneImage];
    [theOneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
//    theOneImage.sd_layout
//    .topSpaceToView(self,0)
//    .leftSpaceToView(self,0)
//    .rightSpaceToView(self,0)
//    .bottomSpaceToView(self,0);
    if(self.tagsArray.count > 0)
            theOneImage.tipArray = self.tagsArray;
    [theOneImage clearNotifi];
}
- (void)setImageFor_Two
{
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    [oneImage addGestureRecognizer:tapone];
    [twoImage addGestureRecognizer:taptwo];
//    [threeImage addGestureRecognizer:tapGesture];
//    [fourImage addGestureRecognizer:tapGesture];
//    [fiveImage addGestureRecognizer:tapGesture];
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
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapthree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    [oneImage addGestureRecognizer:tapone];
    [twoImage addGestureRecognizer:taptwo];
    [threeImage addGestureRecognizer:tapthree];

    
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
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapthree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapfour = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    [oneImage addGestureRecognizer:tapone];
    [twoImage addGestureRecognizer:taptwo];
    [threeImage addGestureRecognizer:tapthree];
    [fourImage addGestureRecognizer:tapfour];
//    [fiveImage addGestureRecognizer:tapGesture];
    
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
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapthree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapfour = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapfive = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    [oneImage addGestureRecognizer:tapone];
    [twoImage addGestureRecognizer:taptwo];
    [threeImage addGestureRecognizer:tapthree];
    [fourImage addGestureRecognizer:tapfour];
    [fiveImage addGestureRecognizer:tapfive];
    
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
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    [twoImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[1]] placeholderImage:DEFAULTIMAGE];
    [threeImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[2]] placeholderImage:DEFAULTIMAGE];
    [fourImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[3]] placeholderImage:DEFAULTIMAGE];
    [fiveImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[4]] placeholderImage:DEFAULTIMAGE];
    [sixImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[5]] placeholderImage:DEFAULTIMAGE];
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapthree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapfour = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapfive = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *tapsex = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    [oneImage addGestureRecognizer:tapone];
    [twoImage addGestureRecognizer:taptwo];
    [threeImage addGestureRecognizer:tapthree];
    [fourImage addGestureRecognizer:tapfour];
    [fiveImage addGestureRecognizer:tapfive];
    [sixImage addGestureRecognizer:tapsex];
    
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
    [oneImage sd_setImageWithURL:[NSURL URLWithString:_imageArray[0]] placeholderImage:DEFAULTIMAGE];
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    [oneImage addGestureRecognizer:tapone];
    
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
        image.tag = i;
        image.userInteractionEnabled = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:DEFAULTIMAGE];
        UITapGestureRecognizer    *tapimage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
        [image addGestureRecognizer:tapimage];
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
    UITapGestureRecognizer    *tapone = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
    UITapGestureRecognizer    *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];

    [oneImage addGestureRecognizer:tapone];
    [twoImage addGestureRecognizer:taptwo];
    
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
        image.tag = i;
        image.userInteractionEnabled = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:DEFAULTIMAGE];
        UITapGestureRecognizer    *tapimage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
        [image addGestureRecognizer:tapimage];
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
        image.tag = i;
        image.userInteractionEnabled = YES;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:DEFAULTIMAGE];
        UITapGestureRecognizer    *tapimage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
        [image addGestureRecognizer:tapimage];
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


- (void)browerImage:(UIGestureRecognizer *)tap
{
    NSLog(@"%ld",tap.view.tag);
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = self; // 原图的父控件
    browserVc.countImage = self.imageArray.count; // 图片总数
    
    currentImageView = (UIImageView *)tap.view;
//    self.currentArray = cell.arrayImageUrl;
    
    browserVc.currentPage = tap.view.tag;
    browserVc.delegate = self;
    [browserVc show];
}

#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    return currentImageView.image;
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.imageArray[index];
    return [NSURL URLWithString:urlStr];
}


//获取控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
