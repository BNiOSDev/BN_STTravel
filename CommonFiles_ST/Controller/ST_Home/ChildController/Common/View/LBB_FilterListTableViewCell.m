//
//  LBB_FilterListTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/16.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FilterListTableViewCell.h"

@interface LBB_FilterListTableViewCell()
    
@property(nonatomic, retain)UIImageView* iconImageView;
@property(nonatomic, retain)UILabel* titleLabel;
@property(nonatomic, retain)UIView* sepLineView;

    
@end


@implementation LBB_FilterListTableViewCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;

        
        self.sepLineView = [UIView new];
        [self.sepLineView setBackgroundColor:ColorLine];
        [self.contentView addSubview:self.sepLineView];
        [self.sepLineView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.bottom.right.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
            make.left.equalTo(ws.contentView).offset(10);
        }];
        
    }
    return self;
}
-(void)showAccessoryView:(BOOL)show{
    
}
-(void)showSepLineView:(BOOL)show{
    
    if (show) {
        self.sepLineView.hidden = NO;
    }
    else{
        self.sepLineView.hidden = YES;
    }
}
    
@end
