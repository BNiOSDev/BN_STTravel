//
//  LBB_ScenicDetailSubjectLableCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ScenicDetailSubjectLableCell.h"

static const NSInteger kViewMarginLeft = 25;

static const NSInteger kPictureMaxCol = 3;
static const NSInteger kPictureInterval = 8;

@interface LBB_ScenicDetailSubjectLableCell()

@property(nonatomic, retain)UIView* panelView;

@end

@implementation LBB_ScenicDetailSubjectLableCell

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
        self.panelView = [UIView new];
        [self.panelView setBackgroundColor:ColorWhite];
        [self.contentView addSubview:self.panelView];
        [self.panelView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.right.bottom.equalTo(ws.contentView);
            make.top.equalTo(ws.contentView).offset(8);
        }];
        
    }
    return self;
}


-(void)setTags:(NSMutableArray<LBB_SpotsTag *> *)tags{
    
    _tags = tags;
    
    [self.panelView removeAllSubviews];
    WS(ws);
    CGFloat margin = 8;
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*kViewMarginLeft - 2*kPictureInterval)/kPictureMaxCol;
    CGFloat height = AutoSize(58/2);
    
    UIView *lastView = nil;
    
    NSInteger count  = tags.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *v = [UIButton new];
        LBB_SpotsTag* tag = [tags objectAtIndex:i];
        [v setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        v.layer.borderColor = ColorBtnYellow.CGColor;
        v.layer.borderWidth = 2/2;
        v.layer.masksToBounds = YES;
        [v.titleLabel setFont:Font13];
        [v setTitle:tag.name forState:UIControlStateNormal];
        [self.panelView addSubview:v];
        
        int col = i % kPictureMaxCol;
        int row = i / kPictureMaxCol;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.left.equalTo(ws.panelView).offset(col*(width+kPictureInterval)+kViewMarginLeft);
            make.top.equalTo(ws.panelView).offset(row*(height+kPictureInterval) + kViewMarginLeft - 3);
            if (i == count - 1) {
                make.bottom.equalTo(ws.panelView).offset(-margin);
            }
        }];
        v.tag = i;
        lastView = v;
        
        [v bk_addEventHandler:^(id sender){
            
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self.contentView layoutSubviews];
}

@end
