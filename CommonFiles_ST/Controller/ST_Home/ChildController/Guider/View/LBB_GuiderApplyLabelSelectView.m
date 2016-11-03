//
//  LBB_GuiderApplyLabelSelectView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_GuiderApplyLabelSelectView.h"
#import "PoohCommon.h"
static const NSInteger kViewMarginLeft = 10;

static const NSInteger kPictureMaxCol = 3;
static const NSInteger kPictureInterval = 5;

@interface LBB_GuiderApplyLabelSelectView()

@property(nonatomic, retain)UIView* mark;

@end

@implementation LBB_GuiderApplyLabelSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    
    WS(ws);
    if (self = [super init]) {
        
        self.canMultiSel = YES;

        
        CGFloat margin = 8;

        UILabel* mark = [UILabel new];
        [mark setTextColor:ColorRed];
        [mark setFont:Font15];
        [mark setText:@"*"];
        [self addSubview:mark];
        [mark mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(margin);
            make.top.equalTo(ws).offset(1.5*margin);
            make.width.mas_equalTo(AutoSize(6));
        }];
        [mark sizeToFit];
        self.mark = mark;
        
        
        UILabel* titleLable = [UILabel new];

        titleLable = [UILabel new];
        [titleLable setTextColor:ColorGray];
        [titleLable setFont:Font15];
        [titleLable setText:@"选择标签(可多选)"];
        [self addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(mark);
            make.left.equalTo(mark.mas_right).offset(3);
        }];
        
        self.contentView = [UIView new];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(mark.mas_bottom).offset(margin);
            make.centerX.bottom.width.equalTo(ws);
        }];
        
    }
    return self;
}



-(void)refreshContentView{
    
    WS(ws);

    [self.contentView removeAllSubviews];
    
    CGFloat margin = 8;
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * kViewMarginLeft - (kPictureMaxCol-1)*kPictureInterval)/kPictureMaxCol;
    CGFloat height = AutoSize(50/2);
    
    UIView *lastView = nil;
    
    NSInteger count  = self.textArray.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *v = [UIButton buttonWithType:UIButtonTypeSystem];
        [v setTitle:[self.textArray objectAtIndex:i] forState:UIControlStateNormal];
        
        BOOL b = [self.flagArray[i] boolValue];
        if (!b) {
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
            make.top.equalTo(ws.contentView).offset(row*(height+kPictureInterval) + kViewMarginLeft - 3);
            if (i == count - 1) {
                make.bottom.equalTo(ws.contentView).offset(-margin);
            }
        }];
        v.tag = i;
        lastView = v;
        
        [v bk_addEventHandler:^(id sender){
            
            BOOL b = [ws.flagArray[i] intValue];
            
            //非多选，重置标志
            if (!ws.canMultiSel) {
                [ws.flagArray removeAllObjects];
                for (NSInteger i = 0; i < ws.textArray.count; i++) {
                    [ws.flagArray addObject:@(NO)];
                }
            }
            
            [ws.flagArray replaceObjectAtIndex:i withObject:@(!b)];
            
            if (!ws.canMultiSel) {
                [ws save];
            }
            [ws refreshContentView];

        } forControlEvents:UIControlEventTouchUpInside];

    }
    
    
    [self layoutSubviews];
}

-(void)configContentView:(NSArray*)array{
    self.textArray = array;
    
    //初始化全部未选择
    self.flagArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.textArray.count; i++) {
        
        NSString *s = self.textArray[i];
        BOOL isSelect = NO;
        for (NSString *ss in self.selectArray) {
            if ([s isEqualToString:ss]) {
                isSelect = YES;
                break;
            }
        }
        
        [self.flagArray addObject:@(isSelect)];
    }
    
    [self refreshContentView];
}

- (void)save{
    if (self.click) {
        NSMutableArray *result = [NSMutableArray array];
        NSInteger idx = 0;
        for (NSNumber *flag in self.flagArray) {
            if ([flag boolValue]) {
                [result addObject:self.textArray[idx]];
                
            }
            
            idx++;
        }
        self.click(result);
    }
}

@end
