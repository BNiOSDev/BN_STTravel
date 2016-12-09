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
      /*
        CGFloat margin = 8;
        
        self.labelButton1 = [UIButton new];
        [self.labelButton1 setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        self.labelButton1.layer.borderColor = ColorBtnYellow.CGColor;
        self.labelButton1.layer.borderWidth = 2/2;
        self.labelButton1.layer.masksToBounds = YES;
        [self.labelButton1.titleLabel setFont:Font13];
        [self.contentView addSubview:self.labelButton1];
        
      
        self.labelButton2 = [UIButton new];
        [self.labelButton2 setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        self.labelButton2.layer.borderColor = ColorBtnYellow.CGColor;
        self.labelButton2.layer.borderWidth = 2/2;
        self.labelButton2.layer.masksToBounds = YES;
        [self.labelButton2.titleLabel setFont:Font13];
        [self.contentView addSubview:self.labelButton2];
        
        self.labelButton3 = [UIButton new];
        [self.labelButton3 setTitleColor:ColorBtnYellow forState:UIControlStateNormal];
        self.labelButton3.layer.borderColor = ColorBtnYellow.CGColor;
        self.labelButton3.layer.borderWidth = 2/2;
        self.labelButton3.layer.masksToBounds = YES;
        [self.labelButton3.titleLabel setFont:Font13];
        [self.contentView addSubview:self.labelButton3];
        
        [self.labelButton1 setTitle:@"拍照圣地" forState:UIControlStateNormal];
        [self.labelButton2 setTitle:@"舒适" forState:UIControlStateNormal];
        [self.labelButton3 setTitle:@"小清新" forState:UIControlStateNormal];

        [self.labelButton1 mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.left.equalTo(ws.contentView).offset(3*margin);
            make.top.equalTo(ws.contentView).offset(margin);
            make.bottom.equalTo(ws.contentView).offset(-0);
            make.height.mas_equalTo(AutoSize(28));
        }];
        
        [self.labelButton2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.width.height.equalTo(ws.labelButton1);
            make.left.equalTo(ws.labelButton1.mas_right).offset(margin);
        }];
        
        [self.labelButton3 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.width.height.equalTo(ws.labelButton1);
            make.left.equalTo(ws.labelButton2.mas_right).offset(margin);
            make.right.equalTo(ws.contentView).offset(-3*margin);
        }];*/
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
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/kPictureMaxCol;
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
