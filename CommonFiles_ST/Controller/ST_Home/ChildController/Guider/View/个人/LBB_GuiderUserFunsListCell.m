//
//  LBB_GuiderUserFunsListCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserFunsListCell.h"

@implementation LBB_GuiderUserFunsListCell

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
        
        CGFloat interval = 10;
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(1.5*interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView).offset(-interval);
            make.width.height.mas_equalTo(AutoSize(84/2));
        }];

        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setText:@"厦门鼓浪屿"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.bottom.equalTo(ws.portraitImageView.mas_centerY);
        }];
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:Font13];
        [self.subTitleLabel setTextColor:ColorLightGray];
        [self.subTitleLabel setText:@"船票25/人"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView.mas_right).offset(interval);
            make.top.equalTo(ws.portraitImageView.mas_centerY).offset(5);
        }];
        
        
        self.rightButton = [UIButton new];
        [self.rightButton setBackgroundColor:ColorBtnYellow];
        [self.rightButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightButton.titleLabel setFont:Font12];
        [self.contentView addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.contentView);
            make.right.equalTo(ws).offset(-2*interval);
            make.height.mas_equalTo(AutoSize(36/2));
            make.width.mas_equalTo(AutoSize(88/2));
        }];
        self.rightButton.layer.cornerRadius = 5;
        self.rightButton.layer.masksToBounds = YES;
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        //    make.top.equalTo(ws.portraitImageView.mas_bottom).offset(interval);
        }];
        
        //搜索页面用
        self.vImageView = [UIImageView new];
        [self.vImageView setImage:IMAGE(@"导游_V")];
        [self.contentView addSubview:self.vImageView];
        [self.vImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.titleLabel);
            make.left.equalTo(ws.titleLabel.mas_right).offset(3);
        }];
        
        self.levelButton = [UIButton new];
        [self.levelButton setTitle:@"Lv.29" forState:UIControlStateNormal];
        [self.levelButton setBackgroundColor:ColorBtnYellow];
        [self.levelButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.levelButton.titleLabel setFont:Font10];
        [self.contentView addSubview:self.levelButton];
        [self.levelButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.titleLabel);
            make.left.equalTo(ws.vImageView.mas_right).offset(3);
            make.height.mas_equalTo(AutoSize(12));
        }];
        self.levelButton.layer.cornerRadius = 12/2;
        self.levelButton.layer.masksToBounds = YES;
        
        self.identityLable = [UILabel new];
        [self.identityLable setFont:Font13];
        [self.identityLable setTextColor:ColorBtnYellow];
        [self.identityLable setText:@"健康导游"];
        [self.contentView addSubview:self.identityLable];
        [self.identityLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.levelButton.mas_right).offset(3);
            make.centerY.equalTo(ws.titleLabel);
        }];
        
        self.vImageView.hidden = YES;
        self.levelButton.hidden = YES;
        self.identityLable.hidden = YES;
        
    }
    return self;
}

-(void)setModel:(id)model{
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
}

@end
