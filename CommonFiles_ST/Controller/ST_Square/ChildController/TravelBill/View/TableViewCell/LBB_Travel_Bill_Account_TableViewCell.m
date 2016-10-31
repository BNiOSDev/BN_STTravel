//
//  LBB_Travel_Bill_Account_TableViewCell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Travel_Bill_Account_TableViewCell.h"
#import "Header.h"
@implementation LBB_Travel_Bill_Account_TableViewCell
{
    UIImageView    *timeImage;
    UIImageView    *arrowImage;
    UILabel             *label;
    UIView              *line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 15, 15)];
    timeImage.image = IMAGE(@"zjmhuangtime");
    timeImage.centerY = self.centerY;
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(timeImage.right + 5, 0, 200, 20)];
    label.font = FONT(15);
    label.textColor = BLACKCOLOR;
    label.text = @"查看消费统计";
    label.centerY = self.centerY;
    
    arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth - 35, 0, 12, 20)];
    arrowImage.image = IMAGE(@"zjmtravelarrow");
    arrowImage.centerY = self.centerY;
    
    line = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottom, DeviceWidth, 1)];
    line.backgroundColor = LINECOLOR;
    
    
    [self.contentView addSubview:timeImage];
    [self.contentView addSubview:label];
    [self.contentView addSubview:arrowImage];
    [self.contentView addSubview:line];

}

@end
