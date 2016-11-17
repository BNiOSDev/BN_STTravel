//
//  LBBHomeTravelRecommendTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeTravelRecommendTableViewCell.h"
#import "LBB_LabelDetailViewController.h"
#import "LBB_SquareSnsFollowViewController.h"

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
        [self.contentView setBackgroundColor:ColorWhite];
        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(12);
            make.height.mas_equalTo(AutoSize(320/2));
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(16);
            make.right.equalTo(ws.contentView).offset(-16);
          //  make.height.width.mas_equalTo(20);
        }];
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            NSLog(@"favoriteButton touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.contentView).offset(16);
            make.width.height.mas_equalTo(AutoSize(35));
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(-45.0/2);
        }];
        [self.portraitImageView setUserInteractionEnabled:YES];
        
        self.userLable = [UILabel new];
        [self.userLable setText:@"梁晓欣"];
        [self.userLable setFont:Font14];
        [self.contentView addSubview:self.userLable];
        [self.userLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(3);
            make.top.equalTo(ws.bgImageView.mas_bottom);
        }];
        
        self.travlTitleLable = [UILabel new];
        [self.travlTitleLable setText:@"厦大行"];
        [self.travlTitleLable setFont:Font14];
        [self.contentView addSubview:self.travlTitleLable];
        [self.travlTitleLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(4);
            make.left.equalTo(ws.portraitImageView);
            make.bottom.equalTo(ws.contentView).offset(-8);
            make.height.greaterThanOrEqualTo(@15);
        }];
        
        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [self.commentsView setTitle:@"1000" forState:UIControlStateNormal];
        [self.commentsView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.contentView addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-8);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(5);
          //  make.height.equalTo(@16);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
            NSLog(@"commentsView touch");
            
        }];
        
        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greetView setTitle:@"1000" forState:UIControlStateNormal];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
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
        [self.specialLabelButton1 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton1.titleLabel setFont:Font13];
        
        self.specialLabelButton2 = [UIButton new];
        [self.specialLabelButton2 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton2.titleLabel setFont:Font13];
        
        self.specialLabelButton3 = [UIButton new];
        [self.specialLabelButton3 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton3.titleLabel setFont:Font13];
        
        self.specialLabelButton4 = [UIButton new];
        [self.specialLabelButton4 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton4.titleLabel setFont:Font13];
        
        self.specialLabelButton5 = [UIButton new];
        [self.specialLabelButton5 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton5 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton5.titleLabel setFont:Font13];
        
        self.specialLabelButton6 = [UIButton new];
        [self.specialLabelButton6 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton6 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton6.titleLabel setFont:Font13];
        
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
        CGFloat width = AutoSize(156/2);
        CGFloat height = AutoSize(36/2);

        [self.specialLabelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-8);
            make.height.mas_equalTo(height);
            make.width.mas_equalTo(width);
            make.bottom.equalTo(ws.bgImageView).offset(-2*interval);
        }];
        
        [self.specialLabelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton1.mas_top).offset(-interval/2);
        }];
        
        [self.specialLabelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton2.mas_top).offset(-interval/2);
        }];
        [self.specialLabelButton4 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton3.mas_top).offset(-interval/2);
        }];
        [self.specialLabelButton5 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton4.mas_top).offset(-interval/2);
        }];
        [self.specialLabelButton6 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.width.height.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton5.mas_top).offset(-interval/2);
        }];
        
        [self.specialLabelButton6 setHidden:YES];
        [self.specialLabelButton5 setHidden:YES];
        [self.specialLabelButton4 setHidden:YES];

     /*   [self.specialLabelButton1 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton1 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        */
        [self.specialLabelButton2 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton2 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.specialLabelButton3 bk_addEventHandler:^(id sender){
            
            NSLog(@"specialLabelButton3 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
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
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        [self.portraitImageView bk_whenTapped:^{
            
            LBB_SquareSnsFollowViewController* dest = [[LBB_SquareSnsFollowViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
        [self.specialLabelButton1 bk_whenTapped:^{
            
            NSLog(@"specialLabelButton1 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
    }
    return self;
}


-(void)setModel:(id)model{
    
    WS(ws);
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://s7.sinaimg.cn/middle/3d312b52gc448d757ad86&690"] placeholderImage:IMAGE(@"poohtest")];
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg"] placeholderImage:IMAGE(@"poohtest")];



}


@end
