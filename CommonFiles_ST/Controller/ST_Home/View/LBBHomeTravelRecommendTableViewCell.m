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
#import "LBB_TravelCommentController.h"
@implementation LBBHomeTravelRecommendTableViewCell
{
    RACDisposable* racIsCollected;
    RACDisposable* racIsLike;
    RACDisposable* racLikeNum;
    RACDisposable* racCommentsNum;
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
        
        self.portraitImageView = [UIImageView new];
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.contentView).offset(16/2);
            make.width.height.mas_equalTo(AutoSize(66/2));
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(-AutoSize(66/2)/2);
        }];
        [self.portraitImageView setUserInteractionEnabled:YES];
        
        self.userLable = [UILabel new];
        [self.userLable setText:@"梁晓欣"];
        [self.userLable setFont:Font12];
        [self.contentView addSubview:self.userLable];
        [self.userLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(3);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(3);
        }];
        
        self.travlTitleLable = [UILabel new];
        [self.travlTitleLable setText:@"厦大行"];
        [self.travlTitleLable setFont:Font12];
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
        [self.commentsView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [self.contentView addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-12);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(5);
          //  make.height.equalTo(@16);
        }];
        

        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greetView setTitle:@"1000" forState:UIControlStateNormal];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
        [self.greetView setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-12);
            make.centerY.equalTo(ws.commentsView);
        }];

        
        //specialLabelButton
        self.specialLabelButton1 = [UIButton new];
        [self.specialLabelButton1 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton1.titleLabel setFont:Font12];
        
        self.specialLabelButton2 = [UIButton new];
        [self.specialLabelButton2 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton2.titleLabel setFont:Font12];
        
        self.specialLabelButton3 = [UIButton new];
        [self.specialLabelButton3 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton3.titleLabel setFont:Font12];
        
        self.specialLabelButton4 = [UIButton new];
        [self.specialLabelButton4 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton4 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton4.titleLabel setFont:Font12];
        
        self.specialLabelButton5 = [UIButton new];
        [self.specialLabelButton5 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton5 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton5.titleLabel setFont:Font12];
        
        self.specialLabelButton6 = [UIButton new];
        [self.specialLabelButton6 setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.specialLabelButton6 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self.specialLabelButton6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.specialLabelButton6.titleLabel setFont:Font12];
        
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
     //   CGFloat width = AutoSize(156/2);
     //   CGFloat height = AutoSize(36/2);

        [self.specialLabelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-8);
          //  make.height.mas_equalTo(height);
          //  make.width.mas_equalTo(width);
            make.bottom.equalTo(ws.bgImageView).offset(-2*interval);
        }];
        
        [self.specialLabelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.right.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton1.mas_top).offset(-interval);
        }];
        
        [self.specialLabelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton2.mas_top).offset(-interval);
        }];
        [self.specialLabelButton4 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton3.mas_top).offset(-interval);
        }];
        [self.specialLabelButton5 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton4.mas_top).offset(-interval);
        }];
        [self.specialLabelButton6 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.specialLabelButton1);
            make.bottom.equalTo(ws.specialLabelButton5.mas_top).offset(-interval);
        }];
        
        [self.specialLabelButton6 setHidden:YES];
        [self.specialLabelButton5 setHidden:YES];
        [self.specialLabelButton4 setHidden:YES];
        [self.specialLabelButton3 setHidden:YES];
        [self.specialLabelButton2 setHidden:YES];
        [self.specialLabelButton1 setHidden:YES];

     
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
    
