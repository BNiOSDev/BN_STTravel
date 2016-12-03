//
//  LBB_DiscoveryMainTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryMainTableViewCell.h"
#import "LBB_StarRatingViewController.h"

@implementation LBB_DiscoveryMainTableViewCell{

    UIImageView* imageView;
    UILabel* titleLabel;
    UILabel* contentLabel;
    UILabel* timeLabel;
    UIButton* commentsButton;
    UIButton* greatButton;

    
}

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
        
        imageView = [UIImageView new];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(340/2));
        }];
        
        CGFloat margin = 8;
        
        titleLabel = [UILabel new];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(imageView.mas_bottom).offset(margin);
        }];
        
        contentLabel = [UILabel new];
        [contentLabel setFont:Font12];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        [contentLabel setNumberOfLines:0];
        [contentLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(titleLabel.mas_bottom).offset(margin);
            make.left.equalTo(ws.contentView).offset(4*margin);
            make.right.equalTo(ws.contentView).offset(-4*margin);

        }];
        
        timeLabel = [UILabel new];
        [timeLabel setFont:Font12];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(contentLabel.mas_bottom).offset(0/*margin*/);
            make.bottom.equalTo(ws.contentView).offset(-margin);
        }];
        
        //comments
        
        UIView* v = [UIView new];
        [v setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.bottom.equalTo(imageView).offset(-2*margin);
        }];
       [v setHidden:YES];
        
        CGFloat margin1 = 5;
        CGFloat width = 18;
        v.layer.cornerRadius = (width+margin1)/2;

        greatButton = [[UIButton alloc]init];
        [greatButton setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [greatButton setTitle:@"190" forState:UIControlStateNormal];
        [greatButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [greatButton.titleLabel setFont:Font12];
        [v addSubview:greatButton];
        [greatButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(v).offset(margin1);
            make.top.equalTo(v).offset(margin1);
            make.bottom.equalTo(v).offset(-margin1);
           // make.height.mas_equalTo(width);
        }];
        [greatButton bk_whenTapped:^{
            
            NSLog(@"greatButton touch");
            
        }];
        
        
        commentsButton = [[UIButton alloc]init];
        [commentsButton setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [commentsButton setTitle:@"1000" forState:UIControlStateNormal];
        [commentsButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [commentsButton.titleLabel setFont:Font12];
        [v addSubview:commentsButton];
        [commentsButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(greatButton.mas_right).offset(margin1);
            make.centerY.height.equalTo(greatButton);
            make.right.equalTo(v).offset(-margin1);
        }];
        
        [commentsButton bk_whenTapped:^{
            
            NSLog(@"commentsButton touch");
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
    }
    return self;
}

-(void)setModel:(LBB_DiscoveryModel *)model{

    _model = model;
    [contentLabel setText:model.lineDesc];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.coverImageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [titleLabel setText:model.name];
    [contentLabel setNumberOfLines:0];
}

@end
