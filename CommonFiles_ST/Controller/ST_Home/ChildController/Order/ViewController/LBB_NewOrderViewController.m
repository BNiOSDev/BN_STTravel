//
//  LBB_NewOrderViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/27.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_NewOrderViewController.h"
#import "LBB_NewOrderPlayTimeSelectView.h"
#import "LBB_NewOrderTicketTypeInfoView.h"
#import "LBB_NewOrderIntegralView.h"
#import "LBB_NewOrderModifyNoteView.h"
#import "LBB_NewOrderInputTextField.h"
#import "LBB_OrderWaitPayViewController.h"

@interface LBB_NewOrderViewController ()

@property (nonatomic, retain) UIScrollView *mainScrollView;

@property (nonatomic, retain)LBB_NewOrderPlayTimeSelectView* playTimeView;

@property (nonatomic, retain)LBB_NewOrderInputTextField* verCodeField;



@end

@implementation LBB_NewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.mainScrollView setContentSize:CGSizeMake(0, self.verCodeField.frame.origin.y + self.verCodeField.size.height + 15)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)loadCustomNavigationButton{
    self.title = @"确认订单";
}

-(void)buildControls{
    
    WS(ws);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.mainScrollView = [UIScrollView new];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.mainScrollView setContentSize:CGSizeMake(0, UISCREEN_HEIGTH)];
    [self.mainScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view);
      //  make.bottom.equalTo(ws.view);
        make.width.centerX.equalTo(ws.view);
    }];
    
    CGFloat margin = 8;
    
    self.playTimeView = [[LBB_NewOrderPlayTimeSelectView alloc]init];
    [self.mainScrollView addSubview:self.playTimeView];
    [self.playTimeView mas_makeConstraints:^(MASConstraintMaker* make){
    
        make.centerX.top.width.equalTo(ws.mainScrollView);
        make.height.mas_equalTo(AutoSize(138/2));
    }];
    
    
    //描绘门票类型部分的UI
    
    LBB_NewOrderTicketTypeInfoView* ticketInfo = [[LBB_NewOrderTicketTypeInfoView alloc]init];
    [self.mainScrollView addSubview:ticketInfo];
    [ticketInfo mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.top.equalTo(ws.playTimeView.mas_bottom);
        make.right.equalTo(ws.playTimeView);
    }];
    [ticketInfo setTicketInfo:nil];
    
   
    //描绘积分抵扣信息的UI
    LBB_NewOrderIntegralView* integralInfo = [[LBB_NewOrderIntegralView alloc]init];
    [self.mainScrollView addSubview:integralInfo];
    [integralInfo mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.top.equalTo(ticketInfo.mas_bottom);
        make.right.equalTo(ws.playTimeView);
    }];
    if (!self.isIntegral) {//没有积分抵扣的情况
        [integralInfo mas_remakeConstraints:^(MASConstraintMaker* make){
            make.left.equalTo(ws.mainScrollView);
            make.top.equalTo(ticketInfo.mas_bottom);
            make.right.equalTo(ws.playTimeView);
            make.height.mas_equalTo(0);
        }];
        integralInfo.hidden = YES;
    }
    
    
    
    //合计
    UILabel* totalLabel = [UILabel new];
    [totalLabel setText:@"合计"];
    [totalLabel setTextColor:ColorLightGray];
    [totalLabel setFont:Font13];
    [self.mainScrollView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView).offset(2*margin);
        make.top.equalTo(integralInfo.mas_bottom).offset(2*margin);
    }];
    
    UILabel* totalPriceLabel = [UILabel new];
    [totalPriceLabel setText:@"￥200.00"];
    [totalPriceLabel setTextColor:ColorRed];
    [totalPriceLabel setFont:Font15];
    [self.mainScrollView addSubview:totalPriceLabel];
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.right.equalTo(ws.playTimeView).offset(-2*margin);
        make.centerY.equalTo(totalLabel);
    }];
    
    UIView* sep = [UIView new];
    [sep setBackgroundColor:ColorLine];
    [self.mainScrollView addSubview:sep];
    [sep mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(totalLabel);
        make.right.equalTo(totalPriceLabel);
        make.height.mas_equalTo(SeparateLineWidth);
        make.top.equalTo(totalLabel.mas_bottom).offset(2*margin);
    }];
    
    //退改说明
    LBB_NewOrderModifyNoteView* modifyNoteView = [[LBB_NewOrderModifyNoteView alloc]init];
    modifyNoteView.isOpen = YES;
    [self.mainScrollView addSubview:modifyNoteView];
    [modifyNoteView mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.top.equalTo(sep.mas_bottom);
        make.right.equalTo(ws.playTimeView);
    }];
    
    //取票人信息
    UILabel* touristsLabel = [UILabel new];
    [touristsLabel setText:@"取票人信息"];
    [touristsLabel setFont:Font13];
    [self.mainScrollView addSubview:touristsLabel];
    [touristsLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView).offset(2*margin);
        make.top.equalTo(modifyNoteView.mas_bottom).offset(2*margin);
    }];
    
    #pragma 姓名
    LBB_NewOrderInputTextField* nameField = [[LBB_NewOrderInputTextField alloc]init];
    [nameField.titleLabel setText:@"姓  名"];
    [self.mainScrollView addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.right.equalTo(ws.playTimeView);
        make.top.equalTo(touristsLabel.mas_bottom).offset(2*margin);
    }];
    #pragma 手机号码
    LBB_NewOrderInputTextField* telField = [[LBB_NewOrderInputTextField alloc]init];
    [telField.textField setKeyboardType:UIKeyboardTypePhonePad];
    [telField.titleLabel setText:@"手机号码"];
    [self.mainScrollView addSubview:telField];
    [telField mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.right.equalTo(ws.playTimeView);
        make.top.equalTo(nameField.mas_bottom);
    }];
    #pragma 验证码
    LBB_NewOrderInputTextField* verCodeField = [[LBB_NewOrderInputTextField alloc]init];
    [verCodeField.titleLabel setText:@"验 证 码"];
    [verCodeField showRightButton:YES];
    [self.mainScrollView addSubview:verCodeField];
    [verCodeField mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.right.equalTo(ws.playTimeView);
        make.top.equalTo(telField.mas_bottom);
    }];
    self.verCodeField = verCodeField;
   
    UIView* sep1 = [UIView new];
    [sep1 setBackgroundColor:ColorLine];
    [self.mainScrollView addSubview:sep1];
    [sep1 mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(ws.mainScrollView);
        make.right.equalTo(ws.playTimeView);
        make.height.mas_equalTo(SeparateLineWidth);
        make.top.equalTo(verCodeField.mas_bottom);
    }];
    
    //配置底部的控制栏
    UIView* toolBar = [UIView new];
    [toolBar setBackgroundColor:ColorWhite];
    toolBar.layer.borderColor = ColorLine.CGColor;
    toolBar.layer.borderWidth = 1;
    [self.view addSubview:toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker* make){
        make.centerX.bottom.equalTo(ws.view);
        make.height.mas_equalTo(AutoSize(75/2));
        make.top.equalTo(ws.mainScrollView.mas_bottom);
        make.left.equalTo(ws.view).offset(-1);
        make.right.equalTo(ws.view).offset(1);
    }];
    
    UILabel* l = [UILabel new];
    [l setText:@"实付款:"];
    [l setFont:Font15];
    [toolBar addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.left.equalTo(toolBar).offset(2*margin);
        make.centerY.equalTo(toolBar);
    }];
    
    
    UILabel* toolPriceLabel = [UILabel new];
    [toolPriceLabel setText:@"￥236.00"];
    [toolPriceLabel setFont:Font16];
    [toolPriceLabel setTextColor:ColorRed];
    [toolBar addSubview:toolPriceLabel];
    [toolPriceLabel mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.left.equalTo(l.mas_right).offset(margin);
        make.centerY.equalTo(toolBar);
    }];
    
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolBar addSubview:orderButton];
    [orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
      //  make.left.equalTo(toolPriceLabel.mas_right).offset(margin);
        make.right.equalTo(toolBar.mas_right).offset(-1);
        make.top.bottom.equalTo(toolBar);
        make.width.mas_equalTo(AutoSize(250/2));
    }];
    [orderButton setTitle:@"立即下单" forState:UIControlStateNormal];
    [orderButton setBackgroundColor:ColorBtnYellow];
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    orderButton.titleLabel.font = Font15;
    [orderButton bk_addEventHandler:^(id sender){
        
        LBB_OrderWaitPayViewController* dest = [[LBB_OrderWaitPayViewController alloc]init];
        dest.ticketStatus = arc4random()%5;
        [ws.navigationController pushViewController:dest animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];

}


@end