#pragma action
        [self.favoriteButton bk_addEventHandler:^(id sender){
            
            [_model collecte:^(NSError* error){
                NSLog(@"collecte error:%@",error);
                
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.commentsView bk_whenTapped:^{
            
            NSLog(@"commentsView touch 需跳转到全部评论页面");
            LBB_TravelCommentController *vc = [[LBB_TravelCommentController alloc]init];
            [[ws getViewController].navigationController pushViewController:vc animated:YES];
            
        }];
        [self.greetView bk_whenTapped:^{
            
            [_model like:^(NSError* error){
                NSLog(@"like error:%@",error);
            }];
            
        }];
        
        [self.portraitImageView bk_whenTapped:^{//跳转到个人中心页面
            
            LBB_SquareSnsFollowViewController* dest = [[LBB_SquareSnsFollowViewController alloc]init];
            LBB_SquareUgc* viewModel = [[LBB_SquareUgc alloc] init];
            viewModel.userId = ws.model.userId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];

        [self.specialLabelButton1 bk_whenTapped:^{
            
            NSLog(@"specialLabelButton1 touch");
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:0];
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc]init];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];

        [self.specialLabelButton2 bk_whenTapped:^{
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:1];
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc]init];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];

        [self.specialLabelButton3 bk_whenTapped:^{
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:2];
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc]init];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];

        [self.specialLabelButton4 bk_whenTapped:^{
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:3];
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc]init];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];
    
        [self.specialLabelButton5 bk_whenTapped:^{
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:4];
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc]init];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];
    

        [self.specialLabelButton6 bk_whenTapped:^{
            BN_HomeTag* tag = [ws.model.tags objectAtIndex:5];
            LBB_LabelDetailViewController* dest = [[LBB_LabelDetailViewController alloc]init];
            LBB_SquareTags* viewModel = [[LBB_SquareTags alloc]init];
            viewModel.tagId = tag.tagId;
            dest.viewModel = viewModel;
            [[self getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
        
    }
    return self;
}


-(void)setModel:(BN_HomeTravelNotes *)model{

    _model = model;
    [self blindData:model];
}

-(void)blindData:(BN_HomeTravelNotes *)model{

    @weakify (self);
    
    [racIsCollected dispose];
    [racIsLike dispose];
    [racLikeNum dispose];
    [racCommentsNum dispose];
    
    racIsLike = [RACObserve(self.model, isLiked) subscribeNext:^(NSNumber* num) {
        @strongify(self);
   
        //是否点赞
        BOOL sts = [num boolValue];
        if (!sts) {
            [self.greetView setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        }
        else{
            [self.greetView setImage:IMAGE(@"ST_Home_GreatHL") forState:UIControlStateNormal];
        }
    }];
    
    racIsCollected = [RACObserve(self.model, isCollected) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //是否收藏
        BOOL sts = [num boolValue];
        if (!sts) {
            [self.favoriteButton setImage:IMAGE(@"ST_Home_Favorite") forState:UIControlStateNormal];
        }
        else{
            [self.favoriteButton setImage:IMAGE(@"ST_Home_FavoriteHL") forState:UIControlStateNormal];
        }
    }];
    
    racLikeNum = [RACObserve(self.model, likeNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //点赞次数
        int sts = [num intValue];
        [self.greetView setTitle:[NSString stringWithFormat:@"%d",sts] forState:UIControlStateNormal];
    }];
    
    
    racCommentsNum = [RACObserve(self.model, commentsNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //评论条数
        int sts = [num intValue];
        [self.commentsView setTitle:[NSString stringWithFormat:@"%d",sts] forState:UIControlStateNormal];//收藏数
    }];
    
    

    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.travelNotesPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];//游记标题
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];//用户头像
    [self.travlTitleLable setText:model.travelNotesName];//游记标题
    [self.userLable setText:model.userName];//用户名

    //标签
    self.specialLabelButton1.hidden = YES;
    self.specialLabelButton2.hidden = YES;
    self.specialLabelButton3.hidden = YES;
    self.specialLabelButton4.hidden = YES;
    self.specialLabelButton5.hidden = YES;
    self.specialLabelButton6.hidden = YES;
    
    NSInteger count = model.tags.count;
    if (count > 0) {
        self.specialLabelButton1.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:0];
        [self.specialLabelButton1 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 1){
        self.specialLabelButton2.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:1];
        [self.specialLabelButton2 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 2){
        self.specialLabelButton3.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:2];
        [self.specialLabelButton3 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 3){
        self.specialLabelButton4.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:3];
        [self.specialLabelButton4 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 4){
        self.specialLabelButton5.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:4];
        [self.specialLabelButton5 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    if (count > 5){
        self.specialLabelButton6.hidden = NO;
        BN_HomeTag* tag = [model.tags objectAtIndex:5];
        [self.specialLabelButton6 setTitle:tag.tagName forState:UIControlStateNormal];
    }
    
    
}

@end
