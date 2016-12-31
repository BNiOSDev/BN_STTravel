//
//  LBBDiscoveryDetailImageViewCell.m
//  ST_Travel
//
//  Created by pooh on 16/12/30.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBDiscoveryDetailImageViewCell.h"
#import "PoohCommon.h"
@implementation LBBDiscoveryDetailImageViewCell

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
        [self.contentView setBackgroundColor:ColorWhite];
        self.bgImageView = [UIImageView new];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.equalTo(ws.contentView);
            make.top.bottom.equalTo(ws.contentView);
            make.height.mas_equalTo(AutoSize(344/2));
        }];
        
       
    }
    return self;
}
@end
