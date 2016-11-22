//
//  LBB_ScenicMainTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/25.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicMainTableViewCell.h"


@implementation LBB_ScenicMainTableViewCell

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
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        CGFloat margin = 8;

        self.bgImageView = [UIImageView new];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(360/2));
        }];
        
        self.favoriteButton  = [UIButton new];
        [self.favoriteButton setImage:IMAGE(@"景点详情_收藏HL") forState:UIControlStateNormal];
        [self.contentView addSubview:self.favoriteButton];
        [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.top.equalTo(ws.bgImageView).offset(2*margin);
           // make.width.height.mas_equalTo(AutoSize(15));
        }];
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self.titleLabel setText:@"厦门漫步之旅，住2晚厦门希尔顿玉林酒店"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.bgImageView).offset(2*margin);
            make.right.equalTo(ws.bgImageView).offset(-2*margin);
            make.top.equalTo(ws.bgImageView.mas_bottom).offset(margin);
        }];
        
        self.addressLabel = [UILabel new];
        [self.addressLabel setFont:Font13];
        [self.addressLabel setText:@"鹿角路"];
        [self.addressLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker* make){

            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.titleLabel.mas_bottom).offset(margin);
        }];
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:[UIColor colorWithRGB:0x808080]];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.addressLabel.mas_right).offset(3);
            make.centerY.equalTo(ws.addressLabel);
            make.height.equalTo(ws.addressLabel).offset(-3);
            make.width.mas_equalTo(SeparateLineWidth);
        }];
        
        self.streetLabel = [UILabel new];
        [self.streetLabel setFont:Font13];
        [self.streetLabel setText:@""];
        [self.streetLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.streetLabel];
        [self.streetLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(sep.mas_right).offset(0);
            make.centerY.height.equalTo(ws.addressLabel);
        }];
        [self.streetLabel setHidden:YES];

        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.streetLabel.mas_right).offset(0);
            make.centerY.equalTo(ws.addressLabel);
            make.height.width.equalTo(sep);
        }];
        [sep1 setHidden:YES];

        self.distanceLabel = [UILabel new];
        [self.distanceLabel setFont:Font13];
        [self.distanceLabel setText:@"90km"];
        [self.distanceLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.distanceLabel];
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(sep1.mas_right).offset(2);
            make.centerY.height.equalTo(ws.addressLabel);
        }];
        
        //right
        self.deletePriceLabel = [UILabel new];
        [self.deletePriceLabel setFont:Font10];
        [self.deletePriceLabel setText:@"230"];
        [self.deletePriceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.deletePriceLabel setTextColor:ColorLightGray];
        [self.contentView addSubview:self.deletePriceLabel];
        [self.deletePriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.contentView).offset(-2*margin);
            make.centerY.equalTo(ws.addressLabel);
        }];
        
        self.priceLabel = [UILabel new];
        [self.priceLabel setFont:Font10];
        [self.priceLabel setText:@"230元起/1人"];
        [self.priceLabel setTextAlignment:NSTextAlignmentCenter];
        [self.priceLabel setTextColor:ColorBtnYellow];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.right.equalTo(ws.deletePriceLabel.mas_left).offset(-8);
            make.centerY.equalTo(ws.addressLabel);
        }];
        
        self.greatButton = [[UIButton alloc]init];
        [self.greatButton setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
        [self.greatButton setTitle:@"190" forState:UIControlStateNormal];
        [self.greatButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.greatButton.titleLabel setFont:Font12];
        [self.contentView addSubview:self.greatButton];
        [self.greatButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.titleLabel);
            make.top.equalTo(ws.addressLabel.mas_bottom).offset(margin);
            //make.height.mas_equalTo(@15);
        }];
        [self.greatButton bk_whenTapped:^{
            
            NSLog(@"greetView touch");
            
        }];
        
        
        self.commentsButton = [[UIButton alloc]init];
        [self.commentsButton setImage:IMAGE(@"ST_Home_Comments") forState:UIControlStateNormal];
        [self.commentsButton setTitle:@"190" forState:UIControlStateNormal];
        [self.commentsButton setTitleColor:ColorLightGray forState:UIControlStateNormal];
        [self.commentsButton.titleLabel setFont:Font12];
        [self.contentView addSubview: self.commentsButton];
        [ self.commentsButton mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.greatButton.mas_right).offset(margin/2);
            make.centerY.height.equalTo(ws.greatButton);
        }];
        
        [self.commentsButton bk_whenTapped:^{

        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.greatButton.mas_bottom).offset(margin);
        }];
    }
    return self;
}

-(void)showTopSepLine:(BOOL)show{
    WS(ws);
    if (show) {
        [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(AutoSize(10));
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(360/2));
        }];
    }
    else{
        [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker* make){
            
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(360/2));
        }];
    }
    [self.contentView layoutSubviews];
}

-(void)setModel:(LBB_SpotModel*)model{
    
    _model = model;
    
    [self.addressLabel setText:model.allSpotsName];
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.titleLabel setText:model.picRemark];
    
    [self.distanceLabel setText:[NSString stringWithFormat:@"%.0fkm",model.distance]];
    [self.greatButton setTitle:[NSString stringWithFormat:@"%d",model.likeNum] forState:UIControlStateNormal];
    [self.commentsButton setTitle:[NSString stringWithFormat:@"%d",model.commentsNum] forState:UIControlStateNormal];

    if (model.isCollected) {
        [self.favoriteButton setImage:IMAGE(@"景点详情_收藏HL") forState:UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:IMAGE(@"景点详情_收藏") forState:UIControlStateNormal];
    }
    
    if (model.isLiked) {
        [self.greatButton setImage:IMAGE(@"ST_Home_GreatHL") forState:UIControlStateNormal];
    }
    else{
        [self.greatButton setImage:IMAGE(@"ST_Home_Great") forState:UIControlStateNormal];
    }
    
    //单价设置
    NSString* strFormat1 = [NSString stringWithFormat:@"%@元起/人",model.realPrice];
    NSString* strFormat2 = @"元";
    UIColor* fontColor = ColorBtnYellow;
    NSDictionary* attrsDic = @{NSForegroundColorAttributeName:fontColor,
                               NSFontAttributeName:Font15};    //显示的字符串进行富文本转换
    NSMutableAttributedString* strAttr = [[NSMutableAttributedString alloc]initWithString:strFormat1];
    //字体设置
    NSRange rang = [strFormat1 rangeOfString:strFormat2];
    if (rang.location != NSNotFound) {
        NSLog(@"found at location = %ld, length = %ld",rang.location,rang.length);
        [strAttr addAttributes:attrsDic range:NSMakeRange(0, rang.location)];
    }else{
        NSLog(@"Not Found");
    }
    self.priceLabel.attributedText = strAttr;
    
    //删除的价格设置
    NSLog(@"model.standardPcice:%@",model.standardPcice);

    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:model.standardPcice?model.standardPcice:@""
                                  attributes:
       @{NSFontAttributeName:Font10,
    NSForegroundColorAttributeName:ColorLightGray,
    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    NSStrikethroughColorAttributeName:[UIColor blackColor]}];
    self.deletePriceLabel.attributedText = attrStr;
    
    

}

@end
