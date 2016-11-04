//
//  LBB_GuiderUserDynamicCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/4.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderUserDynamicCell.h"

@implementation LBB_GuiderUserDynamicCellItem

-(id)init{
    WS(ws);
    if (self = [super init]) {
        
        self.bgImageView = [UIImageView new];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.center.width.height.equalTo(ws);
        }];

    }
    return self;
}


@end

@implementation LBB_GuiderUserDynamicCell

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
        
        self.item1 = [[LBB_GuiderUserDynamicCellItem alloc]init];
        self.item2 = [[LBB_GuiderUserDynamicCellItem alloc]init];
        
        
        [self.contentView addSubview:self.item1];
        [self.contentView addSubview:self.item2];
        
        
        CGFloat interval = 8;
        
      //  CGFloat width = (DeviceWidth - interval - interval - interval/2)/2;
        
        [self.item1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(interval);
            make.top.equalTo(ws.contentView).offset(interval/2);
            make.bottom.equalTo(ws.contentView);
            make.height.equalTo(ws.item1.mas_width);
        }];
        
        [self.item2 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.item1.mas_right).offset(interval/2);
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
