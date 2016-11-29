//
//  LBB_Date_SengeMent.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Date_SengeMent.h"
#import "Header.h"

@implementation LBB_Date_SengeMent
{
    UILabel     *dateLabel;
    UILabel     *timeLabel;
    UILabel     *lineLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width / 2, AUTO(5), 1.0, self.height - AUTO(10))];
        lineLabel.backgroundColor = ColorLine;
        [self addSubview:lineLabel];
        
        UILabel *lineTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 1.0)];
        lineTop.backgroundColor = ColorLine;
        [self addSubview:lineTop];
        
        UILabel *lineBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width, 1.0)];
        lineBottom.backgroundColor = ColorLine;
        [self addSubview:lineBottom];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width / 2, self.height)];
        dateLabel.textColor = MORELESSBLACKCOLOR;
        dateLabel.font = FONT(AUTO(12.0));
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:dateLabel];
        
        UIImageView  *rowImage = [[UIImageView alloc]initWithFrame:CGRectMake(dateLabel.width - AUTO(20), 0, AUTO(5), AUTO(10))];
        rowImage.centerY = self.height / 2;
        rowImage.image = IMAGE(@"zjmarrow");
        [self addSubview:rowImage];
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width / 2.0, 0, self.width / 2, self.height)];
        timeLabel.textColor = MORELESSBLACKCOLOR;
        timeLabel.font = FONT(AUTO(12.0));
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timeLabel];
        
        UIImageView  *rowImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - AUTO(20), 0, AUTO(5), AUTO(10))];
        rowImage2.centerY = self.height / 2;
        rowImage2.image = IMAGE(@"zjmarrow");
        [self addSubview:rowImage2];
        
        UITapGestureRecognizer  *dateGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateFunc:)];
        dateLabel.userInteractionEnabled = YES;
        [dateLabel addGestureRecognizer:dateGes];
        
        UITapGestureRecognizer  *timeGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateFunc:)];
        timeLabel.userInteractionEnabled = YES;
        [timeLabel addGestureRecognizer:timeGes];
        
    }
    return self;
}

- (void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    dateLabel.text = dateStr;
}

- (void)setTimeStr:(NSString *)timeStr
{
    _timeStr = timeStr;
    timeLabel.text = timeStr;
}

- (void)dateFunc:(UITapGestureRecognizer *)tagGes
{
    if(tagGes.view == dateLabel)
    {
        self.blockDatepick(1);
    }else{
        self.blockDatepick(0);
    }
}
@end
