//
//  LBB_GuiderUserHeaderCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserHeaderCell.h"
#import "LBB_LabelDetailViewController.h"
@implementation LBB_GuiderUserHeaderCell{

    RACDisposable* racIsFollow;
    RACDisposable* racIsLike;
    RACDisposable* racLikeNum;
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
        [self.favoriteButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
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
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            [ws.model attention:^(NSError* error){
            
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        self.privateLetterButton = [UIButton new];
        [self.privateLetterButton setBackgroundColor:[UIColor colorWithRGBA:0x000000a0]];
        [self.privateLetterButton setImage:IMAGE(@"导游_私信") forState:UIControlStateNormal];
        [self.privateLetterButton setTitle:@"私信" forState:UIControlStateNormal];
        [self.privateLetterButton.titleLabel setFont:Font10];
        [self.privateLetterButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
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
        [self.greatButton bk_addEventHandler:^(id sender){
            
            [ws.model like:^(NSError* error){
                
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        
        
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

-(void)setModel:(LBB_UserShowViewModel*)model{
    
    _model = model;
    NSLog(@"model.coverImg:%@",model.coverImg);
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:IMAGE(PlaceHolderImage)];// 封面图片
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];// 用户头像
    [self.nameLabel setText:model.userName];// 用户名称
    
    // 0女  1男  2未知（保密)
    switch (model.gender) {
        case 0:
            [self.locationLabel setText:[NSString stringWithFormat:@"女 %@",model.area]];// 地址区域名称
            break;
        case 1:
            [self.locationLabel setText:[NSString stringWithFormat:@"男 %@",model.area]];// 地址区域名称
            break;
        case 2:
            [self.locationLabel setText:[NSString stringWithFormat:@"保密 %@",model.area]];// 地址区域名称
            break;
        default:
            [self.locationLabel setText:[NSString stringWithFormat:@"女 %@",model.area]];// 地址区域名称
            break;
    }
    
    [self.photoNumLabel setText:[NSString stringWithFormat:@"%d张照片",model.photoNum]];// 照片数量
    [self.levelButton setTitle:[NSString stringWithFormat:@"Lv.%d",model.level] forState:UIControlStateNormal];// 级别
    
    [racIsLike dispose];
    [racLikeNum dispose];
    [racIsFollow dispose];

    @weakify(self);
    racIsFollow = [RACObserve(model, isFollow) subscribeNext:^(NSNumber* follow){
        @strongify(self);
        int status = [follow intValue];
        if (status == 0) {//未关注
            [self.favoriteButton setImage:IMAGE(@"导游_关注") forState:UIControlStateNormal];
        }
        else{
            [self.favoriteButton setImage:IMAGE(@"导游_关注HL") forState:UIControlStateNormal];
        }
    }];
    racIsLike = [RACObserve(model, isLiked) subscribeNext:^(NSNumber* like){
        @strongify(self);
        int status = [like intValue];
        if (status == 0) {//未点赞
            [self.greatButton setImage:IMAGE(@"导游_点赞") forState:UIControlStateNormal];
        }
        else{
            [self.greatButton setImage:IMAGE(@"导游_点赞HL") forState:UIControlStateNormal];
        }
    }];
    racLikeNum = [RACObserve(model, likeNum) subscribeNext:^(NSNumber* like){//点赞数
        @strongify(self);
        int num = [like intValue];
        [self.greatButton setTitle:[NSString stringWithFormat:@"%d",num] forState:UIControlStateNormal];
    }];
    
    [self setTagViews];
}



- (void)setTagViews
{
    WS(ws);
    NSInteger baseTagNum = 432;
    for(UIView *view in [self.contentView subviews])
    {
        if([view isKindOfClass:[UIButton class]])
        {
            if (view.tag >= baseTagNum) {
                [view removeFromSuperview];
            }
        }
    }
    CGFloat interval = 8;
    
    UIView* lastView = nil;
    for(int i = 0;i < _model.tags.count;i++)
    {
        
        BN_HomeTag* homeTags = [_model.tags objectAtIndex:i];
        NSString *content = [NSString stringWithFormat:@"   %@",homeTags.tagName];
        UIFont *font = AutoFont(11);
        CGSize size = CGSizeMake(MAXFLOAT, AutoSize(18));
        CGSize buttonSize = [content boundingRectWithSize:size
                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{ NSFontAttributeName:font}
                                                  context:nil].size;
        
        NSLog(@"AutoSize(18):%f",AutoSize(18));
        NSLog(@"buttonSize.height:%f",buttonSize.height);
        NSLog(@"buttonSize.width:%f",buttonSize.width);
        
        UIButton* tagButton = [UIButton new];
        UIImage *image =  [[UIImage imageNamed:@"labelDetailBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:0];
        [tagButton setBackgroundImage:image forState:UIControlStateNormal];
        [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tagButton.titleLabel setFont:font];
        [tagButton setTitle:content forState:UIControlStateNormal];
        [self.contentView addSubview:tagButton];
        [tagButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(51);
            if (lastView) {
                make.bottom.equalTo(lastView.mas_top).offset(-interval);
            }
            else{
                make.bottom.equalTo(ws.bgImageView).offset(-AutoSize(70/2));
            }
            make.height.mas_equalTo(buttonSize.height + 5);
            make.width.mas_equalTo(buttonSize.width + 35);
            
        }];
        tagButton.tag = baseTagNum + i;
        lastView = tagButton;
        
        [tagButton bk_whenTapped:^{
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            viewModel.tagId = homeTags.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
    }
}




@end
