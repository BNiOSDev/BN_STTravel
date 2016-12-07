//
//  LBBVideoCollectionViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBVideoCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "Header.h"

@implementation LBBVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        _contentImage =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,AUTO(43), AUTO(43))];
        [self addSubview:_contentImage];
        
        _pauseImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,AUTO(43), AUTO(43))];
        _pauseImage.image = [UIImage imageNamed:@"zjmbofang"];
        [self addSubview:_pauseImage];
        
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width - AUTO(30), AUTO(10), AUTO(20), AUTO(20))];
        [_selectBtn setBackgroundImage:IMAGE(@"zjmweixuanzhong") forState:0];
        [_selectBtn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
        self.beSelect = NO;
        [self addSubview:_selectBtn];
    }
    return self;
}

- (void)btnFunc:(UIButton *)btn
{
    if(self.beSelect)
    {
        [_selectBtn setBackgroundImage:IMAGE(@"zjmweixuanzhong") forState:0];
        self.beSelect = NO;
    }else{
        [_selectBtn setBackgroundImage:IMAGE(@"zjmxuanzhong") forState:0];
        self.beSelect = YES;
    }
    self._blockVideo(btn.tag,self.beSelect);
}



@end
