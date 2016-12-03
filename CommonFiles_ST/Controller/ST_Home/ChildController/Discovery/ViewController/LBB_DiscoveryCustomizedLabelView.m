//
//  LBB_GuiderApplyLabelSelectView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/11/2.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_DiscoveryCustomizedLabelView.h"
#import "PoohCommon.h"
static const NSInteger kViewMarginLeft = 0;

static const NSInteger kPictureMaxCol = 3;
static const NSInteger kPictureInterval = 5;

@interface LBB_DiscoveryCustomizedLabelView()


@end

@implementation LBB_DiscoveryCustomizedLabelView

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
        
        self.contentView = [UIView new];
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker* make){
            make.center.width.height.equalTo(ws);
        }];
        
    }
    return self;
}



-(void)refreshContentView{
    
    WS(ws);
    
    [self configSelectArray];
    [self.contentView removeAllSubviews];
    
    CGFloat margin = 8;
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 100 - 2 * kViewMarginLeft - (kPictureMaxCol-1)*kPictureInterval)/kPictureMaxCol;
    CGFloat height = AutoSize(50/2);
    
    UIView *lastView = nil;
    
    NSInteger count  = self.textArray.count;
    
    for (int i = 0; i < count; i++) {
        UIButton *v = [UIButton new];
        LBB_SquareTags* tag = [self.textArray objectAtIndex:i];
        [v setTitle:tag.tagName forState:UIControlStateNormal];
        [v.titleLabel setFont:Font13];
        [v setTitleColor:ColorBlack forState:UIControlStateNormal];
        [v setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];

        BOOL b = [self.flagArray[i] boolValue];
        if (!b) {
            [v setImage:IMAGE(@"ST_Discovery_DeSelect") forState:UIControlStateNormal];
        }
        else{
            [v setImage:IMAGE(@"ST_Discovery_Select") forState:UIControlStateNormal];

        }

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
        
        LBB_SquareTags *s = self.textArray[i];
        BOOL isSelect = NO;
        for (LBB_SquareTags *ss in self.selectArray) {
            if (s.tagId == ss.tagId) {
                isSelect = YES;
                break;
            }
        }
        
        [self.flagArray addObject:@(isSelect)];
    }
    
    [self refreshContentView];
}

-(void)configSelectArray{
    
    NSMutableArray *result = [NSMutableArray array];
    NSInteger idx = 0;
    for (NSNumber *flag in self.flagArray) {
        if ([flag boolValue]) {
            [result addObject:self.textArray[idx]];
            
        }
        
        idx++;
    }
    
    self.selectArray = result;
    
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
