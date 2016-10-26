//
//  LBB_DiscoveryMainTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/21.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryMainTableViewCell.h"
#import "LBBPoohGreatItemView.h"
#import "LBB_StarRatingViewController.h"

@implementation LBB_DiscoveryMainTableViewCell{

    UIImageView* imageView;
    UILabel* titleLabel;
    UILabel* contentLabel;
    UILabel* timeLabel;
    LBBPoohGreatItemView* commentsView;
    LBBPoohGreatItemView* greetView;

    
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
            make.top.equalTo(contentLabel.mas_bottom).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-margin);
        }];
        
        //comments
        
        UIView* v = [UIView new];
        [v setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.bottom.equalTo(imageView).offset(-2*margin);
        }];
        
        
        CGFloat margin1 = 5;
        CGFloat width = 18;
        v.layer.cornerRadius = (width+margin1)/2;

        greetView = [[LBBPoohGreatItemView alloc]init];
        [greetView.iconView setImage:IMAGE(@"ST_Home_Great")];
        [greetView.desLabel setText:@"190"];
        [greetView.desLabel setTextColor:[UIColor whiteColor]];
        [v addSubview:greetView];
        [greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(v).offset(margin1);
            make.top.equalTo(v).offset(margin1);
            make.bottom.equalTo(v).offset(-margin1);
            make.height.mas_equalTo(width);
        }];
        [greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        
        commentsView = [[LBBPoohGreatItemView alloc]init];
        [commentsView.iconView setImage:IMAGE(@"ST_Home_Comments")];
        [commentsView.desLabel setText:@"1000"];
        [commentsView.desLabel setTextColor:[UIColor whiteColor]];
        [v addSubview:commentsView];
        [commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(greetView.mas_right).offset(margin1);
            make.centerY.height.equalTo(greetView);
            make.right.equalTo(v).offset(-margin1);
        }];
        
        [commentsView bk_whenTapped:^{
            
            NSLog(@"commentsView touch");
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
        //效果图没有这个
        greetView.hidden = YES;
        commentsView.hidden = YES;

        
    }
    return self;
}


-(void)setModelaaa:(id)model andRow:(NSInteger)row{
    
    if (row%2) {
        [contentLabel setText:@"这是一个很悲伤的故事，SD在某个框架上居然使用不了，我实在是很不理解这一个事情，编码真的太不可思议了,某个框架上居然使用不了，我实在是很不理解这一个事情，编码真的太"];
    }
    else{
        [contentLabel setText:@"asdadjadhqhkhkjasasblkasdhjahajsfhasdhajkdhjhwqiudhdshajksdhquwidhiquhdqjkdh这是一个很悲伤的故事，SD在某个框架上居然使用不了，我实在是很不理解这一个事情，编码真的太不可思议了,某个框架上居然使用不了，我实在是很不理解这一个事情，编码真的太"];

    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [titleLabel setText:@"钟爱SD的男人"];
    [contentLabel setNumberOfLines:0];
    [timeLabel setText:[PoohAppHelper getStringFromDate:[NSDate new] withFormat:DateFormatFullDate]];
    [greetView.desLabel setText:[NSString stringWithFormat:@"%ld",231]];
    [commentsView.desLabel setText:[NSString stringWithFormat:@"%ld",371]];
}

@end
