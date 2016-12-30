//
//  LBB_GuiderUserMsgCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/3.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserMsgCell.h"

@implementation LBB_GuiderUserMsgCell

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
      
        self.iconImageView = [UIImageView new];
        [self.iconImageView setImage:IMAGE(@"导游_导游证号")];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(ws.contentView).offset(margin);
            make.left.equalTo(ws.contentView).offset(3*margin);
          //  make.width.height.mas_equalTo(AutoSize(14));
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setTextColor:ColorGray];
        [self.titleLabel setText:@"导游证号:"];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws.iconImageView);
            make.left.equalTo(ws.iconImageView.mas_right).offset(2*margin);
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
            make.right.equalTo(ws.contentView).offset(-margin).priorityLow();
        }];
                
        self.sepLineTop = [UIView new];
        [self.sepLineTop setBackgroundColor:ColorLine];
        [self.contentView addSubview:self.sepLineTop];
        [self.sepLineTop mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.iconImageView.mas_bottom).offset(margin);
        }];
    }
    return self;
}

@end
