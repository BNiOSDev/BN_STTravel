//
//  KSViewPagerView.m
//  KangarooApp
//
//  Created by zhuangyihang on 11/20/15.
//  Copyright © 2015 KangarooFamily. All rights reserved.
//

#import "KSViewPagerView.h"
#import <Foundation/Foundation.h>
#import "UIView+FRCategory.h"

@interface KSViewPagerView()

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UIColor *activeTitleColor;
@property (nonatomic, strong) UIColor *inactiveTitleColor;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) NSMutableArray *seperatorArray;

@end

@implementation KSViewPagerView

- (id)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        self.array = array;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.buttonArray = [NSMutableArray array];
    self.seperatorArray = [NSMutableArray array];
    
    UIView *last = nil;
    for (int i = 0; i < self.array.count; i++) {
        UIButton *b = [UIButton buttonWithType: UIButtonTypeCustom];
        [self addSubview:b];
        [b setTitle:self.array[i] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self);
            make.width.equalTo(self).dividedBy(self.array.count);
            make.centerY.equalTo(self);
            make.left.equalTo(last==nil?@0:last.mas_right);
        }];
        b.tag = i;
        
        UIView *sep = [UIView new];
        [self addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.height.equalTo(@20);
            make.left.equalTo(b.mas_right);
            make.centerY.equalTo(self);
        }];
        sep.backgroundColor = [UIColor colorWithRGB:0xdedede];
        [self.seperatorArray addObject:sep];
        sep.hidden = YES;
        
        [self.buttonArray addObject:b];
        last = b;
    }
    
    UIView *cursor = [UIView new];
    [self addSubview:cursor];
//    [cursor mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(last.mas_width).multipliedBy(0.8);
//        make.bottom.equalTo(self);
//        make.height.equalTo(@2);
//    }];
    cursor.backgroundColor = self.activeTitleColor;
    self.cursorView = cursor;
    [self update];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)click:(UIButton *)sender{
    [self setCursorPosition:sender.tag animated:YES];
    if (self.click) {
        self.click(self,[NSNumber numberWithInteger:sender.tag]);
    }
}

- (NSInteger)getSelectedSegment{
    return self.selectedIndex;
}

- (void)setActiveColor:(UIColor *)color{
    self.activeTitleColor = color;
    self.cursorView.backgroundColor = color;
    [self update];
}

- (void)setInactiveColor:(UIColor *)color{
    self.inactiveTitleColor = color;
    [self update];
}

- (void)setTitleFont:(UIFont *)font{
    for (UIButton *b in self.buttonArray) {
        b.titleLabel.font = font;
    }
}

- (void)update{
    int i = 0;
    for (UIButton *b in self.buttonArray) {
        if (i == self.selectedIndex) {
            [b setTitleColor:self.activeTitleColor forState:UIControlStateNormal];
        }else{
            [b setTitleColor:self.inactiveTitleColor forState:UIControlStateNormal];
        }
        i++;
    }
}

- (void)setCursorPosition:(CGFloat)percent animated:(BOOL)animated{
    if (animated) {
        [self setCursorPosition:percent];
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutSubviews];
        }];
    }else{
        [self setCursorPosition:percent];
    }
}

- (void)setCursorPosition:(CGFloat)pos{
    [self.cursorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        int idx = floor(pos);
        if (idx<0) {
            idx = 0;
        }
        self.selectedIndex = (pos > idx+0.5)?idx+1:idx;
        UIButton *b = [self.buttonArray objectAtIndex:idx];
//        make.left.mas_equalTo(pos*b.width+0.1*b.width);
        make.centerX.equalTo(b.mas_centerX).offset((pos-idx)*b.width);
        
        make.width.equalTo(b.mas_width).multipliedBy(0.8);
        make.bottom.equalTo(self);
        make.height.equalTo(@2);
    }];
    
    [self update];
}

- (void)enableSeperatorView:(BOOL)enable{
    for (UIView *v in self.seperatorArray) {
        if (enable) {
            v.hidden = NO;
        }else{
            v.hidden = YES;
        }
    }
}
@end
