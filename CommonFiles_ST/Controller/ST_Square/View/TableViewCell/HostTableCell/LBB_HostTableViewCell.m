//
//  LBB_HostTableViewCell.m
//  ForXiaMen
//
//  Created by dawei che on 2016/10/24.
//  Copyright © 2016年 jiangming zheng. All rights reserved.
//

#import "LBB_HostTableViewCell.h"
#import "ImageContentView.h"
#import "LBB_CommentView.h"
#import "LBB_CommentTextField.h"

@implementation LBB_HostTableViewCell
{
    UIImageView *iconImage;
    UILabel          *nameLabel;
    UIImageView *timeImage;
    UIImageView *addImage;
    UILabel          *timeLabel;
    UILabel          *addressLabel;
    
    UILabel          *contentLabel;
    ImageContentView   *_imageContentView;
    LBB_CommentView  *_commentView;
    LBB_CommentTextField  *commentText;
    UIImageView             *commentImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    iconImage = [UIImageView new];
    iconImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:iconImage];
    
    nameLabel = [UILabel new];
    [self.contentView addSubview:nameLabel];
    
    timeImage = [UIImageView new];
    timeImage.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:timeImage];
    
    timeLabel = [UILabel new];
    [self.contentView addSubview:timeLabel];
    
    addImage = [UIImageView new];
    addImage.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:addImage];
    
    addressLabel = [UILabel new];
    [self.contentView addSubview:addressLabel];
    
    contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:14.0];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:contentLabel];
    
    _imageContentView = [ImageContentView new];
    [self.contentView addSubview:_imageContentView];
    
    _commentView = [LBB_CommentView new];
    [self.contentView addSubview:_commentView];
    
    commentImage = [UIImageView new];
    [self.contentView addSubview:commentImage];
    
    commentText = [LBB_CommentTextField new];
    [self.contentView addSubview:commentText];
    
    __weak typeof(self) weakself = self;
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentView.mas_top).offset(15.0);
        make.left.equalTo(weakself.contentView.mas_left).offset(15.0);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImage.mas_top);
        make.left.equalTo(iconImage.mas_right).offset(5);
        make.right.equalTo(weakself.contentView).offset(-10);
        
    }];
    nameLabel.text = @"laozhengtoulaozhengtoulaozhengtoulaozhengtoulaozhengtou";
    
    [timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(5.0);
        make.top.equalTo(nameLabel.mas_bottom).offset(5.0);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
    timeLabel.preferredMaxLayoutWidth = 375.0;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage.mas_right).with.offset(5.0);
        make.centerY.equalTo(timeImage);//中间居中就好了
    }];
    timeLabel.text = @"今天去鼓浪屿玩了一下啊";
    
    [addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_right).with.offset(10);
        make.top.equalTo(timeImage.mas_top);
        make.size.equalTo(timeImage);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addImage.mas_right).with.offset(5);
        make.centerY.equalTo(addImage);//中间居中就好了

    }];
    addressLabel.text = @"明天再去鼓浪屿浪一下好吗？";
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage.mas_left);
        make.right.equalTo(weakself.contentView.mas_right).offset(20);
        make.top.equalTo(timeImage.mas_bottom).offset(10.0);
    }];

    contentLabel.text = @"妹妹你坐船头啊，哥哥我岸上走，狠狠哈哈牵手荡悠悠。哥哥呀，妹妹我单身呀，晚上一起赏月饮酒呀，可好呀";
    
    [_imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(5);
        make.left.equalTo(contentLabel.mas_left);
        make.right.equalTo(contentLabel.mas_right);
        make.height.equalTo(@250);
    }];

}
- (void)setSetModel:(NSString *)setModel
{
    _setModel = setModel;
    nameLabel.text = @"laozhengtou";
    
}
- (void)setEntity:(HostModel *)entity
{
    _entity = entity;
    _imageContentView.imageArray = entity.imageArray;
    _commentView.commentArray = entity.commentArray;
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageContentView.mas_bottom).offset(5.0);
        make.left.equalTo(_imageContentView.mas_left);
        make.right.equalTo(_imageContentView.mas_right);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    _commentView.backgroundColor = [UIColor redColor];
    
    [commentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentView.mas_bottom).offset(10);
        make.left.equalTo(_imageContentView.mas_left);
        make.right.equalTo(_imageContentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
}
@end
