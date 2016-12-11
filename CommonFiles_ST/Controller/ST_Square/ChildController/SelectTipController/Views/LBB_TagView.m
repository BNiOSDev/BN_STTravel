//
//  LBB_TagView.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TagView.h"
#import "Header.h"
#import "NSString+TPCategory.h"
#import "LBB_LabelDetailViewController.h"

@implementation LBB_TagView
{
    UILabel    *tagTitle;
    UIImageView  *tagImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        tagImage = [[UIImageView alloc]init];
        tagImage.origin = CGPointMake(0, 0);
        tagImage.size = self.size;
        UIImage *image =  [[UIImage imageNamed:@"zjmtag"] stretchableImageWithLeftCapWidth:40 topCapHeight:0];
        tagImage.image = image;
//        [self addSubview:tagImage];
        [self setBackgroundImage:image forState:0];
        
        tagTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.width - 15, self.height)];
        tagTitle.textColor = ColorWhite;
        tagTitle.numberOfLines = 1;
        tagTitle.font = FONT(AUTO(11.0));
        tagTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tagTitle];
        
//        [self addTarget:self action:@selector(selfFunc) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setTagTitleStr:(NSString *)tagTitleStr
{
    _tagTitleStr = tagTitleStr;
    tagTitle.text = tagTitleStr;
    NSDictionary *attributes = @{NSFontAttributeName:tagTitle.font};
    CGRect rect = [tagTitle.text boundingRectWithSize:CGSizeMake(self.superview.width - 20, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    //大小修配修改
    UIImage *image =  [UIImage imageNamed:@"zjmtag"];
    if((rect.size.width + 23) < image.size.width)
    {
        tagTitle.width = image.size.width - 15;
        self.width = image.size.width;
    }else{
        tagTitle.width = rect.size.width + 3;
        self.width = rect.size.width + 23;
    }
    self.height = image.size.height;
    tagTitle.height = self.height;
    
    if(_blockTagFunc)
    {
        self.blockTagFunc(self);
    }
}

#pragma mark -- 跳转标签详情
- (void)selfFunc
{
    LBB_LabelDetailViewController  *vc = [[LBB_LabelDetailViewController alloc]init];
    vc.viewModel = self.tagModel;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LBB_LabelDetailViewController  *vc = [[LBB_LabelDetailViewController alloc]init];
    vc.viewModel = self.tagModel;
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

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
