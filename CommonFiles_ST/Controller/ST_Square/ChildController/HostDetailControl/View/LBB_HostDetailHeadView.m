//
//  LBB_HostDetailHeadView.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_HostDetailHeadView.h"
#import "ImageContentView.h"
#import "Header.h"

@implementation LBB_HostDetailHeadView
{
    UIImageView *iconImage;
    UILabel          *nameLabel;
    UIImageView *timeImage;
    UIImageView *addImage;
    UILabel          *timeLabel;
    UILabel          *addressLabel;
    
    UILabel          *contentLabel;
    ImageContentView   *_imageContentView;
    PraiseView     *praiseView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    iconImage = [UIImageView new];
    iconImage.backgroundColor = [UIColor redColor];
    [self addSubview:iconImage];
    
    nameLabel = [UILabel new];
    nameLabel.font = FONT(13.0);
    nameLabel.numberOfLines = 1;
    [self addSubview:nameLabel];
    
    timeImage = [UIImageView new];
    [self addSubview:timeImage];
    
    timeLabel = [UILabel new];
    timeLabel.font = FONT(11.0);
    timeLabel.numberOfLines = 1;
    timeLabel.textColor = MORELESSBLACKCOLOR;
    [self addSubview:timeLabel];
    
    addImage = [UIImageView new];
    [self addSubview:addImage];
    
    addressLabel = [UILabel new];
    addressLabel.font = FONT(11.0);
    addressLabel.numberOfLines = 1;
    addressLabel.textColor = MORELESSBLACKCOLOR;
    [self addSubview:addressLabel];
    
    contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:14.0];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:contentLabel];
    
    _imageContentView = [ImageContentView new];
    [self addSubview:_imageContentView];
    
    __weak typeof(self) weakself = self;
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(15.0);
        make.left.equalTo(weakself.mas_left).offset(15.0);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(15.0);
        make.left.equalTo(iconImage.mas_right).offset(5);
        make.right.equalTo(weakself.mas_right).offset(-10);
        
    }];
    nameLabel.text = @"laozhengtoulaozhengtoula";
    
    [timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(5.0);
        make.top.equalTo(nameLabel.mas_bottom).offset(5.0);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage.mas_right).with.offset(5.0);
        make.centerY.equalTo(timeImage);//中间居中就好了
    }];
    timeLabel.text = @"今天去鼓浪屿玩了一下啊";
    
    [addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_right).with.offset(10);
        make.top.equalTo(timeImage.mas_top);
        make.height.equalTo(@15);
        make.width.equalTo(@12);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addImage.mas_right).with.offset(5);
        make.centerY.equalTo(addImage);//中间居中就好了
        
    }];
    addressLabel.text = @"明天再去鼓浪屿浪一下好吗？";
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(5.0);
        make.right.equalTo(weakself.mas_right).offset(-20);
        make.top.equalTo(iconImage.mas_bottom).offset(5.0);
    }];
    
    contentLabel.text = @"妹妹你坐船头啊，哥哥我岸上走，狠狠哈哈牵手荡悠悠。哥哥呀，妹妹我单身呀，晚上一起赏月饮酒呀，可好呀";
    
    [_imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@320);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];

}
@end
