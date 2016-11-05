//
//  LBB_ScenicDetailBookStatusCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/26.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailBookStatusCell.h"

@implementation LBB_ScenicDetailBookStatusCell

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
        
        UIView* sub = [UIView new];
        [self.contentView addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(16);
        }];
        
        self.status1View = [[UIButton alloc]init];
        [self.status1View setImage:IMAGE(@"景点详情_选中HL") forState:UIControlStateNormal];
        [self.status1View setTitle:@"提前一天退" forState:UIControlStateNormal];
        [self.status1View setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.status1View.titleLabel setFont:Font12];
        [self.status1View setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [sub addSubview:self.status1View];
        [self.status1View mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(sub);
         //   make.height.equalTo(@15);
            make.top.bottom.equalTo(sub);
        }];
        
        self.status2View = [[UIButton alloc]init];
        [self.status2View setImage:IMAGE(@"景点详情_选中") forState:UIControlStateNormal];
        [self.status2View setTitle:@"需预约" forState:UIControlStateNormal];
        [self.status2View setTitleColor:ColorGray forState:UIControlStateNormal];
        [self.status2View.titleLabel setFont:Font12];
        [self.status2View setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [sub addSubview:self.status2View];
        [self.status2View mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.status1View.mas_right).offset(30);
            make.right.equalTo(sub);
            make.centerY.height.equalTo(ws.status1View);
        }];

        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(sub.mas_bottom).offset(16);
            make.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth*10);
            make.bottom.equalTo(ws.contentView);
        }];
      
    }
    return self;
}


@end
