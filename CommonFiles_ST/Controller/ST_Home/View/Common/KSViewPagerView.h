//
//  KSViewPagerView.h
//  KangarooApp
//
//  Created by zhuangyihang on 11/20/15.
//  Copyright © 2015 KangarooFamily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoohCommon.h"

@interface KSViewPagerView : UIView

//View
@property (nonatomic, strong) UIView *cursorView;

//
@property (nonatomic, strong) ClickBlockEx click;

- (id)initWithArray:(NSArray *)array;

- (NSInteger)getSelectedSegment;



- (void)setupUI;
- (void)setCursorPosition:(CGFloat)percent;
- (void)setCursorPosition:(CGFloat)percent animated:(BOOL)animated;

- (void)setActiveColor:(UIColor *)color;
- (void)setInactiveColor:(UIColor *)color;
- (void)setTitleFont:(UIFont *)font;

- (void)enableSeperatorView:(BOOL)enable;

@end
