//
//  LBB_ScenicDetailSubjectContentCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailSubjectContentCell.h"

@interface LBB_ScenicDetailSubjectContentCell()
{
    RACDisposable* racIsCollected;
    RACDisposable* racIsLike;
    RACDisposable* racLikeNum;
    RACDisposable* racCommentsNum;
    RACDisposable* racCollecteNum;

    UIView* gv;
}


@end

@implementation LBB_ScenicDetailSubjectContentCell

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
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setText:@"厦门曾厝垵景区"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(3*margin);
            make.centerX.equalTo(ws.contentView);
        }];
        
        
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.subTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.subTitleLabel setText:@"在大城市寻找一处桃花运"];
        [self.contentView addSubview:self.subTitleLabel];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(margin);
            make.centerX.equalTo(ws.contentView);
        }];
        
        //点赞
        UIView* v = [UIView new];
        [self.contentView addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.subTitleLabel.mas_bottom).offset(margin);
        }];
        gv = v;
        
        self.greatView = [[UIButton alloc]init];
        [self.greatView setImage:IMAGE(@"景点专题_点赞") forState:UIControlStateNormal];
        [self.greatView setTitle:@"190" forState:UIControlStateNormal];
        [self.greatView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greatView.titleLabel setFont:Font12];
        [self.greatView setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, -1)];
        [v addSubview:self.greatView];
        [self.greatView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.top.bottom.equalTo(v);
           // make.height.mas_equalTo(@15);
        }];
        [self.greatView bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            [ws.model like:^(NSError* error){
                
            }];
            
        }];
        
        self.commentsView = [[UIButton alloc]init];
        [self.commentsView setImage:IMAGE(@"景点专题_评论") forState:UIControlStateNormal];
        [self.commentsView setTitle:@"190" forState:UIControlStateNormal];
        [self.commentsView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsView.titleLabel setFont:Font12];
        [self.commentsView setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, -1)];
        [v addSubview: self.commentsView];
        [self.commentsView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.greatView.mas_right).offset(margin);
            make.centerY.height.equalTo(ws.greatView);
        }];
        
        [self.commentsView bk_whenTapped:^{
            
        }];
        
        self.favoriteView = [[UIButton alloc]init];
        [self.favoriteView setImage:IMAGE(@"景点专题_小收藏") forState:UIControlStateNormal];
        [self.favoriteView setTitle:@"190" forState:UIControlStateNormal];
        [self.favoriteView setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.favoriteView.titleLabel setFont:Font12];
        [self.favoriteView setTitleEdgeInsets:UIEdgeInsetsMake(0, 1, 0, -1)];
        [v addSubview: self.favoriteView];
        [self.favoriteView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.commentsView.mas_right).offset(margin);
            make.centerY.height.equalTo(ws.greatView);
            make.right.equalTo(v);
        }];
        
        [self.favoriteView bk_whenTapped:^{
            
            [ws.model collecte:^(NSError* error){
            
            }];
            
        }];
        
        
        
        self.imageView1 = [UIImageView new];
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView1.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView1];
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.top.equalTo(v.mas_bottom).offset(margin);
            make.height.mas_equalTo(AutoSize(430/2));
        }];
        
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:Font15];
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentLabel setTextColor:ColorGray];
        [self.contentLabel setText:@"这里通过设置 UIImageView的 layer.mask 来设置约束，这里通过一张图片，去图片的边缘部分组成一个path，path以内的部分将会显示出来，path以外的部分将不会显示，backImage 决定了path的形状！当然了这里还可以设置其它的layer作为uiview的mask"];
        [self.contentLabel setLineSpace:margin];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.imageView1.mas_bottom).offset(margin);
            make.centerX.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.right.equalTo(ws.contentView).offset(-3*margin);
        }];
        
        self.imageView2 = [UIImageView new];
        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView2.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView2];
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(margin);
            make.height.equalTo(ws.imageView1);
        }];
        
        self.moreButton = [UIButton new];
        [self.moreButton setTitle:@"点击查看更多 >" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.moreButton.titleLabel setFont:Font13];
        self.moreButton.layer.borderColor = ColorGray.CGColor;
        self.moreButton.layer.borderWidth = 0.6;
        [self.contentView addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.imageView2.mas_bottom).offset(2*margin);
            make.width.mas_equalTo(AutoSize(258/2));
            make.height.mas_equalTo(AutoSize(54/2));
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLightGray];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.moreButton.mas_bottom).offset(4.5*margin);
            make.left.equalTo(ws.contentView).offset(16);
            make.right.equalTo(ws.contentView).offset(-16);
        }];
    }
    return self;
}


-(void)setModel:(LBB_SpotSpecialList*)model{
    
    
    _model = model;
    CGFloat margin = 8;
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl1] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl2] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.contentLabel setText:model.contentDisplay];
    [self.contentLabel setLineSpace:margin];
    
    /* ******/
 /*   NSString* att = model.contentDisplay;
    if (!att) {
        att = @"";
    }
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[att dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    self.contentLabel.attributedText = htmlString;
  */
    /*******/
    [self.titleLabel setText:model.titleDisplay];
    [self.subTitleLabel setText:model.viceTitleDisplay];
    WS(ws);
    if (model.imageUrl1.length <= 0) {//没有图片1
        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.top.equalTo(gv.mas_bottom).offset(margin);
            make.height.mas_equalTo(0);
        }];
    }
    else{
    
        [self.imageView1 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.top.equalTo(gv.mas_bottom).offset(margin);
            make.height.mas_equalTo(AutoSize(430/2));
        }];
    }
    
    if (model.imageUrl2.length <= 0) {//没有图片2
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(margin);
            make.height.mas_equalTo(0);
        }];
    }
    else{
        [self.imageView2 mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(margin);
            make.height.mas_equalTo(AutoSize(430/2));
        }];
    }
    
    @weakify (self);
    [racIsCollected dispose];
    [racIsLike dispose];
    [racLikeNum dispose];
    [racCollecteNum dispose];
    [racCommentsNum dispose];

    
    racCollecteNum = [RACObserve(self.model, collecteNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //点赞次数
        int sts = [num intValue];
        [self.favoriteView setTitle:[NSString stringWithFormat:@"%d",sts] forState:UIControlStateNormal];
    }];
    
    
    racCommentsNum = [RACObserve(self.model, commentsNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //点赞次数
        int sts = [num intValue];
        [self.commentsView setTitle:[NSString stringWithFormat:@"%d",sts] forState:UIControlStateNormal];
    }];
    
    racIsLike = [RACObserve(self.model, isLiked) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //是否点赞
        BOOL sts = [num boolValue];
        if (sts) {
            [self.greatView setImage:IMAGE(@"景点专题_点赞HL") forState:UIControlStateNormal];
        }
        else{
            [self.greatView setImage:IMAGE(@"景点专题_点赞") forState:UIControlStateNormal];
        }
    }];
    
    racIsCollected = [RACObserve(self.model, isCollected) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //是否收藏
        BOOL sts = [num boolValue];
        if (sts) {
            [self.favoriteView setImage:IMAGE(@"景点专题_小收藏") forState:UIControlStateNormal];
        }
        else{
            [self.favoriteView setImage:IMAGE(@"景点专题_小收藏") forState:UIControlStateNormal];
        }
    }];
    
    racLikeNum = [RACObserve(self.model, likeNum) subscribeNext:^(NSNumber* num) {
        @strongify(self);
        
        //点赞次数
        int sts = [num intValue];
        [self.greatView setTitle:[NSString stringWithFormat:@"%d",sts] forState:UIControlStateNormal];
    }];
    
    [self.contentView layoutSubviews];
}

@end
