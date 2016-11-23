//
//  LBB_ImageCollect_TableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ImageCollect_TableViewCell.h"
#import "Header.h"

@implementation LBB_ImageCollect_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 105, 70)];
        _image.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeCenter;
        _image.clipsToBounds = YES;
        [self addSubview:_image];
        
        _collectName = [[UILabel alloc]initWithFrame:CGRectMake(_image.right + 15, _image.top + 5, 300, 20)];
        _collectName.textColor = BLACKCOLOR;
        _collectName.font = FONT(16.0);
        [self addSubview:_collectName];
        
        _number = [[UILabel alloc]initWithFrame:CGRectMake(_image.right + 15, _collectName.bottom + 5, 300, 20)];
        _number.textColor = MORELESSBLACKCOLOR;
        _number.font = FONT(14.0);
        [self addSubview:_number];
    }
    return self;
}

@end
