//
//  LBB_ScenicAllCommentCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/12/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicAllCommentCell.h"
#import "CWStarRateView.h"
#import "ZJMCommentView.h"
#import "LBB_PoohCommentView.h"

@interface LBB_ScenicAllCommentCell()<CWStarRateViewDelegate>

@property(nonatomic,retain)UIImageView* portraitImageView;
@property(nonatomic,retain)UILabel* nickLabel;
@property (nonatomic, retain) CWStarRateView *starRatingView;

@property(nonatomic,retain)UILabel* contentLabel;

@property(nonatomic,retain)UIImageView* imageView1;
@property(nonatomic,retain)UIImageView* imageView2;
@property(nonatomic,retain)UIImageView* imageView3;

@property(nonatomic,retain)UILabel* timeLabel;

@property(nonatomic, retain)UIButton* commentButton;
@property(nonatomic, retain)UIButton* likeButton;

@property(nonatomic, retain)LBB_PoohCommentView      *commetView;      //

@property(nonatomic, retain)UIView* sep;


@end

@implementation LBB_ScenicAllCommentCell

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
        
        CGFloat width = AutoSize(30);
        self.portraitImageView = [UIImageView new];
        self.portraitImageView.layer.cornerRadius = width/2;
        self.portraitImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.width.height.mas_equalTo(width);
        }];
        
        self.nickLabel = [UILabel new];
        [self.nickLabel setText:@"pooh"];
        [self.nickLabel setFont:Font15];
        [self.contentView addSubview:self.nickLabel];
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
        }];
        
        CGFloat starWidth = AutoSize(100);
        CGFloat starHeigth = AutoSize(20);
        self.starRatingView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, starWidth, starHeigth)
                                                      numberOfStars:5];
        self.starRatingView.scorePercent = 0.8;
        self.starRatingView.allowIncompleteStar = NO;
        self.starRatingView.hasAnimation = YES;
        self.starRatingView.delegate = self;
        [self.contentView addSubview:self.starRatingView];
        [self.starRatingView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(starHeigth);
            make.width.mas_equalTo(starWidth);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(2*margin);
        }];
        
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:Font15];
        [self.contentLabel setText:@"阿萨德开奖号1的大家都是爱神的箭爱很大的好多打开后打开大号安静的刷卡的就哈肯定会"];
        [self.contentLabel setNumberOfLines:0];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.starRatingView.mas_bottom).offset(margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        CGFloat interval = 10;
        CGFloat imageWidth = (DeviceWidth - 3* margin*2 - 2*interval)/3;
        
        self.imageView1 = [UIImageView new];
        [self.contentView addSubview:self.imageView1];
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(2*margin);
            make.left.equalTo(ws.portraitImageView);
            make.width.height.mas_equalTo(imageWidth);
        }];
        
        self.imageView2 = [UIImageView new];
        [self.contentView addSubview:self.imageView2];
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView1.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
        
        self.imageView3 = [UIImageView new];
        [self.contentView addSubview:self.imageView3];
        [self.imageView3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView2.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
        
        
        self.commentButton = [[UIButton alloc]init];
        [self.commentButton setImage:IMAGE(@"景区列表_评论") forState:UIControlStateNormal];
        [self.commentButton setTitle:@"1000" forState:UIControlStateNormal];
        [self.commentButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentButton.titleLabel setFont:Font12];
        [self.contentView addSubview:self.commentButton];
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
         //   make.centerY.equalTo(ws.timeLabel);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
        }];

        self.likeButton = [[UIButton alloc]init];
        [self.likeButton setImage:IMAGE(@"景区列表_点赞") forState:UIControlStateNormal];
        [self.likeButton setTitle:@"190" forState:UIControlStateNormal];
        [self.likeButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.likeButton.titleLabel setFont:Font12];
        [self.contentView addSubview:self.likeButton];
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentButton.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentButton);
        }];

        self.timeLabel = [UILabel new];
        [self.timeLabel setText:@"2015-09-10"];
        [self.timeLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
          //  make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
            make.centerY.height.equalTo(ws.commentButton);

        }];
        
        //评论
        self.commetView  = [LBB_PoohCommentView new];
        [self.contentView addSubview:self.commetView];
        [self.commetView mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.contentLabel);
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(margin);
        }];
        
        //评论框
        self.boxView = [CommentBoxView new];
        [self.contentView addSubview:self.boxView];
        [self.boxView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.contentLabel);
            make.top.equalTo(ws.commetView.mas_bottom).offset(3);
            make.height.mas_equalTo(AutoSize(30));
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.boxView.mas_bottom).offset(1.5*margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.bottom.equalTo(ws.contentView);
        }];
        self.sep = sep;
    }
    return self;
}


-(void)setCommentsRecord:(LBB_SpotsAllCommentsRecord *)commentsRecord{
    
    _commentsRecord = commentsRecord;
    WS(ws);
    CGFloat margin = 8;

    if (commentsRecord.pics.count <= 0) {//没有图片
        CGFloat interval = 10;
        CGFloat imageWidth = (DeviceWidth - 3* margin*2 - 2*interval)/3;
        
        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(0);
            make.left.equalTo(ws.portraitImageView);
            make.width.mas_equalTo(imageWidth);
            make.height.equalTo(@0);
        }];
        
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView1.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
        
        [self.imageView3 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView2.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];

    }
    else{
        CGFloat interval = 10;
        CGFloat imageWidth = (DeviceWidth - 3* margin*2 - 2*interval)/3;
        
        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(2*margin);
            make.left.equalTo(ws.portraitImageView);
            make.width.height.mas_equalTo(imageWidth);
        }];
        
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView1.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
        
        [self.imageView3 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.imageView2.mas_right).offset(interval);
            make.centerY.width.height.equalTo(ws.imageView1);
        }];
    }
   
        
#pragma 匹配数据
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:commentsRecord.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.nickLabel setText:commentsRecord.userName];
    [self.contentLabel setText:commentsRecord.remark];
  //  [self.commentButton setTitle:[NSString stringWithFormat:@"%d",commentsRecord.commentsNum] forState:UIControlStateNormal];
    [self.timeLabel setText:commentsRecord.commentDate];
    
    NSInteger count = [commentsRecord.pics count];
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView3.hidden = YES;
    
    if (count > 0) {
        self.imageView1.hidden = NO;
        LBB_SpotsCommentsRecordPics* pic = [commentsRecord.pics objectAtIndex:0];
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 1) {
        self.imageView2.hidden = NO;
        LBB_SpotsCommentsRecordPics* pic = [commentsRecord.pics objectAtIndex:1];
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    if (count > 2) {
        self.imageView3.hidden = NO;
        LBB_SpotsCommentsRecordPics* pic = [commentsRecord.pics objectAtIndex:2];
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    }
    
    //评论内容
    NSMutableArray *commentModelArray = (NSMutableArray *)[commentsRecord.comments map:^id(LBB_SquareComments *element) {
        
        CommentModel *model = [[CommentModel alloc]init];
        model.userName = element.userName;// 用户名称
        model.contentStr = element.remark;// 评论内容
        model.userID = [NSString stringWithFormat:@"%ld",element.commentId];// 评论ID
        return model;
    }];
    self.commetView.commentArray = commentModelArray;
    
    [self.contentView layoutSubviews];
    
}

@end
