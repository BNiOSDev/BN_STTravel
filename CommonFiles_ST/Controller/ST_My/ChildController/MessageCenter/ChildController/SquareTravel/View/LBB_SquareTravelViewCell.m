//
//  LBB_SquareTravelViewCell.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_SquareTravelViewCell.h"

@interface LBB_SquareTravelViewCell()

@property (weak,nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (weak,nonatomic) IBOutlet UILabel *contentLabel;
@property (weak,nonatomic) IBOutlet UILabel *dateLabel;

@end


@implementation LBB_SquareTravelViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLabel.textColor = ColorBlack;
    self.dateLabel.textColor =  ColorLightGray;
    self.contentLabel.font = Font15;
    self.dateLabel.font = Font13;
    self.contentLabel.numberOfLines = 1.f;
    self.userHeadImgView.layer.cornerRadius = 25.f;
    self.userHeadImgView.clipsToBounds = YES;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.contentLabel.text = nil;
    self.dateLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellInfo:(LBB_MessageSquareTravelModel *)cellInfo
{
    _cellInfo = cellInfo;
    NSString *contentText = nil;
    switch (self.messgeType) {
        case eMessageFollow:
            contentText = [NSString stringWithFormat:@"%@关注了您",_cellInfo.userName];
            break;
        case eMessageLike:
            contentText = [NSString stringWithFormat:@"%@赞了您发布的%@%@",_cellInfo.userName,_cellInfo.objTypeName,_cellInfo.objName];
            break;
         
        case eMessageComment:
            contentText = [NSString stringWithFormat:@"%@评论了您发布的%@%@",_cellInfo.userName,_cellInfo.objTypeName,_cellInfo.objName];
            break;
        case eMessageCollection:
            contentText = [NSString stringWithFormat:@"%@收藏了您发布的%@%@",_cellInfo.userName,_cellInfo.objTypeName,_cellInfo.objName];
            break;
        default:
            break;
    }
    if ([contentText length]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentText];
        //下划线 灰色字体
        if ([_cellInfo.objName length] && self.messgeType != eMessageFollow) {
            NSRange rang = [contentText rangeOfString:_cellInfo.objName options:NSBackwardsSearch];
            
            NSDictionary *attributes = @{NSFontAttributeName:self.contentLabel.font,
                                         NSForegroundColorAttributeName:ColorLightGray,
                                         NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle]};
            
            if (rang.location != NSNotFound) {
                NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
                [attributedStr addAttributes:attributes range:NSMakeRange(rang.location, rang.length)];
            }else{
                NSLog(@"Not Found");
            }
        }
        self.contentLabel.attributedText = attributedStr;
    }
    self.dateLabel.text = _cellInfo.createTime;
    if([_cellInfo.userPicUrl length]) {
        [self.userHeadImgView  sd_setImageWithURL:[NSURL URLWithString:_cellInfo.userPicUrl]
                                 placeholderImage:UnLoginDefaultImage];
    }else {
        self.userHeadImgView.image = UnLoginDefaultImage;
    }
}

@end
