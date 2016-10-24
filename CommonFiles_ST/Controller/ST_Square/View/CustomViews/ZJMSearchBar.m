//
//  ZJMSearchBar.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//
#define SEARCH_WIDTH  DeviceWidth * (2.0/3.0)
#import "ZJMSearchBar.h"

@implementation ZJMSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake((DeviceWidth - SEARCH_WIDTH) / 2.0,5, SEARCH_WIDTH, self.superview.bounds.size.height - 10)];
}

@end
