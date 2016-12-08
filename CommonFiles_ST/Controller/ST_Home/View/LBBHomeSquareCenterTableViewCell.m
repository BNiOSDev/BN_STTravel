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
        
        
        UIView* sub = [UIView new];
        [self addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(5);
            make.bottom.left.right.equalTo(ws);
            make.height.mas_equalTo(AutoSize(36/2));

        }];
        
        
        self.portraitImageView = [UIImageView new];
        [sub addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.bottom.equalTo(sub);
            make.width.height.mas_equalTo(AutoSize(36/2));
        }];
        self.portraitImageView.layer.cornerRadius = AutoSize(36/2)/2;
        self.portraitImageView.layer.masksToBounds = YES;
        
        self.userLable = [UILabel new];
        [self.userLable setText:@"梁晓欣"];
        [self.userLable setFont:Font12];
        [self.userLable setTextColor:ColorLightGray];
        [sub addSubview:self.userLable];

        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [self.commentsView setTitle:@"32" forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.commentsView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [sub addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(sub).offset(-3);
            make.centerY.equalTo(ws.portraitImageView);
          //  make.height.equalTo(@15);
        }];
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greetView setTitle:@"32" forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [sub addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-8);
            make.centerY.height.equalTo(ws.commentsView);
        }];

        [self.userLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(5);
            make.centerY.equalTo(ws.portraitImageView);
           // make.right.equalTo(ws.greetView.mas_left).offset(-3).priorityLow();
            make.width.lessThanOrEqualTo(@(AutoSize(70)));
        }];
        //[self.userLable setPreferredMaxLayoutWidth:AutoSize(40)];
        
        self.videoButton = [UIButton new];
        [self.videoButton setBackgroundImage:IMAGE(@"景点详情_播放") forState:UIControlStateNormal];
        [self addSubview:self.videoButton];
        [self.videoButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.height.width.mas_equalTo(AutoSize(50));
            make.center.equalTo(ws.bgImageView);
        }];
        
    }
    return self;
}

@end


@implementation LBBHomeSquareCenterTableViewCell
{
    
        RACDisposable* racIsCollected1;
        RACDisposable* racIsLike1;
        RACDisposable* racLikeNum1;
        RACDisposable* racCommentsNum1;

        RACDisposable* racIsCollected2;
        RACDisposable* racIsLike2;
        RACDisposable* racLikeNum2;
        RACDisposable* racCommentsNum2;
    
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
            make.top.equalTo(ws.item1.mas_bottom).offset(interval);
        }];
        
        [self.item1 bk_whenTapped:^{
            
            LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.item2 bk_whenTapped:^{
            
            LBB_TravelCommentController* dest = [[LBB_TravelCommentController alloc]init];
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
       
        
        @weakify(self);
        [self.item1.greetView bk_whenTapped:^{
            @strongify(self);
            
            [self.model1 like:^(NSError* error){
                
            }];
            NSLog(@"item1 greetView touch");
        }];
        [self.item1.favoriteButton bk_whenTapped:^{
            @strongify(self);
            
            NSLog(@"item1 favoriteButton touch");
            [self.model1 collecte:^(NSError* error){
                
            }];
            
        }];
        [self.item1.videoButton bk_addEventHandler:^(id sender){
            
            NSLog(@"videoButton touch");
            LBB_ToWebViewController *webViewController = [[LBB_ToWebViewController alloc]init];
            webViewController.url = [NSURL URLWithString:self.model1.ugcVideoUrl];
            [[self getViewController].navigationController pushViewController:webViewController animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        //model1
    
        [self.item2.greetView bk_whenTapped:^{
            @strongify(self);
            
            [self.model2 like:^(NSError* error){
                
            }];
            NSLog(@"item2 greetView touch");
        }];
        [self.item2.favoriteButton bk_whenTapped:^{
            @strongify(self);
            
            NSLog(@"item2 favoriteButton touch");
            [self.model2 collecte:^(NSError* error){
                
            }];
            
        }];
        [self.item2.videoButton bk_addEventHandler:^(id sender){
            
            NSLog(@"videoButton touch");
            LBB_ToWebViewController *webViewController = [[LBB_ToWebViewController alloc]init];
            webViewController.url = [NSURL URLWithString:self.model2.ugcVideoUrl];
            [[self getViewController].navigationController pushViewController:webViewController animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)setModel1:(BN_HomeUgcList *)model1{
    
    _model1 = model1;
    
    [self.item1.bgImageView sd_setImageWithURL:[NSURL URLWithString:model1.ugcPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.item1.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model1.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.item1.userLable setText:model1.userName];
    self.item1.videoButton.hidden = YES;
    if (model1.ugcType == 2){//视频
        self.item1.videoButton.hidden = NO;
    }
    
    [racIsCollected1 dispose];
    [racIsLike1 dispose];
    [racLikeNum1 dispose];
    [racCommentsNum1 dispose];
    
    @weakify(self);
    racLikeNum1 = [RACObserve(self.model1, likeNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        [self.item1.greetView setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    
    racCommentsNum1 = [RACObserve(self.model1, commentsNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        [self.item1.commentsView setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    
    racIsCollected1 = [RACObserve(self.model1, isCollected) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        if ([num boolValue]) {
            [self.item1.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        }
        else{
            [self.item1.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        }
    }];
    racIsLike1 = [RACObserve(self.model1, isLiked) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        if ([num boolValue]) {
            [self.item1.greetView setImage:IMAGE(@"ST_Home_GreatHL") forState:UIControlStateNormal];
        }
        else{
            [self.item1.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        }
    }];
}

-(void)setModel2:(BN_HomeUgcList *)model2{
    
    _model2 = model2;
    [self.item2.bgImageView sd_setImageWithURL:[NSURL URLWithString:model2.ugcPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.item2.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model2.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.item2.userLable setText:model2.userName];
    self.item2.videoButton.hidden = YES;
    if (model2.ugcType == 2){//视频
        self.item2.videoButton.hidden = NO;
    }
    
    @weakify(self);
    racLikeNum2 = [RACObserve(self.model2, likeNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        [self.item2.greetView setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    
    racCommentsNum2 = [RACObserve(self.model2, commentsNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        [self.item2.commentsView setTitle:[NSString stringWithFormat:@"%d",[num intValue]] forState:UIControlStateNormal];
    }];
    
    racIsCollected2 = [RACObserve(self.model2, isCollected) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        if ([num boolValue]) {
            [self.item2.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        }
        else{
            [self.item2.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        }
    }];
    racIsLike2 = [RACObserve(self.model2, isLiked) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        if ([num boolValue]) {
            [self.item2.greetView setImage:IMAGE(@"ST_Home_GreatHL") forState:UIControlStateNormal];
        }
        else{
            [self.item2.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        }
    }];
}

@end
