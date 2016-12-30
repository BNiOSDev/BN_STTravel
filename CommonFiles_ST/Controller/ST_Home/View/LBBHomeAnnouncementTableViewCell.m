//
//  LBBHomeAnnouncementTableViewCell.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBBHomeAnnouncementTableViewCell.h"
#import "GYChangeTextView.h"
#import "LBB_ToWebViewController.h"
@interface LBBHomeAnnouncementTableViewCell()<GYChangeTextViewDelegate>{

    UILabel* label;
    
    GYChangeTextView *tView;
    
    UIView* sepLine2;
    UILabel* title;
}

@end

@implementation LBBHomeAnnouncementTableViewCell

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
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.left.right.equalTo(ws.contentView);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.bottom.left.right.equalTo(ws.contentView);
            make.height.equalTo(sep);
        }];
        
        UIView* leftBg = [UIView new];
        [leftBg setBackgroundColor:ColorBtnYellow];
        [self.contentView addSubview:leftBg];
        [leftBg mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(ws.contentView);
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(AutoSize(35)-16);
            make.top.equalTo(ws.contentView).offset(8);
            make.bottom.equalTo(ws.contentView).offset(-8);
        }];
        
        title = [UILabel new];
        [title setText:@"鹭爸爸公告"];
        [title setTextColor:[UIColor blackColor]];
        [title setFont:[UIFont boldSystemFontOfSize:AutoSize(14)]];
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(leftBg.mas_right).offset(20);
        }];
        
        
        UIView* sep2 = [UIView new];
        [sep2 setBackgroundColor:ColorLine];
        [self.contentView addSubview:sep2];
        [sep2 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.height.equalTo(leftBg);
            make.width.mas_equalTo(1.2);
            make.left.equalTo(title.mas_right).offset(20);
        }];
        
        sepLine2 = sep2;
        CGFloat x = 3 + 20 + 20 + title.frame.size.width + 25;

        tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(x+40, 0, DeviceWidth-40-x, AutoSize(35))];
        tView.delegate = self;
        [self.contentView addSubview:tView];
        [tView mas_makeConstraints:^(MASConstraintMaker* make){
            
            make.centerY.equalTo(ws.contentView);
            make.left.equalTo(sep2.mas_right).offset(5);
            make.right.equalTo(ws.contentView).offset(-2);
            make.top.bottom.equalTo(ws.contentView);
        }];
        NSArray* array = @[@"IMCCP",@"a iOS developer",@"GitHub:https://github.com/IMCCP"];

        [tView animationWithTexts:array/*[NSArray arrayWithObjects:@"这是第1条",@"这是第2条",@"这是第3条", nil]*/];

        
    }
    return self;
}


-(void)setNoticesArray:(NSMutableArray<BN_HomeNotices *> *)noticesArray{
    
    NSLog(@"setNoticesArray:%@",noticesArray);

    _noticesArray = noticesArray;
    NSMutableArray* texts = [NSMutableArray new];
    for (BN_HomeNotices* obj in noticesArray) {
        
        [texts addObject:obj.title?obj.title:@""];
    }
    [self setScrollTextArray:texts];
}

-(void)setScrollTextArray:(NSArray*)array{

    WS(ws);
    NSLog(@"setScrollTextArray:%@",array);
    
    if (tView) {
        [tView removeFromSuperview];
        tView = nil;
    }
    
    CGFloat x = 3 + 20 + 20 + title.frame.size.width + 25;
    
    tView = [[GYChangeTextView alloc] initWithFrame:CGRectMake(x+40, 0, DeviceWidth-40-x, AutoSize(35))];
    tView.delegate = self;
    [self.contentView addSubview:tView];
    [tView mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(sepLine2.mas_right).offset(5);
        make.right.equalTo(ws.contentView).offset(-2);
        make.top.bottom.equalTo(ws.contentView);
    }];
    
    if (array.count <= 0) {
        [tView animationWithTexts:@[@"暂无公告信息"]];
    }
    else{
        [tView animationWithTexts:array];
    }
}


#pragma GYChangeTextView delegate

- (void)gyChangeTextView:(GYChangeTextView *)textView didTapedAtIndex:(NSInteger)index {
   // NSLog(@"%@ select: %ld",[textView class],index);
    if (self.noticesArray.count > 0) {
        BN_HomeNotices* obj = [self.noticesArray objectAtIndex:index];
        LBB_ToWebViewController* vc = [[LBB_ToWebViewController alloc] init];
        vc.webTitle = obj.title;
        vc.isLoadHtml = YES;
        vc.htmlString = obj.content;
        [[self getViewController].navigationController pushViewController:vc animated:YES];
    }
}

@end
