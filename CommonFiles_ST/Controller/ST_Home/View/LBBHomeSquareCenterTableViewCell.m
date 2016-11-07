//
//  LBBHomeSquareCenterTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeSquareCenterTableViewCell.h"
#import "LBB_TravelCommentController.h"


@implementation LBBHomeSquareCenterTableViewCellItem

-(id)init{
    WS(ws);
    if (self = [super init]) {
        
        self.bgImageView = [UIImageView new];
      //  [self.bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.top.equalTo(ws);
            make.height.equalTo(ws.bgImageView.mas_width);
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"PoohFavorite") forState:UIControlStateNormal];
        [self addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws).offset(10);
            make.right.equalTo(ws).offset(-10);
            make.height.width.mas_equalTo(20);
        }];
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            NSLog(@"favoriteButton touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView* sub = [UIView new];
        [self addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(8);
            make.bottom.left.right.equalTo(ws);
            make.height.equalTo(@35);

        }];
        
        
        self.portraitImageView = [UIImageView new];
        [sub addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.bottom.equalTo(sub);
            make.width.equalTo(@35);
        }];
        self.portraitImageView.layer.cornerRadius = 35/2;
        self.portraitImageView.layer.masksToBounds = YES;
        
        
        self.userLable = [UILabel new];
        [self.userLable setText:@"梁晓欣"];
        [self.userLable setFont:Font12];
        [self.userLable setTextColor:ColorLightGray];
        [sub addSubview:self.userLable];
        [self.userLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(5);
            make.centerY.equalTo(ws.portraitImageView);
        }];

        
        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [self.commentsView setTitle:@"32" forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.commentsView setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.commentsView setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, -1)];
        [sub addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(sub).offset(-3);
            make.centerY.equalTo(ws.portraitImageView);
          //  make.height.equalTo(@15);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
            NSLog(@"commentsView touch");
            
        }];
        
        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greetView setTitle:@"32" forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
        [self.greetView setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.greetView setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, -1)];
        [sub addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-8);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        [self.greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        self.videoButton = [UIButton new];
        [self.videoButton setBackgroundImage:IMAGE(@"景点详情_播放") forState:UIControlStateNormal];
        [self addSubview:self.videoButton];
        [self.videoButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.height.width.mas_equalTo(AutoSize(50));
            make.center.equalTo(ws.bgImageView);
        }];
        
        [self.videoButton bk_addEventHandler:^(id sender){
            
            NSLog(@"videoButton touch");
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

@end


@implementation LBBHomeSquareCenterTableViewCell

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
     
        self.item1 = [[LBBHomeSquareCenterTableViewCellItem alloc]init];
        self.item2 = [[LBBHomeSquareCenterTableViewCellItem alloc]init];
        
        self.sep = [UIView new];
        [self.sep setBackgroundColor:ColorLine];
        
        [self.contentView addSubview:self.item1];
        [self.contentView addSubview:self.item2];
        [self.contentView addSubview:self.sep];

        
        CGFloat interval = 8;
        [self.item1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(interval);
            make.top.equalTo(ws.contentView);
        }];
        
        [self.item2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.item1.mas_right).offset(interval);
            make.top.equalTo(ws.contentView);
            make.right.equalTo(ws.contentView).offset(-interval);
            make.width.height.equalTo(ws.item1);
        }];
        
        [self.sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.item1.mas_bottom).offset(2*interval);
        }];
        
    }
    return self;
}


-(void)setModel:(id)model{
    
    WS(ws);
    
    [self.item2.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    [self.item2.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    [self.item1.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    [self.item1.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/8c1001e93901213fcea979fb51e736d12f2e957a.jpg"] placeholderImage:IMAGE(@"poohtest")];
    
    [self.item1 bk_whenTapped:^{
        
        LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
        [[ws getViewController].navigationController pushViewController:dest animated:YES];
        
    }];
    [self.item2 bk_whenTapped:^{
        
        LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
        [[ws getViewController].navigationController pushViewController:dest animated:YES];
        
    }];
    
}


@end
