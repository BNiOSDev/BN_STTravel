//
//  LBB_GuiderUserHeaderCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserHeaderCell.h"

@implementation LBB_GuiderUserHeaderCell

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
        CGFloat bgHeight = AutoSize(380/2);
        
        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.top.width.equalTo(ws.contentView);
            make.height.mas_equalTo(bgHeight);
        }];
        
        //关注和私信
        CGFloat buttonHeight = AutoSize(15);
        CGFloat buttonWidth = AutoSize(40);
        self.favoriteButton = [UIButton new];
        [self.favoriteButton setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.favoriteButton setImage:IMAGE(@"导游_关注") forState:UIControlStateNormal];
        [self.favoriteButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.favoriteButton.titleLabel setFont:Font10];
        [self.favoriteButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(margin);
            make.right.equalTo(ws.contentView).offset(-margin);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(buttonWidth);
        }];
        self.favoriteButton.layer.cornerRadius = buttonHeight/2;
        self.favoriteButton.layer.masksToBounds = YES;
        
        self.privateLetterButton = [UIButton new];
        [self.privateLetterButton setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.privateLetterButton setImage:IMAGE(@"导游_私信") forState:UIControlStateNormal];
        [self.privateLetterButton setTitle:@"私信" forState:UIControlStateNormal];
        [self.privateLetterButton.titleLabel setFont:Font10];
        [self.privateLetterButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.contentView addSubview:self.privateLetterButton];
        [self.privateLetterButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.width.equalTo(ws.favoriteButton);
            make.right.equalTo(ws.favoriteButton.mas_left).offset(-margin);
        }];
        self.privateLetterButton.layer.cornerRadius = buttonHeight/2;
        self.privateLetterButton.layer.masksToBounds = YES;
        //地点和几张照片
        self.photoNumLabel = [UILabel new];
        [self.photoNumLabel setFont:Font13];
        [self.photoNumLabel setTextColor:ColorWhite];
        [self.photoNumLabel setTextAlignment:NSTextAlignmentRight];
        [self.photoNumLabel setText:@"15张照片"];
        [self.contentView addSubview:self.photoNumLabel];
        [self.photoNumLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-1.5*margin);
            make.bottom.equalTo(ws.bgImageView).offset(-20);
        }];
        
        self.locationLabel = [UILabel new];
        [self.locationLabel setFont:Font13];
        [self.locationLabel setTextColor:ColorWhite];
        [self.locationLabel setTextAlignment:NSTextAlignmentRight];
        [self.locationLabel setText:@"女 福建厦门"];
        [self.contentView addSubview:self.locationLabel];
        [self.locationLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.photoNumLabel);
            make.bottom.equalTo(ws.photoNumLabel.mas_top).offset(-margin);
        }];
        
        //标签
        self.labelButton1 = [UIButton new];
        [self.labelButton1 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton1.titleLabel setFont:Font12];
        [self.labelButton1 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton1];
        [self.labelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(51);
            make.bottom.equalTo(ws.bgImageView).offset(-AutoSize(70/2));
            make.width.mas_equalTo(AutoSize(60));
            make.height.mas_equalTo(AutoSize(15));
        }];
  
        
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton2.titleLabel setFont:Font12];
        [self.labelButton2 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton2];
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.width.height.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton1.mas_top).offset(-10);
        }];
        
        //头像部分
        CGFloat portraitHeight = AutoSize(84/2);
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(-portraitHeight/3);
            make.width.height.mas_equalTo(portraitHeight);
        }];
        self.portraitImageView.layer.cornerRadius = portraitHeight/2;
        self.portraitImageView.layer.masksToBounds = YES;
        self.portraitImageView.userInteractionEnabled = YES;
        
        
        self.nameLabel = [UILabel new];
        [self.nameLabel setText:@"黄灿灿"];
        [self.nameLabel setFont:Font13];
        [self.nameLabel setTextColor:ColorBlack];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(3);
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
        }];
        
        self.vImageView = [UIImageView new];
        [self.vImageView setImage:IMAGE(@"导游_V")];
        [self.contentView addSubview:self.vImageView];
        [self.vImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.nameLabel);
            make.left.equalTo(ws.nameLabel.mas_right).offset(3);
        }];
        
        self.levelButton = [UIButton new];
        [self.levelButton setTitle:@"Lv.29" forState:UIControlStateNormal];
        [self.levelButton setBackgroundColor:ColorBtnYellow];
        [self.levelButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.levelButton.titleLabel setFont:Font10];
        [self.contentView addSubview:self.levelButton];
        [self.levelButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.nameLabel);
            make.left.equalTo(ws.vImageView.mas_right).offset(3);
            make.height.mas_equalTo(AutoSize(12));
        }];
        self.levelButton.layer.cornerRadius = 12/2;
        self.levelButton.layer.masksToBounds = YES;
        
        //点赞
        self.greatButton = [UIButton new];
        [self.greatButton setImage:IMAGE(@"导游_点赞") forState:UIControlStateNormal];
      //  [self.greatButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.greatButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greatButton.titleLabel setFont:Font13];
        [self.greatButton setTitle:@"190" forState:UIControlStateNormal];
        [self.contentView addSubview:self.greatButton];
        [self.greatButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-margin);
            make.centerY.equalTo(ws.nameLabel);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [sep setHidden:YES];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(margin);
        }];
    }
    return self;
}

-(void)setModel:(id)model{
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

}

@end
