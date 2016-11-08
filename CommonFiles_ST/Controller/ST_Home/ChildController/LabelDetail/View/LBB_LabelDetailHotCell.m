//
//  LBB_LabelDetailHotCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LabelDetailHotCell.h"

@implementation LBB_LabelDetailHotCellItem

-(id)init{
    WS(ws);
    if (self = [super init]) {
        
        self.bgImageView = [UIImageView new];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.center.width.height.equalTo(ws);
        }];
        
        self.labelButton = [UIButton new];
        [self.labelButton setBackgroundImage:IMAGE(@"labelDetailBg") forState:UIControlStateNormal];
        [self.labelButton setTitle:@"美丽" forState:UIControlStateNormal];
        [self.labelButton setTitleColor:ColorWhite forState:UIControlStateNormal];
        [self.labelButton.titleLabel setFont:Font12];
        [self.labelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self addSubview:self.labelButton];
        [self.labelButton mas_makeConstraints:^(MASConstraintMaker*make){
            make.bottom.equalTo(ws).offset(-AutoSize(18));
            make.right.equalTo(ws).offset(-AutoSize(8));
        }];
    }
    return self;
}


@end

@implementation LBB_LabelDetailHotCell

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
        
        self.item1 = [[LBB_LabelDetailHotCellItem alloc]init];
        self.item2 = [[LBB_LabelDetailHotCellItem alloc]init];
        
        
        [self.contentView addSubview:self.item1];
        [self.contentView addSubview:self.item2];
        
        
        CGFloat interval = 8;
        [self.item1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(interval);
            make.top.equalTo(ws.contentView).offset(interval);
            make.bottom.equalTo(ws.contentView);
           // make.height.mas_equalTo(AutoSize(380/2));
            make.height.equalTo(ws.item1.mas_width);
        }];
        
        [self.item2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.item1.mas_right).offset(interval);
            make.top.equalTo(ws.item1);
            make.right.equalTo(ws.contentView).offset(-interval);
            make.width.height.equalTo(ws.item1);
        }];
        
    }
    return self;
}

-(void)setModel:(id)model{
    [self.item1.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
    [self.item2.bgImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/pic/item/c83d70cf3bc79f3d7467e245b8a1cd11738b29c4.jpg"] placeholderImage:IMAGE(PlaceHolderImage)];
}

@end
