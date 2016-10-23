//
//  LGSegment.m
//  LGSegment
//
//  Created by LiGo on 12/19/15.
//  Copyright © 2015 LiGo. All rights reserved.
//

#import "LGSegment.h"
#import "UIViewExt.h"

#define LG_ScreenW [UIScreen mainScreen].bounds.size.width
#define LG_ScreenH [UIScreen mainScreen].bounds.size.height
#define LG_ButtonColor_Selected      [UIColor blackColor]
#define LG_ButtonColor_UnSelected  [UIColor blackColor]
#define LG_BannerColor               [UIColor grayColor]

@interface LGSegment()


@end
@implementation LGSegment
#pragma 初始化
- (id)init {
    if (self = [super init]) {
        [self commonInit];
       
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if ([super initWithCoder:coder]) {
//        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (NSMutableArray *)buttonList
{
    if (!_buttonList)
    {
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}

- (NSMutableArray *)titleList
{
    if (!_titleList)
    {
        _titleList = [NSMutableArray array];
    }
    return _titleList;
}

#pragma mark -- 初始化数据
-(void)commonInit {
    //按钮名称
//    NSMutableArray *titleList = [[NSMutableArray alloc]initWithObjects:@"VC1",@"VC2",@"VC3", nil];
    
    NSMutableArray *titleList = _buttonList;
    
    self.titleList = titleList;
    
    [self createItem:self.titleList];
    
    [self buttonList];
}

+ (instancetype)initWithTitleList:(NSMutableArray *)titleList {
    LGSegment *segment = [[LGSegment alloc]initWithTitleList:titleList];
    segment.titleList = titleList;
    return segment;
}

-(id)initWithTitleList:(NSMutableArray*)titleList
{
    return self;
}

#pragma mark -- 创建顶部btn
- (void)createItem:(NSMutableArray *)item {
    
    int count = (int)self.titleList.count;
    CGFloat marginX = (self.frame.size.width - count * 60)/(count + 1);
    for (int i = 0; i<count; i++) {
        
        NSString *temp = [self.titleList objectAtIndex:i];
        //按钮的X坐标计算，i为列数
//        CGFloat buttonX = marginX + i * (60 + marginX);
        CGFloat buttonX = i * (self.frame.size.width / count);
        UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(0+(self.frame.size.width/count) * i, 0, (self.frame.size.width  /  _buttonList.count), self.frame.size.height)];
        //设置
        buttonItem.tag = i + 1;
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        buttonItem.titleLabel.font = Font2;
        [buttonItem setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];
        
//        [_buttonList addObject:buttonItem];
        //第一个按钮默认被选中
        if (i == 0) {
            CGFloat firstX = buttonX;
            [buttonItem setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
            [self creatBanner:firstX];
        }
        
        buttonX += marginX;
    }
    
}

-(void)creatBanner:(CGFloat)firstX{
    //初始化
    NSInteger account = _titleList.count;
    CALayer *LGLayer = [[CALayer alloc]init];
    LGLayer.backgroundColor = LG_BannerColor.CGColor;
    LGLayer.frame = CGRectMake(0, self.bottom - 2, self.frame.size.width /account, 2);
    // 设定它的frame
//    LGLayer.cornerRadius = 4;// 圆角处理
    [self.layer addSublayer:LGLayer]; // 增加到UIView的layer上面
    self.LGLayer = LGLayer;
}

-(void)buttonClick:(id)sender {
    //获取被点击按钮
    UIButton *btn = (UIButton *)sender;
    
    [btn setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];

    
    CGFloat bannerX = btn.center.x;
    
    [self bannerMoveTo:bannerX];
    [self didSelectButton:btn];
    [self.delegate scrollToPage:(int)(btn.tag - 1)];
    
    
 
}

-(void)moveToOffsetX:(CGFloat)offsetX  AndIndex:(NSInteger)index{
    
    UIButton *bt1 = (UIButton *)[self viewWithTag:1];
    UIButton *bt2 = (UIButton *)[self viewWithTag:2];
    UIButton *btn = (UIButton *)[self viewWithTag:index+1];
    CGFloat bannerX = bt1.center.x;
    CGFloat offSet = offsetX;
    CGFloat addX = offSet/self.frame.size.width*(bt2.center.x - bt1.center.x);

    bannerX += addX;
    
    [self bannerMoveTo:bannerX];
    
    
    [self didSelectButton:btn];
    
}

-(void)moveToButtonIndex:(NSInteger)index
{

}

-(void)bannerMoveTo:(CGFloat)bannerX{
    //基本动画，移动到点击的按钮下面
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(bannerX, 100)];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 0.3;
    //设置代理
    animationGroup.delegate = self;
    //1.3设置动画执行完毕后不删除动画
    animationGroup.removedOnCompletion=NO;
    //1.4设置保存动画的最新状态
    animationGroup.fillMode=kCAFillModeForwards;
    
    //监听动画
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    //动画加入到changedLayer上
    [_LGLayer addAnimation:animationGroup forKey:nil];
}
//点击按钮后改变字体颜色
-(void)didSelectButton:(UIButton*)Button {
    
    
    for(int i = 0;i < _titleList.count;i++)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:i+1];
        if(btn == Button)
        {
            [btn setTitleColor:LG_ButtonColor_Selected forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:LG_ButtonColor_UnSelected forState:UIControlStateNormal];
        }
        
    }
    
}

@end
