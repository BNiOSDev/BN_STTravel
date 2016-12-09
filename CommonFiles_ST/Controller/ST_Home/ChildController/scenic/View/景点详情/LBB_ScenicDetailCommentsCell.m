//
//  LBB_ScenicDetailCommentsCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailCommentsCell.h"
#import "LBB_StarRatingViewController.h"
#import "LBB_ScenicAllCommentViewController.h"

@implementation LBB_ScenicDetailCommentsCell

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
    
        UIImageView* arrow = [UIImageView new];
        [arrow setImage:IMAGE(@"景点详情_小箭头")];
        [self.contentView addSubview:arrow];
        [arrow mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(10);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        self.arrow = arrow;
        
        self.moreButton = [UIButton new];
        [self.moreButton setTitle:@"全部评论" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.moreButton.titleLabel setFont:Font15];
        [self.contentView addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(arrow.mas_left);
            make.width.mas_equalTo(AutoSize(60));
        }];
        
        self.nickLabel = [UILabel new];
        [self.nickLabel setText:@"pooh"];
        [self.nickLabel setFont:Font15];
        [self.contentView addSubview:self.nickLabel];
        [self.nickLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.moreButton.mas_left).offset(-margin);
        }];
        
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:Font15];
        [self.contentLabel setText:@"阿萨德开奖号1的大家都是爱神的箭爱很大的好多打开后打开大号安静的刷卡的就哈肯定会"];
        [self.contentLabel setNumberOfLines:0];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(2* margin);
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
        
        
        self.timeLabel = [UILabel new];
        [self.timeLabel setText:@"2015-09-10"];
        [self.timeLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
        }];
        
        
        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"景区列表_评论") forState:UIControlStateNormal];
        [self.commentsView setTitle:@"1000" forState:UIControlStateNormal];
        [self.commentsView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.contentView addSubview:self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
            make.centerY.equalTo(ws.timeLabel);
            //make.height.equalTo(@15);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
            NSLog(@"disView touch");
            
        }];
        
        
        self.greetView = [[UIButton alloc]init];
        [self.greetView setImage:IMAGE(@"景区列表_点赞") forState:UIControlStateNormal];
        [self.greetView setTitle:@"190" forState:UIControlStateNormal];
        [self.greetView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greetView.titleLabel setFont:Font12];
        [self.contentView addSubview:self.greetView];
        [self.greetView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        [self.greetView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];

        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(2*margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
          //  make.bottom.equalTo(ws.contentView);
        }];
        self.sep = sep;
        
        self.commentsButton = [UIButton new];
        [self.commentsButton setTitle:@"我要评论+" forState:UIControlStateNormal];
        [self.commentsButton setTitleColor:ColorGray forState:UIControlStateNormal];
        self.commentsButton.layer.borderColor = ColorLine.CGColor;
        self.commentsButton.layer.borderWidth = SeparateLineWidth;
        [self.commentsButton.titleLabel setFont:Font13];
        [self.contentView addSubview:self.commentsButton];
        [self.commentsButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(sep.mas_bottom).offset(2*margin);
            make.height.mas_equalTo(AutoSize(62/2));
            make.width.mas_equalTo(AutoSize(174/2));
            make.bottom.equalTo(ws.contentView).offset(-3*margin);

        }];
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.blog.163.com/photo/GlXBl26Es3YNjTZLCkFXwQ==/1984961535764592168.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];

        
        [self.commentsButton bk_whenTapped:^{
        
            LBB_StarRatingViewController* dest = [[LBB_StarRatingViewController alloc]init];
            dest.allSpotsType = 10;// 场景类型 1美食 2 民宿 3 景点  5 ugc图片 6 ugc视频 7 游记9足迹  10 线路攻略11 美食专题 12民宿专题
          //  dest.allSpotsId = ws.model.lineId;
            [[ws getViewController].navigationController pushViewController:dest animated:YES];
        }];
        
        [self.moreButton bk_whenTapped:^{
        
            LBB_ScenicAllCommentViewController* dest = [[LBB_ScenicAllCommentViewController alloc] init];
            if (ws.spotDetails) {
                dest.spotDetailModel = ws.spotDetails;
            }
            else{
                LBB_SpotDetailsViewModel *spotDetailModel = [[LBB_SpotDetailsViewModel alloc] init];
                spotDetailModel.allSpotsId = ws.spotSpecialDetails.specialId;
                spotDetailModel.allSpotsType = ws.spotSpecialDetails.type;
                dest.spotDetailModel = spotDetailModel;

            }
            [[ws getViewController].navigationController pushViewController:dest animated:YES];

        }];
        
    }
    return self;
}


