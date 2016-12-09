//
//  LBB_TagView.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TagView.h"
#import "Header.h"
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
        tagImage.image = IMAGE(@"zjmtag");
        [self addSubview:tagImage];
        
        tagTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.width - 15, self.height)];
        tagTitle.textColor = ColorWhite;
        tagTitle.font = FONT(AUTO(11.0));
        tagTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tagTitle];
    }
    return self;
}

- (void)setTagTitleStr:(NSString *)tagTitleStr
{
    _tagTitleStr = tagTitleStr;
    tagTitle.text = tagTitleStr;
}

@end
