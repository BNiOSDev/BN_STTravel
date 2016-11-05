//
//  LBB_LabelDetailUserCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailUserCell.h"

@implementation LBB_LabelDetailUserCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        CGFloat interval = 10;
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(interval/2);
            make.top.equalTo(ws.contentView).offset(2*interval);
            make.bottom.equalTo(ws.contentView).offset(-2*interval);
            make.width.height.mas_equalTo(AutoSize(64/2));
        }];
        self.portraitImageView.layer.cornerRadius = 5;
        self.portraitImageView.layer.masksToBounds = YES;
        
        CGFloat height = 8;
        self.vipImageView = [UIImageView new];
        [self.contentView addSubview:self.vipImageView];
        [self.vipImageView mas_makeConstraints:^(MASConstraintMaker* make){

            make.right.equalTo(ws.portraitImageView).offset(AutoSize(height)/2);
            make.width.height.mas_equalTo(AutoSize(height));
            make.bottom.equalTo(ws.portraitImageView);
        }];
        self.vipImageView.layer.cornerRadius = AutoSize(height/2);
        self.vipImageView.layer.masksToBounds = YES;
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font13];
        [self.titleLabel setText:@"梁晓欣打dada"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.top.equalTo(ws.portraitImageView);
        }];
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font10];
        [self.subTitleLabel setTextColor:ColorLightGray];
        [self.subTitleLabel setText:@"89张照片"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.bottom.equalTo(ws.portraitImageView);
        }];
        
     
        self.rightImageView1 = [UIImageView new];
        [self.contentView addSubview:self.rightImageView1];
        
        self.rightImageView2 = [UIImageView new];
        [self.contentView addSubview:self.rightImageView2];
        
        self.rightImageView3 = [UIImageView new];
        [self.contentView addSubview:self.rightImageView3];
        
        [self.rightImageView1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws.contentView).offset(-interval/3);
            make.width.height.mas_equalTo(AutoSize(94/2));
        }];
        
        [self.rightImageView2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws.rightImageView1.mas_left).offset(-interval/3);
            make.width.height.equalTo(ws.rightImageView1);
        }];
        
        [self.rightImageView3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws.rightImageView2.mas_left).offset(-interval/3);
            make.width.height.equalTo(ws.rightImageView1);
        }];
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
    }
    return self;
}

-(void)setModel:(id)model{
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.vipImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

    [self.rightImageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

    [self.rightImageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

    [self.rightImageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

}

@end