//-(void)setCommentsRecord:(NSMutableArray<LBB_SpotsCommentsRecord *> *)commentsRecord{
-(void)setSpotDetails:(LBB_SpotDetailsViewModel *)spotDetails{

    _spotDetails = spotDetails;
    
    NSMutableArray<LBB_SpotsCommentsRecord *> *commentsRecord = spotDetails.commentsRecord;
    WS(ws);
    CGFloat margin = 8;
    
   /* LBB_SpotsCommentsRecord* record = [[LBB_SpotsCommentsRecord alloc] init];
    record.commentId  = 0;// 主键
    record.remark = @"大科技活动假的很看的哈的框架啊很多大科技活动道具卡射得快大抠脚大汉大口径的";// 评论描述
    LBB_SpotsCommentsRecordPics* pic = [[LBB_SpotsCommentsRecordPics alloc] init];
    pic.imageUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1481163685&di=eaae70ca3568aae8342d491c3c81e583&src=http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg";// 发布者头像URL
     record.pics = [NSMutableArray arrayWithArray:@[pic,pic]];// 评论图片集合
     record.commentDate = @"2017-90-09";// 评论日期
     record.commentsNum = 199;// 评论条数
     record.userId = 10;// 发布者Id
     record.userName  = @"啊大大";// 发布者用户名称
     record.userPicUrl =@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1481163685&di=eaae70ca3568aae8342d491c3c81e583&src=http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg";// 发布者头像URL
    
    [commentsRecord addObject:record];*/
    if (commentsRecord.count <= 0) {
        
        [self.portraitImageView mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(0);
            make.width.height.mas_equalTo(0);
        }];
        
        [self.arrow mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(10);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];

        [self.moreButton setTitle:@""forState:UIControlStateNormal];
        [self.moreButton mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(self.arrow.mas_left);
            make.width.mas_equalTo(AutoSize(60));
            make.height.mas_equalTo(0);
        }];
        
        [self.nickLabel setText:@""];
        [self.nickLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.moreButton.mas_left).offset(-margin);
            make.height.mas_equalTo(0);
        }];
        
        [self.contentLabel setText:@""];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(0);
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.height.mas_equalTo(0);
        }];
        
        
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
        
        
        [self.timeLabel setText:@""];
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        
        [self.commentsView setTitle:@"" forState:UIControlStateNormal];
        [self.commentsView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
            make.centerY.equalTo(ws.timeLabel);
            make.height.equalTo(@0);
        }];
        
        
        [self.greetView setTitle:@"" forState:UIControlStateNormal];
        [self.greetView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsView);
        }];
       [self.sep mas_remakeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(0);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(0);
        }];
    }
    else{
        CGFloat width = AutoSize(30);
        [self.portraitImageView mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.width.height.mas_equalTo(width);
        }];
        

        [self.arrow mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(10);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        [self.moreButton mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(self.arrow.mas_left);
            make.width.mas_equalTo(AutoSize(60));
        }];
        
        [self.nickLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.moreButton.mas_left).offset(-margin);
        }];
        
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(2* margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        
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
        
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
        }];
        
        [self.commentsView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
            make.centerY.equalTo(ws.timeLabel);
        }];
        
        [self.greetView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        
        [self.sep mas_remakeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(2*margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        
#pragma 匹配数据
        LBB_SpotsCommentsRecord* record = [commentsRecord objectAtIndex:0];
        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:record.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.nickLabel setText:record.userName];
        [self.contentLabel setText:record.remark];
        [self.commentsView setTitle:[NSString stringWithFormat:@"%d",record.commentsNum] forState:UIControlStateNormal];
        [self.timeLabel setText:record.commentDate];
        
        NSInteger count = [record.pics count];
        self.imageView1.hidden = YES;
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;

        if (count > 0) {
            self.imageView1.hidden = NO;
            LBB_SpotsCommentsRecordPics* pic = [record.pics objectAtIndex:0];
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        }
        if (count > 1) {
            self.imageView2.hidden = NO;
            LBB_SpotsCommentsRecordPics* pic = [record.pics objectAtIndex:1];
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        }
        if (count > 2) {
            self.imageView3.hidden = NO;
            LBB_SpotsCommentsRecordPics* pic = [record.pics objectAtIndex:2];
            [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        }
        
    }
    
    [self.contentView layoutSubviews];

}


-(void)setSpotSpecialDetails:(LBB_SpotSpecialDetailsViewModel *)spotSpecialDetails{

    _spotSpecialDetails = spotSpecialDetails;
    
    NSMutableArray<LBB_SpotsCommentsRecord *> *commentsRecord = spotSpecialDetails.commentsRecord;
    WS(ws);
    CGFloat margin = 8;
    
    /* LBB_SpotsCommentsRecord* record = [[LBB_SpotsCommentsRecord alloc] init];
     record.commentId  = 0;// 主键
     record.remark = @"大科技活动假的很看的哈的框架啊很多大科技活动道具卡射得快大抠脚大汉大口径的";// 评论描述
     LBB_SpotsCommentsRecordPics* pic = [[LBB_SpotsCommentsRecordPics alloc] init];
     pic.imageUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1481163685&di=eaae70ca3568aae8342d491c3c81e583&src=http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg";// 发布者头像URL
     record.pics = [NSMutableArray arrayWithArray:@[pic,pic]];// 评论图片集合
     record.commentDate = @"2017-90-09";// 评论日期
     record.commentsNum = 199;// 评论条数
     record.userId = 10;// 发布者Id
     record.userName  = @"啊大大";// 发布者用户名称
     record.userPicUrl =@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1481163685&di=eaae70ca3568aae8342d491c3c81e583&src=http://g.hiphotos.baidu.com/image/pic/item/0823dd54564e92589f2fe1019882d158cdbf4ec1.jpg";// 发布者头像URL
     
     [commentsRecord addObject:record];*/
    if (commentsRecord.count <= 0) {
        
        [self.portraitImageView mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(0);
            make.width.height.mas_equalTo(0);
        }];
        
        [self.arrow mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(10);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        [self.moreButton setTitle:@""forState:UIControlStateNormal];
        [self.moreButton mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(self.arrow.mas_left);
            make.width.mas_equalTo(AutoSize(60));
            make.height.mas_equalTo(0);
        }];
        
        [self.nickLabel setText:@""];
        [self.nickLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.moreButton.mas_left).offset(-margin);
            make.height.mas_equalTo(0);
        }];
        
        [self.contentLabel setText:@""];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(0);
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.height.mas_equalTo(0);
        }];
        
        
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
        
        
        [self.timeLabel setText:@""];
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(0);
            make.height.mas_equalTo(0);
        }];
        
        
        [self.commentsView setTitle:@"" forState:UIControlStateNormal];
        [self.commentsView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
            make.centerY.equalTo(ws.timeLabel);
            make.height.equalTo(@0);
        }];
        
        
        [self.greetView setTitle:@"" forState:UIControlStateNormal];
        [self.greetView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        [self.sep mas_remakeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(0);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(0);
        }];
    }
    else{
        CGFloat width = AutoSize(30);
        [self.portraitImageView mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.width.height.mas_equalTo(width);
        }];
        
        
        [self.arrow mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(10);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        [self.moreButton mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(self.arrow.mas_left);
            make.width.mas_equalTo(AutoSize(60));
        }];
        
        [self.nickLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.centerY.equalTo(ws.portraitImageView);
            make.right.equalTo(ws.moreButton.mas_left).offset(-margin);
        }];
        
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.portraitImageView.mas_bottom).offset(2* margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);
        }];
        
        
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
        
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.portraitImageView);
            make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
        }];
        
        [self.commentsView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.imageView3);
            make.centerY.equalTo(ws.timeLabel);
        }];
        
        [self.greetView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.commentsView.mas_left).offset(-5);
            make.centerY.height.equalTo(ws.commentsView);
        }];
        
        [self.sep mas_remakeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.timeLabel.mas_bottom).offset(2*margin);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        
#pragma 匹配数据
        LBB_SpotsCommentsRecord* record = [commentsRecord objectAtIndex:0];
        [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:record.userPicUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        [self.nickLabel setText:record.userName];
        [self.contentLabel setText:record.remark];
        [self.commentsView setTitle:[NSString stringWithFormat:@"%d",record.commentsNum] forState:UIControlStateNormal];
        [self.timeLabel setText:record.commentDate];
        
        NSInteger count = [record.pics count];
        self.imageView1.hidden = YES;
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;
        
        if (count > 0) {
            self.imageView1.hidden = NO;
            LBB_SpotsCommentsRecordPics* pic = [record.pics objectAtIndex:0];
            [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        }
        if (count > 1) {
            self.imageView2.hidden = NO;
            LBB_SpotsCommentsRecordPics* pic = [record.pics objectAtIndex:1];
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        }
        if (count > 2) {
            self.imageView3.hidden = NO;
            LBB_SpotsCommentsRecordPics* pic = [record.pics objectAtIndex:2];
            [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:pic.imageUrl] placeholderImage:IMAGE(PlaceHolderImage)];
        }
        
    }
    
    [self.contentView layoutSubviews];
}

@end
