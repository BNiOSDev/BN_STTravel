//
//  LBB_Tarvel_Bill_Free_Cell.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_Tarvel_Bill_Free_Cell.h"
#import "Header.h"

@implementation LBB_Tarvel_Bill_Free_Cell
{
    UILabel  *freeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        freeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth - 20, 20)];
        freeLabel.font = FONT(17.0);
        freeLabel.textColor = BLACKCOLOR;
        freeLabel.textAlignment = NSTextAlignmentRight;
        freeLabel.centerY = self.centerY;
        [self addSubview:freeLabel];
    }
    return self;
}

- (void)setFreeMoney:(NSString *)freeMoney
{
    _freeMoney = freeMoney;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共¥%@元",freeMoney]];
    NSRange range = NSMakeRange(1, freeMoney.length + 1);
    [str setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    [freeLabel setAttributedText:str];
}

@end
