//
//  LBB_TicketCommentPicturViewCell.m
//  Textdd
//
//  Created by dhxiang on 16/11/1.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#import "LBB_TicketCommentPicturViewCell.h"
#import "TicketCommentDef.h"

@interface LBB_TicketCommentPicturViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIImageView *defaultImgView;

@end

@implementation LBB_TicketCommentPicturViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.exclusiveTouch = YES;
    
    self.layer.borderColor = ColorLine.CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.iconImgView.image = nil;
    self.defaultImgView.image = nil;
}

- (void)setCellInfo:(NSDictionary *)cellInfo
{
    _cellInfo = cellInfo;
    UIImage *picture = [_cellInfo objectForKey:PictureKey];
    self.isDefault = [[_cellInfo objectForKey:DefaultKey] boolValue];
    self.iconImgView.image = picture;
    if (self.isDefault) {
        self.iconImgView.image = nil;
        self.defaultImgView.image = picture;
    }else{
       self.defaultImgView.image = nil;
       self.iconImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

@end
