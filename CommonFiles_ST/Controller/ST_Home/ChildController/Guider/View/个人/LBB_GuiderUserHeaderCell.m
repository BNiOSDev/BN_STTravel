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
         //   make.width.mas_equalTo(AutoSize(60));
          //  make.height.mas_equalTo(AutoSize(15));
        }];
        
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton2.titleLabel setFont:Font12];
        [self.labelButton2 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton2];
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton1.mas_top).offset(-10);
        }];

        self.labelButton3 = [UIButton new];
        [self.labelButton3 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton3.titleLabel setFont:Font12];
        [self.labelButton3 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton3];
        [self.labelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton2.mas_top).offset(-10);
        }];
        
        self.labelButton4 = [UIButton new];
        [self.labelButton4 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton4.titleLabel setFont:Font12];
        [self.labelButton4 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton4];
        [self.labelButton4 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton3.mas_top).offset(-10);
        }];
        
        self.labelButton5 = [UIButton new];
        [self.labelButton5 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton5 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton5.titleLabel setFont:Font12];
        [self.labelButton5 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton5];
        [self.labelButton5 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton4.mas_top).offset(-10);
        }];

        self.labelButton6 = [UIButton new];
        [self.labelButton6 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton6 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.labelButton6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.labelButton6.titleLabel setFont:Font12];
        [self.labelButton6 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.contentView addSubview:self.labelButton6];
        [self.labelButton6 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.labelButton1);
            make.bottom.equalTo(ws.labelButton5.mas_top).offset(-10);
        }];
        
        self.labelButton1.hidden = YES;
        self.labelButton2.hidden = YES;
        self.labelButton3.hidden = YES;
        self.labelButton4.hidden = YES;
        self.labelButton5.hidden = YES;
        self.labelButton6.hidden = YES;
        
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
        
        [self.labelButton1 bk_whenTapped:^{
            NSLog(@"labelButton1 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:0];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
        [self.labelButton2 bk_whenTapped:^{
            NSLog(@"labelButton2 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:1];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.labelButton2 bk_whenTapped:^{
            NSLog(@"labelButton2 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:1];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.labelButton3 bk_whenTapped:^{
            NSLog(@"labelButton3 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:2];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.labelButton4 bk_whenTapped:^{
            NSLog(@"labelButton4 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:3];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        [self.labelButton5 bk_whenTapped:^{
            NSLog(@"labelButton5 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:4];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
        }];
        
        [self.labelButton6 bk_whenTapped:^{
            NSLog(@"labelButton6 touch");
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc] init];
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:5];
            viewModel.tagId = tag.tagId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
            
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
    
    //标签
    self.labelButton1.hidden = YES;
    self.labelButton2.hidden = YES;
    self.labelButton3.hidden = YES;
    self.labelButton4.hidden = YES;
    self.labelButton5.hidden = YES;
    self.labelButton6.hidden = YES;
    
    NSInteger count = model.tags.count;
    if (count > 0) {
        self.labelButton1.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:0];
        [self.labelButton1 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 1){
        self.labelButton2.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:1];
        [self.labelButton2 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 2){
        self.labelButton3.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:2];
        [self.labelButton3 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 3){
        self.labelButton4.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:3];
        [self.labelButton4 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 4){
        self.labelButton5.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:4];
        [self.labelButton5 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 5){
        self.labelButton6.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:5];
        [self.labelButton6 setTitle:tag.tagName forState:UIControlStateNormal];
    }

}

@end
