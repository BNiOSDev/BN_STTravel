//
//  LBB_NewOrderPlayTimeSelectView.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderPlayTimeSelectView.h"
#import "PoohCommon.h"
#import "ActionSheetDatePicker.h"
@implementation LBB_NewOrderPlayTimeSelectView

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
        
        UIView* sep = [UIView new];
        [sep setBackgroundColor:ColorLine];
        [self addSubview:sep];
        [sep mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.top.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        CGFloat margin = 8;
        
        self.titleLabel = [UILabel new];
        [self.titleLabel setFont:Font15];
        [self.titleLabel setTextColor:ColorGray];
        [self.titleLabel setText:@"游玩时间"];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws).offset(2*margin);
            make.centerY.equalTo(ws);
            make.width.mas_equalTo(AutoSize(120/2));
        }];
        [self.titleLabel sizeToFit];
        
    
        
        self.todayView = [[LBBPoohVerticalLableControl alloc]init];
        [self.todayView.titleLabel setText:@"今天"];
        [self.todayView.subTitleLabel setText:[self getDateWithoutYear:[NSDate new]]];
        [self addSubview:self.todayView];
        
        self.tomorrowView = [[LBBPoohVerticalLableControl alloc]init];
        [self.tomorrowView.titleLabel setText:@"明天"];
        [self.tomorrowView.subTitleLabel setText:[self getDateWithoutYear:[NSDate dateWithDaysFromNow:1]]];
        [self addSubview:self.tomorrowView];
        
        self.afterTomorrowView = [[LBBPoohVerticalLableControl alloc]init];
        [self.afterTomorrowView.titleLabel setText:@"后天"];
        [self.afterTomorrowView.subTitleLabel setText:[self getDateWithoutYear:[NSDate dateWithDaysFromNow:2]]];
        [self addSubview:self.afterTomorrowView];
        
        self.otherDayView = [[LBBPoohVerticalLableControl alloc]init];
        [self.otherDayView.titleLabel setText:@"其他"];
        [self.otherDayView.subTitleLabel setText:@"日期"];
        [self addSubview:self.otherDayView];
        
        //布局
        
        [self.todayView mas_makeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.titleLabel.mas_right).offset(2*margin);
            make.centerY.equalTo(ws);
            make.top.equalTo(ws).offset(2*margin);
            make.bottom.equalTo(ws).offset(-2*margin);
        }];
        
        [self.tomorrowView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws);
            make.left.equalTo(ws.todayView.mas_right).offset(margin);
            make.width.height.equalTo(ws.todayView);
        }];
        
        [self.afterTomorrowView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws);
            make.left.equalTo(ws.tomorrowView.mas_right).offset(margin);
            make.width.height.equalTo(ws.todayView);
        }];
        
        [self.otherDayView mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerY.equalTo(ws);
            make.left.equalTo(ws.afterTomorrowView.mas_right).offset(margin);
            make.width.height.equalTo(ws.todayView);
            make.right.equalTo(ws).offset(-2*margin);
        }];
        
        UIView* sep1 = [UIView new];
        [sep1 setBackgroundColor:ColorLine];
        [self addSubview:sep1];
        [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.width.bottom.equalTo(ws);
            make.height.mas_equalTo(SeparateLineWidth);
        }];
        
        //事件控制
        [self.todayView bk_whenTapped:^{
            ws.selectIndex = 0;
            ws.selectTime = [PoohAppHelper getStringFromDate:[NSDate new] withFormat:DateFormatFullDate];
        }];
        
        [self.tomorrowView bk_whenTapped:^{
            ws.selectIndex = 1;
            ws.selectTime = [PoohAppHelper getStringFromDate:[NSDate dateWithDaysFromNow:1] withFormat:DateFormatFullDate];
        }];
 
        [self.afterTomorrowView bk_whenTapped:^{
            ws.selectIndex = 2;
            ws.selectTime = [PoohAppHelper getStringFromDate:[NSDate dateWithDaysFromNow:2] withFormat:DateFormatFullDate];
        }];

        [self.otherDayView bk_whenTapped:^{
            
            ws.selectIndex = 3;
            [ActionSheetDatePicker showPickerWithTitle:NSLocalizedString(@"选择日期", nil)
                                        datePickerMode:UIDatePickerModeDate
                                          selectedDate:[NSDate date]
                                             doneBlock:^(ActionSheetDatePicker *picker, NSDate* selectedDate, id origin){
                                                 NSLog(@"selectedDate =  %@",selectedDate);
                                                // [weakSelf reloadTableView:eBirthDate content:[weakSelf stringFromDate:selectedDate]];
                                                 ws.selectTime = [PoohAppHelper getStringFromDate:selectedDate withFormat:DateFormatFullDate];
                                                 NSLog(@" ws.selectTime =  %@", ws.selectTime);

                                                 [ws.otherDayView.subTitleLabel setText:[ws getDateWithoutYear:selectedDate]];
                                                 
                                             }
                                           cancelBlock:^(ActionSheetDatePicker *picker){
                                               
                                           }  origin:[self getViewController].view];

        }];
    
        @weakify (self);
        [RACObserve(self, selectIndex) subscribeNext:^(NSNumber* index) {
            @strongify(self);
            [self.todayView setBackgroundColor:[UIColor whiteColor]];
            [self.tomorrowView setBackgroundColor:[UIColor whiteColor]];
            [self.afterTomorrowView setBackgroundColor:[UIColor whiteColor]];
            [self.otherDayView setBackgroundColor:[UIColor whiteColor]];

            switch ([index integerValue]) {
                case 0:
                    [self.todayView setBackgroundColor:ColorBtnYellow];
                    break;
                case 1:
                    [self.tomorrowView setBackgroundColor:ColorBtnYellow];
                    break;
                case 2:
                    [self.afterTomorrowView setBackgroundColor:ColorBtnYellow];
                    break;
                case 3:
                    [self.otherDayView setBackgroundColor:ColorBtnYellow];
                    break;
                default:
                    break;
            }
        }];
        
        
    }
    return self;
}

-(NSString*)getDateWithoutYear:(NSDate*)date{

    NSString* ret = @"";
    ret = [PoohAppHelper getStringFromDate:date withFormat:DateFormatFullDate];
    NSRange range = [ret rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        
        ret = [ret substringFromIndex:range.location+range.length];
    }
    return ret;
}

@end
