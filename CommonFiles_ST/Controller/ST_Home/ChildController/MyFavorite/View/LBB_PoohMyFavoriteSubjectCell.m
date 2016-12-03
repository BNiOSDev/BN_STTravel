//
//  LBB_PoohMyFavoriteSubjectCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohMyFavoriteSubjectCell.h"

@implementation LBB_PoohMyFavoriteSubjectCell

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
        [ws.contentView setBackgroundColor:ColorWhite];
        
        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(180));
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-margin);
            make.top.equalTo(ws.bgImageView).offset(margin);
        }];
        
        
        //地址
        
        UILabel* ztTitle = [UILabel new];
        [ztTitle setText:@"专题"];
        [ztTitle setTextColor:ColorWhite];
        [ztTitle setTextAlignment:NSTextAlignmentCenter];
        [ztTitle setFont:Font16];
        [self.contentView addSubview:ztTitle];
        [ztTitle mas_makeConstraints:^(MASConstraintMaker* make){

            make.center.equalTo(ws.bgImageView);
        }];
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setTextColor:ColorWhite];
        [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [self.titleLabel setText:@"观音山梦幻海岸"];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.equalTo(ws.contentView);
            make.bottom.equalTo(ztTitle.mas_top).offset(-3*margin);
        }];
        
        self.checkButton = [UIButton new];
        [self.checkButton setTitle:@"立即查看" forState:UIControlStateNormal];
        [self.checkButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        self.checkButton.layer.borderWidth = SeparateLineWidth;
        self.checkButton.layer.borderColor = ColorWhite.CGColor;
        [self.checkButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.contentView addSubview:self.checkButton];

        [self.checkButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ztTitle.mas_bottom).offset(3*margin);
            make.width.mas_equalTo(AutoSize(230/2));
            make.height.mas_equalTo(AutoSize(60/2));
        }];
        
        //景点价格
        self.subjectLabel = [UILabel new];
        [self.subjectLabel setText:@"鹿岛自拍圣地top5 "];
        [self.subjectLabel setTextColor:ColorGray];
        [self.subjectLabel setFont:Font13];
        [self.contentView addSubview:self.subjectLabel];
        [self.subjectLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-margin);
        }];
    
        
        [self.favoriteButton bk_whenTapped:^{
            /**
             *3.1.4 收藏(已测)
             @parames allSpotsType	Int	1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记 8用户头像 9足迹  10 线路攻略11 美食专题 12民宿专题 13景点专题
             */
            // [ws.model collect:ws.model.allSpotsId];
        }];
    }
    return self;
}

-(void)setModel:(LBB_PoohMyFavoriteSpecialModel*)model{
    
    _model = model;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.titleLabel setText:model.specialName];
    [self.subjectLabel setText:model.content];
    
    @weakify(self);
    //	收藏标志 0未收藏 1：收藏
    [RACObserve(model, isCollected) subscribeNext:^(NSNumber* collected){
        @strongify(self);
        if ([collected intValue] == 0) {
            [self.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        }
        else{
            [self.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        }
    }];
    
}
@end
