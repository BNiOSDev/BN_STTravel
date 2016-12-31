//
//  LBB_GuiderUserMsgCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserDeatilMsgCell.h"

@implementation LBB_GuiderUserDeatilMsgCell

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
        
        CGFloat margin = 10;
        
        self.detailString = @"";
        self.iconImageView = [UIImageView new];
        [self.iconImageView setImage:IMAGE(@"导游_导游证号")];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(margin);
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.width.height.mas_equalTo(AutoSize(14));
           // make.width.lessThanOrEqualTo(@(AutoSize(15)));
        }];
        
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setTextColor:ColorGray];
        [self.titleLabel setText:@"导游证号:"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.iconImageView);
            make.left.equalTo(ws.iconImageView.mas_right).offset(2*margin);
            make.width.equalTo(@35);
        }];
        
        self.textField = [UITextField new];
        [self.textField setUserInteractionEnabled:NO];
        [self.textField setTextColor:ColorGray];
        [self.textField setFont:Font15];
        [self.textField setText:@"按实际好的撒大大"];
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.iconImageView);
            make.left.equalTo(ws.titleLabel.mas_right).offset(margin);
            make.right.equalTo(ws.contentView.mas_right).offset(-AutoSize(20) - 20);
        }];
        
        self.rightButton = [UIButton new];
        [self.rightButton setImage:IMAGE(@"导游_下拉箭头") forState:UIControlStateNormal];
        [self.contentView addSubview:self.rightButton];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.iconImageView);
            make.right.equalTo(ws.contentView.mas_right).offset(-2*margin);
            make.width.height.mas_equalTo(AutoSize(20));
        }];
        
        self.sepLineTop = [UIView new];
        [self.sepLineTop setBackgroundColor:ColorLine];
        [self.contentView addSubview:self.sepLineTop];
        [self.sepLineTop mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.iconImageView.mas_bottom).offset(margin);
        }];
        
        //底部
        self.detailLabel = [UILabel new];
        [self.detailLabel setFont:Font15];
        [self.detailLabel setTextColor:ColorGray];
        [self.detailLabel setNumberOfLines:0];
        [self.contentView addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.right.equalTo(ws.contentView).offset(-3*margin);
            make.top.equalTo(ws.sepLineTop.mas_bottom).offset(margin/2);
        }];
        
        self.sepLineBottom = [UIView new];
        [self.sepLineBottom setBackgroundColor:ColorLine];
        [self.contentView addSubview:self.sepLineBottom];
        [self.sepLineBottom mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.detailLabel.mas_bottom).offset(margin/2);
        }];
        
        [self.rightButton bk_whenTapped:^{
            
            ws.click(@0);
            
        }];
    }
    return self;
}

-(void)showBottomContent:(BOOL)show{

    WS(ws);
    CGFloat margin = 10;
    if (show) {
        
        self.rightButton.hidden = NO;
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.right.equalTo(ws.contentView).offset(-3*margin);
            make.top.equalTo(ws.sepLineTop.mas_bottom).offset(margin);
        }];
        

        [self.sepLineBottom mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.detailLabel.mas_bottom).offset(margin);
        }];
        
    }
    else{
        self.rightButton.hidden = YES;
        
        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.right.equalTo(ws.contentView).offset(-3*margin);
            make.top.equalTo(ws.sepLineTop.mas_bottom);
            make.height.equalTo(@0);
        }];
        
        
        [self.sepLineBottom mas_remakeConstraints:^(MASConstraintMaker* make){
            make.centerX.bottom.width.equalTo(ws.contentView);
            make.height.mas_equalTo(0);
            make.top.equalTo(ws.detailLabel.mas_bottom).offset(0);
        }];
    }
    [self.contentView layoutSubviews];
}



-(void)setModel:(id)model{
    
}

@end
