//
//  LBB_ScenicDetailCommentsCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailCommentsCell.h"
#import "LBB_StarRatingViewController.h"

@implementation LBB_ScenicDetailCommentsCell

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
        
        CGFloat width = AutoSize(30);
        self.portraitImageView = [UIImageView new];
        self.portraitImageView.layer.cornerRadius = width/2;
        self.portraitImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.width.height.mas_equalTo(width);
        }];
    
        UIImageView* arrow = [UIImageView new];
        [arrow setImage:IMAGE(@"景点详情_小箭头")];
        [self.contentView addSubview:arrow];
        [arrow mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(10);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        self.moreButton = [UIButton new];
        [self.moreButton setTitle:@"全部评论" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.moreButton.titleLabel setFont:Font15];
        [self.contentView addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(arrow.mas_left);
            make.width.mas_equalTo(AutoSize(60));
        }];
        
        self.nickLabel = [UILabel new];
        [self.nickLabel setText:@"pooh"];
        [self.nickLabel setFont:Font15];
        [self.contentView addSubview:self.nickLabel];
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.moreButton.mas_left).offset(-margin);
        }];
        
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:Font15];
        [self.contentLabel setText:@"阿萨德开奖号1的大家都是爱神的箭爱很大的好多打开后打开大号安静的刷卡的就哈肯定会"];
        [self.contentLabel setNumberOfLines:0];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(2* margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        
        CGFloat interval = 10;
        CGFloat imageWidth = (DeviceWidth - 3* margin*2 - 2*interval)/3;
        
        self.imageView1 = [UIImageView new];
        [self.contentView addSubview:self.imageView1];
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(2*margin);
            make.left.equalTo(ws.portraitImageView);
            make.width.height.mas_equalTo(imageWidth);
        }];
        
        self.imageView2 = [UIImageView new];
        [self.contentView addSubview:self.imageView2];
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView1.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
        
        self.imageView3 = [UIImageView new];
        [self.contentView addSubview:self.imageView3];
        [self.imageView3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView2.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
        
        
        self.timeLabel = [UILabel new];
        [self.timeLabel setText:@"2015-09-10"];
        [self.timeLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
        }];
        
        
        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"景区列表_评论") forState:UIControlStateNormal];
        [self.commentsView setTitle:@"1000" forState:UIControlStateNormal];
        [self.commentsView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.contentView addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
            make.centerY.equalTo(ws.timeLabel);
            //make.height.equalTo(@15);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
            NSLog(@"disView touch");
            
        }];
        
        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"景区列表_点赞") forState:UIControlStateNormal];
        [self.greetView setTitle:@"190" forState:UIControlStateNormal];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        [self.greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];

        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(2*margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
          //  make.bottom.equalTo(ws.contentView);
        }];
        
        self.commentsButton = [UIButton new];
        [self.commentsButton setTitle:@"我要评论+" forState:UIControlStateNormal];
        [self.commentsButton setTitleColor:ColorGray forState:UIControlStateNormal];
        self.commentsButton.layer.borderColor = ColorLine.CGColor;
        self.commentsButton.layer.borderWidth = SeparateLineWidth;
        [self.commentsButton.titleLabel setFont:Font13];
        [self.contentView addSubview:self.commentsButton];
        [self.commentsButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(sep.mas_bottom).offset(2*margin);
            make.height.mas_equalTo(AutoSize(62/2));
            make.width.mas_equalTo(AutoSize(174/2));
            make.bottom.equalTo(ws.contentView).offset(-3*margin);

        }];
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

        
        [self.commentsButton bk_whenTapped:^{
        
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
    }
    return self;
}


@end
