//
//  LBB_OrderQrCodeCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_OrderQrCodeCell.h"

@implementation LBB_OrderQrCodeCell

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
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.centerX.width.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        self.qrCodeLabel = [UILabel new];
        [self.qrCodeLabel setText:@"取票兑换码:1234567890"];
        [self.qrCodeLabel setFont:Font15];
        [self.qrCodeLabel setTextColor:ColorGray];
        [self.qrCodeLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.qrCodeLabel];
        [self.qrCodeLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(2*margin);
        }];
        
        UILabel* note = [UILabel new];
        [note setFont:Font13];
        [note setTextColor:ColorBtnYellow];
        [note setTextAlignment:NSTextAlignmentCenter];
        [note setText:@"扫描二维码取票"];
        [self.contentView addSubview:note];
        [note mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.qrCodeLabel.mas_bottom).offset(2*margin);
        }];
        
        
        self.qrCodeImageView = [UIImageView new];
        [self.contentView addSubview:self.qrCodeImageView];
        [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(note.mas_bottom).offset(2*margin);
            make.width.height.mas_equalTo(AutoSize(320/2));
        }];
        
        UILabel* note2 = [UILabel new];
        [note2 setFont:Font13];
        [note2 setTextColor:ColorBlack];
        [note2 setTextAlignment:NSTextAlignmentCenter];
        [note2 setText:@"请您在有效期内取票并观景，如过期该门票将作废"];
        [self.contentView addSubview:note2];
        [note2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.qrCodeImageView.mas_bottom).offset(2*margin);
            make.bottom.equalTo(ws.contentView).offset(-2*margin);

        }];
        
    }
    return self;
}

-(void)setModel:(id)model{
    
    [self.qrCodeLabel setText:@"取票兑换码:1234567890"];
    [self.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.baike.soso.com/p/20131211/20131211091752-393669037.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.qrCodeImageView setBackgroundColor:[UIColor getRandomColor]];
}

@end
