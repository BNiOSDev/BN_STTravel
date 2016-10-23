//
//  LBBTravelContentImage.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/23.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBTravelContentImage.h"
#import "Header.h"

@implementation LBBTravelContentImage
{
    UIImageView     *_contentimage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        _contentimage = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:_contentimage];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [_contentimage  sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DEFAULTIMAGE];
    
}

@end
