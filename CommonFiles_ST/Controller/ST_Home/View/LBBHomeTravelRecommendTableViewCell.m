//
//  LBBHomeTravelRecommendTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeTravelRecommendTableViewCell.h"

@implementation LBBHomeTravelRecommendTableViewCell

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
        
        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(8);
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setBackgroundImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(16);
            make.right.equalTo(ws.contentView).offset(-16);
            make.height.width.mas_equalTo(20);
        }];
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            NSLog(@"favoriteButton touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.contentView).offset(16);
            make.width.height.equalTo(@45);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(-45.0/2);
        }];
        
        self.userLable = [UILabel new];
        [self.userLable setText:@"梁晓欣"];
        [self.userLable setFont:Font5];
        [self.contentView addSubview:self.userLable];
        [self.userLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(3);
            make.top.equalTo(ws.bgImageView.mas_bottom);
        }];
        
        self.travlTitleLable = [UILabel new];
        [self.travlTitleLable setText:@"厦大行"];
        [self.travlTitleLable setFont:Font5];
        [self.contentView addSubview:self.travlTitleLable];
        [self.travlTitleLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(4);
            make.left.equalTo(ws.portraitImageView);
            make.bottom.equalTo(ws.contentView).offset(-8);
            make.height.greaterThanOrEqualTo(@15);
        }];
        
        self.commentsView = [[LBBPoohGreatItemView alloc]init];
        [self.commentsView.iconView setImage:IMAGE(@"ST_Home_Comments")];
        [self.commentsView.desLabel setText:@"1000"];
        [self.contentView addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-8);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(5);
            make.height.equalTo(@16);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
            NSLog(@"commentsView touch");
            
        }];
        
        
        self.greetView = [[LBBPoohGreatItemView alloc]init];
        [self.greetView.iconView setImage:IMAGE(@"ST_Home_Great")];
        [self.greetView.desLabel setText:@"190"];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-3);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        [self.greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        //specialLabelButton
        self.specialLabelButton1 = [UIButton new];
        [self.specialLabelButton1 setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.specialLabelButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton1.titleLabel setFont:Font5];
        
        self.specialLabelButton2 = [UIButton new];
        [self.specialLabelButton2 setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.specialLabelButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton2.titleLabel setFont:Font5];
        
        self.specialLabelButton3 = [UIButton new];
        [self.specialLabelButton3 setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.specialLabelButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton3.titleLabel setFont:Font5];
        
        self.specialLabelButton4 = [UIButton new];
        [self.specialLabelButton4 setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.specialLabelButton4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton4.titleLabel setFont:Font5];
        
        self.specialLabelButton5 = [UIButton new];
        [self.specialLabelButton5 setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.specialLabelButton5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton5.titleLabel setFont:Font5];
        
        self.specialLabelButton6 = [UIButton new];
        [self.specialLabelButton6 setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.specialLabelButton6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton6.titleLabel setFont:Font5];
        
        [self.contentView addSubview:self.specialLabelButton1];
        [self.contentView addSubview:self.specialLabelButton2];
        [self.contentView addSubview:self.specialLabelButton3];
        [self.contentView addSubview:self.specialLabelButton4];
        [self.contentView addSubview:self.specialLabelButton5];
        [self.contentView addSubview:self.specialLabelButton6];

        [self.specialLabelButton1 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.specialLabelButton2 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.specialLabelButton3 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.specialLabelButton4 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.specialLabelButton5 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.specialLabelButton6 setTitle:@"厦门" forState:UIControlStateNormal];

        
        CGFloat interval = 8;
        CGFloat width = 100;
        CGFloat height = 30;

        [self.specialLabelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-8);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.bottom.equalTo(ws.bgImageView).offset(-2*interval);
        }];
        
        [self.specialLabelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton1.mas_top).offset(-interval);
        }];
        
        [self.specialLabelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton2.mas_top).offset(-interval);
        }];
        [self.specialLabelButton4 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton3.mas_top).offset(-interval);
        }];
        [self.specialLabelButton5 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton4.mas_top).offset(-interval);
        }];
        [self.specialLabelButton6 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton5.mas_top).offset(-interval);
        }];
        
        [self.specialLabelButton6 setHidden:YES];
        [self.specialLabelButton5 setHidden:YES];
        [self.specialLabelButton4 setHidden:YES];

        
        [self.specialLabelButton1 bk_addEventHandler:^(id sender){
        
            NSLog(@"specialLabelButton1 touch");
        } forControlEvents:UIControlEventTouchUpInside];
        [self.specialLabelButton2 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton2 touch");
        } forControlEvents:UIControlEventTouchUpInside];
        [self.specialLabelButton3 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton3 touch");
        } forControlEvents:UIControlEventTouchUpInside];
        [self.specialLabelButton4 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton4 touch");
        } forControlEvents:UIControlEventTouchUpInside];
        [self.specialLabelButton5 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton5 touch");
        } forControlEvents:UIControlEventTouchUpInside];
        [self.specialLabelButton6 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton6 touch");
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:[UIConstants getSeperatorLineColor]];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(1.5);
        }];
        
    }
    return self;
}


-(void)setModel:(id)model{
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(@"poohtest")];
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg"] placeholderImage:IMAGE(@"poohtest")];

}

-(CGFloat)getCellHeight{
    
    CGFloat height = 0;
    height = DeviceWidth * 3/4;
   // NSLog(@"getCellHeight:%f",height);
    return height;
    
}


@end
