//
//  LBB_SetCover_CollectionViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/8.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SetCover_CollectionViewCell.h"
#import "Header.h"

@implementation LBB_SetCover_CollectionViewCell
{
    UIImageView    *selectImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - AUTO(20), AUTO(5), AUTO(15), AUTO(15))];
          selectImage.image = IMAGE(@"zjmweixuanzhong");
        [self addSubview:selectImage];
    }
    return self;
}

@end
