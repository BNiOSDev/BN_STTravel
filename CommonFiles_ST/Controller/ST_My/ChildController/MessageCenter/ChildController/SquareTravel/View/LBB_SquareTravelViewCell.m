//
//  LBB_SquareTravelViewCell.m
//  ST_Travel
//
//  Created by dhxiang on 16/11/3.
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

- (void)setCellInfo:(LBB_SquareTravelModelDetail *)cellInfo
{
    _cellInfo = cellInfo;
    if ([_cellInfo.content length]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:_cellInfo.content];
        //下划线 灰色字体
        if ([_cellInfo.underLineContent length]) {
            NSRange rang = [_cellInfo.content rangeOfString:_cellInfo.underLineContent];
            
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
    self.dateLabel.text = _cellInfo.dateStr;
    self.userHeadImgView.image = IMAGE(_cellInfo.imagePath);
}

@end
