//
//  LBB_ScenicTextTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicTextTableViewCell.h"
#import "PoohCommon.h"
@implementation LBB_ScenicTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    WS(ws);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        CGFloat margin = 8;
        
        self.contentLabel = [UILabel new];
        [self.contentLabel setFont:Font16];
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentLabel setText:@"厦门曾厝垵景区\n暗杀大奥斯卡还打算看的哈啥的佳世客和打开\nsadhjajkdadh1"];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.top.equalTo(ws.contentView).offset(2*margin);
            make.left.equalTo(ws.contentView).offset(2*margin);
            make.right.equalTo(ws.contentView).offset(-2*margin);

        }];
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
            make.top.equalTo(ws.contentLabel.mas_bottom).offset(2*margin);
        }];
        
        self.sepLineView = sep2;
    }
    return self;
}


-(void)setLineInset:(CGFloat)size andHeight:(CGFloat)height{
    WS(ws);
    CGFloat margin = 8;
    [self.sepLineView mas_remakeConstraints:^(MASConstraintMaker* make){
        make.bottom.centerX.equalTo(ws.contentView);
        make.height.mas_equalTo(height);
        make.top.equalTo(ws.contentLabel.mas_bottom).offset(2*margin);
        make.left.equalTo(ws.contentView).offset(size);
        make.right.equalTo(ws.contentView).offset(-size);
        
    }];
    [self.contentView layoutSubviews];
}

@end
