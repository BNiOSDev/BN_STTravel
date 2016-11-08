//
//  LBB_LabelDetailHeaderView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailHeaderView.h"
#import "PoohCommon.h"
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
    }
    return self;
}


+(CGFloat)getHeight{

    CGFloat margin = 8;
    CGFloat height = 0;
    
    height = AutoSize(150) + 8 + margin + AutoSize(19) + margin + 8;
    
    return height;
}

-(void)setModel:(id)model{
    WS(ws);
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1478007203&di=a3c6cc46c613fc8dff8bef3d33a28e64&src=http://f.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d358d27ee43ef33a87e850b114.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.portraitImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1478007203&di=a3c6cc46c613fc8dff8bef3d33a28e64&src=http://f.hiphotos.baidu.com/image/pic/item/5ab5c9ea15ce36d358d27ee43ef33a87e850b114.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    
    
    [self.labelButton1 bk_whenTapped:^{
        NSLog(@"labelButton1 touch");
        
        [ws.typeLabel setText:ws.labelButton1.titleLabel.text];
        
    }];
    
    [self.labelButton2 bk_whenTapped:^{
        NSLog(@"labelButton2 touch");
        
        [ws.typeLabel setText:ws.labelButton2.titleLabel.text];
        
    }];
    
    [self.labelButton3 bk_whenTapped:^{
        NSLog(@"labelButton3 touch");
        
        [ws.typeLabel setText:ws.labelButton3.titleLabel.text];
        
    }];
    
    [self.labelButton4 bk_whenTapped:^{
        NSLog(@"labelButton4 touch");
        
        [ws.typeLabel setText:ws.labelButton4.titleLabel.text];
        
    }];
    
}

@end
