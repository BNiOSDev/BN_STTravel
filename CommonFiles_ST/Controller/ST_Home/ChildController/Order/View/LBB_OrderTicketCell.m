//
//  LBB_OrderTicketCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/28.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderTicketCell.h"

@implementation LBB_OrderTicketCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat margin = 8;
        
        self.imgView = [UIImageView new];
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.equalTo(ws.contentView).offset(2*margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);
            make.width.height.mas_equalTo(AutoSize(80));
        }];
        
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setFont:Font15];
        [self.priceLabel setTextColor:[UIColor redColor]];
        [self.priceLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.imgView);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        
        self.nameLabel = [UILabel new];
        [self.nameLabel setNumberOfLines:0];
        [self.nameLabel setFont:Font15];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imgView.mas_right).offset(2*margin);
            make.top.equalTo(ws.imgView);
            make.right.equalTo(ws.priceLabel.mas_left).offset(-margin);

        }];
        
        self.typeLabel = [UILabel new];
        [self.typeLabel setFont:Font13];
        [self.typeLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView).offset(2*margin);
            make.left.equalTo(ws.nameLabel);
            make.top.equalTo(ws.nameLabel.mas_bottom).offset(margin);
        }];
        
        

        
        self.numLabel = [UILabel new];
        [self.numLabel setFont:Font15];
        [self.numLabel setTextColor:[UIColor blackColor]];
        [self.numLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.equalTo(ws.imgView);
            make.right.equalTo(ws.priceLabel);
        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        self.lineView = sep2;
        
    }
    return self;
}

-(void)setModel:(id)model{

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.nameLabel setText:@"观音山水世界全套观音山水世界全套观音山水世界全套观音山水世界全套"];
    [self.typeLabel setText:@"成人票"];
    [self.priceLabel setText:@"￥68.88"];
    [self.numLabel setText:@"x2"];

}

@end
