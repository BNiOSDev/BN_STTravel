//
//  LBB_FilterTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/15.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_FilterTableViewCell.h"

@interface LBB_FilterTableViewCell()
    
@property(nonatomic, retain)UIView* filterView;
@property (nonatomic, strong) NSArray *textArray;

@end

static const NSInteger kViewMarginLeft = 10;

static const NSInteger kPictureMaxCol = 3;
static const NSInteger kPictureInterval = 5;

@implementation LBB_FilterTableViewCell

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
        
        self.bottomMargin = AutoSize(15);
        self.borderWidth = SeparateLineWidth*0.8;
        self.buttonFont = Font13;
        self.titleColor = ColorGray;
        self.borderColor = ColorLine;
        self.buttonBgColor = ColorWhite;
        
        self.selectTitleColor = ColorBtnYellow;
        self.selectBorderColor = ColorBtnYellow;
        self.selectButtonBgColor = [UIColor colorWithRGB:0xfbf8f3];
        
        
        self.filterView = [UIView new];
        [self.contentView addSubview:self.filterView];
        [self.filterView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.center.width.height.equalTo(ws.contentView);
        }];
    }
    return self;
}

-(void)configContentView:(NSArray*)array{

    WS(ws);
    
    [self.contentView removeAllSubviews];
    
    self.textArray = array;
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * kViewMarginLeft - (kPictureMaxCol-1)*kPictureInterval)/kPictureMaxCol;
    CGFloat height = AutoSize(50/2);
    
    UIView *lastView = nil;
    
    NSInteger count  = self.textArray.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setTitle:[self.textArray objectAtIndex:i] forState:UIControlStateNormal];
        
        if (i != self.selectIndex) {
            [v setTitleColor:self.titleColor forState:UIControlStateNormal];
            v.layer.borderColor = self.borderColor.CGColor;
            [v setBackgroundColor:self.buttonBgColor];
        }
        else{
            [v setTitleColor:self.selectTitleColor forState:UIControlStateNormal];
            v.layer.borderColor = self.selectBorderColor.CGColor;
            [v setBackgroundColor:self.selectButtonBgColor];
        }
        [v.titleLabel setFont:self.buttonFont];
        v.layer.borderWidth = self.borderWidth;
        v.layer.masksToBounds = YES;
        
        
        [self.contentView addSubview:v];
        
        int col = i % kPictureMaxCol;
        int row = i / kPictureMaxCol;
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.left.equalTo(ws.contentView).offset(col*(width+kPictureInterval)+kViewMarginLeft);
            make.top.equalTo(ws.contentView).offset(row*(height+kPictureInterval) + kPictureInterval);
            if (i == count - 1) {
                make.bottom.equalTo(ws.contentView).offset(-ws.bottomMargin);
            }
        }];
        v.tag = i;
        lastView = v;
        
        [v bk_addEventHandler:^(id sender){
            
            NSNumber* num = [NSNumber numberWithInteger:v.tag];
            ws.click(num);
            
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self layoutSubviews];
}

+(CGFloat)getCellHeight:(NSArray*)array{

    CGFloat cellHeight = 0;
    CGFloat height = AutoSize(50/2);
    
    NSInteger row = ceil(array.count / 3.0);
    NSLog(@"row:%ld",row);
    cellHeight = row*(height+kPictureInterval) + AutoSize(15);
    
    return cellHeight;
}
    
    
@end
