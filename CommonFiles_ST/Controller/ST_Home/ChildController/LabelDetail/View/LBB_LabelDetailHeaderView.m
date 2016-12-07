//
//  LBB_LabelDetailHeaderView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailHeaderView.h"
#import "PoohCommon.h"
#import "UIImageView+LBBlurredImage.h"
@implementation LBB_LabelDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    
    WS(ws);
    if (self = [super init]) {
        
        CGFloat margin = 8;
        
        self.bgImageView = [UIImageView new];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.width.top.equalTo(ws);
            make.height.mas_equalTo(AutoSize(150));
        }];

        
        self.portraitImageView = [UIImageView new];
        [self addSubview:self.portraitImageView];
        [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.bgImageView).offset(12);
            make.bottom.equalTo(ws.bgImageView).offset(-12);

            make.width.height.mas_equalTo(AutoSize(150/2));
        }];
        
        self.typeLabel = [UILabel new];
        [self.typeLabel setText:@"胶卷摄影"];
        [self.typeLabel setTextColor:ColorWhite];
        [self.typeLabel setFont:Font16];
        [self addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(ws.portraitImageView.mas_right).offset(margin);
            make.top.equalTo(ws.portraitImageView).offset(margin);
        }];
        
        
        self.numLabel = [UILabel new];
        [self.numLabel setText:@"10万张照片"];
        [self.numLabel setTextColor:ColorWhite];
        [self.numLabel setFont:Font13];
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.typeLabel);
            make.top.equalTo(ws.typeLabel.mas_bottom).offset(margin);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(0);
            make.centerX.width.equalTo(ws);
            make.height.mas_equalTo(8);
        }];
        
        
        UIView* sub = [UIView new];
        [sub setBackgroundColor:ColorWhite];
        [self addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){

            make.centerX.width.equalTo(ws);
            make.top.equalTo(sep.mas_bottom);
        }];
        
        self.labelButton1 = [UIButton new];
        [self.labelButton1 setTitle:@"厦门" forState:UIControlStateNormal];
        [self.labelButton1 setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.labelButton1.titleLabel setFont:Font12];
        self.labelButton1.layer.borderColor = ColorLine.CGColor;
        self.labelButton1.layer.borderWidth = SeparateLineWidth;
        self.labelButton1.layer.masksToBounds = YES;
        [sub addSubview:self.labelButton1];
        
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setTitle:@"胶卷摄影" forState:UIControlStateNormal];
        [self.labelButton2 setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.labelButton2.titleLabel setFont:Font12];
        self.labelButton2.layer.borderColor = ColorLine.CGColor;
        self.labelButton2.layer.borderWidth = SeparateLineWidth;
        self.labelButton2.layer.masksToBounds = YES;
        [sub addSubview:self.labelButton2];
        
        self.labelButton3 = [UIButton new];
        [self.labelButton3 setTitle:@"咖啡店" forState:UIControlStateNormal];
        [self.labelButton3 setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.labelButton3.titleLabel setFont:Font12];
        self.labelButton3.layer.borderColor = ColorLine.CGColor;
        self.labelButton3.layer.borderWidth = SeparateLineWidth;
        self.labelButton3.layer.masksToBounds = YES;
        [sub addSubview:self.labelButton3];
        
        self.labelButton4 = [UIButton new];
        [self.labelButton4 setTitle:@"胶片的味道" forState:UIControlStateNormal];
        [self.labelButton4 setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.labelButton4.titleLabel setFont:Font12];
        self.labelButton4.layer.borderColor = ColorLine.CGColor;
        self.labelButton4.layer.borderWidth = SeparateLineWidth;
        self.labelButton4.layer.masksToBounds = YES;
        [sub addSubview:self.labelButton4];
        
        [self.labelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.left.equalTo(sub).offset(2*margin);
            make.top.equalTo(sub).offset(margin);
            make.height.mas_equalTo(AutoSize(19));
            make.bottom.equalTo(sub).offset(-margin);
        }];
        
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.labelButton1.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
        [self.labelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.labelButton2.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
        }];
        [self.labelButton4 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.labelButton3.mas_right).offset(margin);
            make.centerY.width.height.equalTo(ws.labelButton1);
            make.right.equalTo(sub).offset(-2*margin);
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(sub.mas_bottom).offset(0);
            make.centerX.width.equalTo(ws);
            make.height.equalTo(sep);
        }];
        
        [self.labelButton1 bk_whenTapped:^{
            NSLog(@"labelButton1 touch");
            LBB_SquareTags* tags = [ws.model.tags objectAtIndex:0];
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                
                [ws.bgImageView setImageToBlur:image
                                    blurRadius:kLBBlurredImageDefaultBlurRadius
                               completionBlock:^(){
                                   NSLog(@"The blurred image has been set");
                               }];
            }];
            [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
            
            [self.typeLabel setText:tags.tagName];
            [self.numLabel setText:[NSString stringWithFormat:@"%d 张照片",tags.tagsViewModel.photoNum]];
            
        }];
        
        [self.labelButton2 bk_whenTapped:^{
            NSLog(@"labelButton2 touch");
            
            LBB_SquareTags* tags = [ws.model.tags objectAtIndex:1];
            
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                
                [ws.bgImageView setImageToBlur:image
                                    blurRadius:kLBBlurredImageDefaultBlurRadius
                               completionBlock:^(){
                                   NSLog(@"The blurred image has been set");
                               }];
            }];
            [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
            
            [self.typeLabel setText:tags.tagName];
            [self.numLabel setText:[NSString stringWithFormat:@"%d 张照片",tags.tagsViewModel.photoNum]];
        }];
        
        [self.labelButton3 bk_whenTapped:^{
            NSLog(@"labelButton3 touch");
            
            LBB_SquareTags* tags = [ws.model.tags objectAtIndex:2];
            
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                
                [ws.bgImageView setImageToBlur:image
                                    blurRadius:kLBBlurredImageDefaultBlurRadius
                               completionBlock:^(){
                                   NSLog(@"The blurred image has been set");
                               }];
            }];
            [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
            
            [self.typeLabel setText:tags.tagName];
            [self.numLabel setText:[NSString stringWithFormat:@"%d 张照片",tags.tagsViewModel.photoNum]];
        }];
        
        [self.labelButton4 bk_whenTapped:^{
            NSLog(@"labelButton4 touch");
            
            LBB_SquareTags* tags = [ws.model.tags objectAtIndex:3];
            
            [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                
                [ws.bgImageView setImageToBlur:image
                                    blurRadius:kLBBlurredImageDefaultBlurRadius
                               completionBlock:^(){
                                   NSLog(@"The blurred image has been set");
                               }];
            }];
            [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:tags.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
            
            [self.typeLabel setText:tags.tagName];
            [self.numLabel setText:[NSString stringWithFormat:@"%d 张照片",tags.tagsViewModel.photoNum]];
        }];
        
    }
    return self;
}


