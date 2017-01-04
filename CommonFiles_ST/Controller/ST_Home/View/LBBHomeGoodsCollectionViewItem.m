//
//  LBBHomeGoodsCollectionViewItem.m
//  ST_Travel
//
//  Created by 许为锴 on 2016/12/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeGoodsCollectionViewItem.h"
#import "PoohCommon.h"


@interface LBBHomeGoodsCollectionViewItem()
{
    RACDisposable* racIsCollected;
    RACDisposable* racIsLike;
    RACDisposable* racLikeNum;
    
}

@end

@implementation LBBHomeGoodsCollectionViewItem


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    WS(ws);
    if (self) {
        
        self.mainImageView = [UIImageView new];
        self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.mainImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(186/2));
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(5);
            make.right.equalTo(ws.contentView).offset(-5);
            // make.height.width.mas_equalTo(25);
        }];
        
        
        self.titleLabel = [UILabel new];
        
        [self.titleLabel setFont:AutoFont(10)];
        [self.titleLabel setText:@"曾厝垵"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.right.equalTo(ws.contentView);
            make.top.equalTo(ws.mainImageView.mas_bottom).offset(8);
            
        }];
        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greetView setTitle:@"1000" forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:AutoFont(10)];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(8);
            make.bottom.equalTo(ws.contentView).offset(-3);
            //  make.height.equalTo(@16);
        }];
        
        self.disView = [[UIButton alloc]init];
        [self.disView setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [self.disView setTitle:@"1000" forState:UIControlStateNormal];
        [self.disView.titleLabel setFont:AutoFont(10)];
        [self.disView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.disView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [self.contentView addSubview:self.disView];
        [self.disView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.greetView.mas_right).offset(3);
            make.centerY.height.equalTo(ws.greetView);
            
        }];
        self.disView.hidden = YES;
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setText:@"120元起/人"];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.priceLabel setFont:Font8];
        [self.priceLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView);
            make.centerY.height.equalTo(ws.greetView);
        }];
        
        [self layoutSubviews];//it must to be done to layouts subviews
        
        [self.greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            [ws.model like:^(NSError* error){
                NSLog(@"like error:%@",error);
                
            }];
        }];
        
        [self.disView bk_whenTapped:^{
            
            
        }];
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            [ws.model collecte:^(NSError* error){
                NSLog(@"collecte error:%@",error);
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


-(void)setModel:(BN_HomeHotGoodsObject *)model{
    
    _model = model;

    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:IMAGE(PlaceHolderImage)];//场景图片
    [self.titleLabel setText:model.name];//场景名称
    [self.disView setTitle:[NSString stringWithFormat:@"%d",model.total_comment] forState:UIControlStateNormal];//评论条数
 //   [self.greetView setTitle:[NSString stringWithFormat:@"%d",model.total_like] forState:UIControlStateNormal];//点赞条数
    
    //单价设置
    NSString* strFormat1 = [NSString stringWithFormat:@"%@元起/人",model.front_price];
    NSString* strFormat2 = @"元";
    UIColor* fontColor = ColorBtnYellow;
    NSDictionary* attrsDic = @{NSForegroundColorAttributeName:fontColor,
                               NSFontAttributeName:AutoFont(10)};    //显示的字符串进行富文本转换
    NSMutableAttributedString* strAttr = [[NSMutableAttributedString alloc]initWithString:strFormat1];
    //字体设置
    NSRange rang = [strFormat1 rangeOfString:strFormat2];
    if (rang.location != NSNotFound) {
        NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
        [strAttr addAttributes:attrsDic range:NSMakeRange(0, rang.location)];
    }else{
        NSLog(@"Not Found");
    }
    self.priceLabel.attributedText = strAttr;
    
    [racIsCollected dispose];
    [racIsLike dispose];
    [racLikeNum dispose];
    
    
    @weakify (self);
    racIsCollected = [RACObserve(model, is_collect) subscribeNext:^(NSNumber* isCollected) {
        @strongify(self);
        
        BOOL status = [isCollected boolValue];
        
        if (status) {
            [self.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        }
        else{
            [self.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        }
    }];
    
    racIsLike = [RACObserve(model, is_like) subscribeNext:^(NSNumber* isLiked) {
        @strongify(self);
        BOOL status = [isLiked boolValue];
        if (status) {
            [self.greetView setImage:IMAGE(@"ST_Home_GreatHL") forState:UIControlStateNormal];
        }
        else{
            [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        }
        
    }];
    
    racLikeNum = [RACObserve(model, total_like) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        int status = [num intValue];
        [self.greetView setTitle:[NSString stringWithFormat:@"%d",status] forState:UIControlStateNormal];//点赞次数
    }];
    
}

@end
