//
//  LBB_PoohMyFavoriteMainCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PoohMyFavoriteMainCell.h"

@implementation LBB_PoohMyFavoriteMainCell

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
      
        self.titleLabel = [UILabel new];
        [self.titleLabel setTextColor:ColorWhite];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [self.titleLabel setText:@"观音山梦幻海岸"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.bgImageView).offset(2*margin);
        }];
        
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-margin);
            make.top.equalTo(ws.bgImageView).offset(margin);
        }];
        
        
        //地址
        
        UILabel* addTitle = [UILabel new];
        [addTitle setText:@"地址 : "];
        [addTitle setTextColor:ColorGray];
        [addTitle setFont:Font13];
        [self.contentView addSubview:addTitle];
        [addTitle mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(2*margin);
        }];
        
        self.addressLabel = [UILabel new];
        [self.addressLabel setFont:Font13];
        [self.addressLabel setTextColor:ColorGray];
        [self.addressLabel setText:@"厦门呆段端和啊十几块的好看"];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(addTitle.mas_right);
            make.centerY.equalTo(addTitle);
        }];
        
        //景点价格
        self.priceTitleLabel = [UILabel new];
        [self.priceTitleLabel setText:@"景点价格 : "];
        [self.priceTitleLabel setTextColor:ColorGray];
        [self.priceTitleLabel setFont:Font13];
        [self.contentView addSubview:self.priceTitleLabel];
        [self.priceTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(addTitle);
            make.top.equalTo(addTitle.mas_bottom).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-margin);
        }];
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setFont:[UIFont systemFontOfSize:18]];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.priceLabel setText:@"￥120/人"];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(self.priceTitleLabel.mas_right);
            make.centerY.equalTo(self.priceTitleLabel);
        }];
        
        
    
    }
    return self;
}

-(void)setModel:(id)model{
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/13/72/07/55Z58PICKka_1024.jpg"] placeholderImage:IMAGE(@"poohtest")];

}

@end