+(CGFloat)getHeight{

    CGFloat margin = 8;
    CGFloat height = 0;
    
    height = AutoSize(150) + 8 + margin + AutoSize(19) + margin + 8;
    
    return height;
}

-(void)setModel:(LBB_TagsViewModel*)model{
    WS(ws);
    
    _model = model;
  //  [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:IMAGE(PlaceHolderImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        
        [ws.bgImageView setImageToBlur:image
                              blurRadius:kLBBlurredImageDefaultBlurRadius
                         completionBlock:^(){
                             NSLog(@"The blurred image has been set");
                         }];
    }];
    
    [self.typeLabel setText:model.tagName];
    [self.numLabel setText:[NSString stringWithFormat:@"%d 张照片",model.photoNum]];
   
    self.labelButton1.hidden = YES;
    self.labelButton2.hidden = YES;
    self.labelButton3.hidden = YES;
    self.labelButton4.hidden = YES;

    NSInteger count = model.tags.count;
    if (count > 0) {
        self.labelButton1.hidden = NO;
        LBB_SquareTags* tags = [model.tags objectAtIndex:0];
        [self.labelButton1 setTitle:tags.tagName forState:UIControlStateNormal];
        [tags getTagsViewModelData];
        __weak LBB_SquareTags *tags_block = tags;
        [tags.tagsViewModel.loadSupport setDataRefreshblock:^{
            UIImageView* imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:tags_block.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) ];
        }];
    }
    
    if (count > 1) {
        self.labelButton2.hidden = NO;
        LBB_SquareTags* tags = [model.tags objectAtIndex:1];
        [self.labelButton2 setTitle:tags.tagName forState:UIControlStateNormal];
        [tags getTagsViewModelData];
        __weak LBB_SquareTags *tags_block = tags;
        [tags.tagsViewModel.loadSupport setDataRefreshblock:^{
            UIImageView* imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:tags_block.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) ];
        }];
    }
    
    if (count > 2) {
        self.labelButton3.hidden = NO;
        LBB_SquareTags* tags = [model.tags objectAtIndex:2];
        [self.labelButton3 setTitle:tags.tagName forState:UIControlStateNormal];
        [tags getTagsViewModelData];
        __weak LBB_SquareTags *tags_block = tags;
        [tags.tagsViewModel.loadSupport setDataRefreshblock:^{
            UIImageView* imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:tags_block.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) ];
        }];
    }
    
    if (count > 3) {
        self.labelButton4.hidden = NO;
        LBB_SquareTags* tags = [model.tags objectAtIndex:3];
        [self.labelButton4 setTitle:tags.tagName forState:UIControlStateNormal];
        [tags getTagsViewModelData];
        __weak LBB_SquareTags *tags_block = tags;
        [tags.tagsViewModel.loadSupport setDataRefreshblock:^{
            UIImageView* imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:tags_block.tagsViewModel.picUrl] placeholderImage:IMAGE(PlaceHolderImage) ];
        }];
    }

}

@end
