//
//  LBB_AddTextToVistNote_Controller.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/29.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_AddTextToVistNote_Controller.h"
#import "Header.h"
#import "LBB_Date_SengeMent.h"
#import "LBB_AddClass_Button.h"
#import "UITextView+Placeholder.h"

@interface LBB_AddTextToVistNote_Controller ()
@property(nonatomic,strong)LBB_Date_SengeMent    *headSegment;
@property(nonatomic,strong)UITextView                       *contentText;
@end

@implementation LBB_AddTextToVistNote_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self initNav];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor]]];

}

- (void)initNav
{
    self.navigationItem.title = @"添加足迹";
    UIBarButtonItem  *rightBrBtn = [[UIBarButtonItem alloc]initWithImage:IMAGE(@"zjmcorfirm") style:0 target:self action:@selector(checkPulish)];
    rightBrBtn.tintColor = UIColorFromRGB(0xAC793B);
    self.navigationItem.rightBarButtonItem = rightBrBtn;
}

- (void)checkPulish
{
    NSLog(@"发布文本");
}

- (void)initView
{
    _headSegment = [[LBB_Date_SengeMent alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, AUTO(32))];
    _headSegment.dateStr = @"124";
    _headSegment.timeStr = @"321";
    _headSegment.blockDatepick = ^(NSInteger tag)
    {
        if(tag == 0)
        {
            NSLog(@"addTime");
        }else{
            NSLog(@"addDate");
        }
    };
    [self.view addSubview:_headSegment];
    
    _contentText = [[UITextView alloc]initWithFrame:CGRectMake(0, _headSegment.bottom, DeviceWidth, AUTO(100))];
    _contentText.placeholder = @"添加文字";
    [self.view addSubview:_contentText];
    
    LBB_AddClass_Button  *addAddres = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, _contentText.bottom, DeviceWidth, AUTO(35))];
    addAddres.titleStr = @"点击添加地点信息";
    [addAddres addTarget:self action:@selector(addAddressFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddres];
    
    UIView  *mapView = [[UIView alloc]initWithFrame:CGRectMake(0, addAddres.bottom + 5, DeviceWidth, AUTO(100))];
    mapView.backgroundColor = [UIColor redColor];
    [self.view addSubview:mapView];
    
    LBB_AddClass_Button  *addSale = [[LBB_AddClass_Button alloc]initWithFrame:CGRectMake(0, mapView.bottom + 5, DeviceWidth, AUTO(35))];
    addSale.titleStr = @"添加消费记录";
    [addSale addTarget:self action:@selector(addSaleFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSale];
    
    UIButton  *publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, DeviceHeight - 44 - 64, DeviceWidth, 44)];
    publishBtn.backgroundColor = ColorBtnYellow;
    [publishBtn setTitle:@"发    布" forState:0];
    [publishBtn setTitleColor:WHITECOLOR forState:0];
    publishBtn.titleLabel.font = FONT(AUTO(14.0));
    [publishBtn addTarget:self action:@selector(publishFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
}

- (void)addAddressFunc
{
    NSLog(@"nicai");
}

- (void)addSaleFunc
{
    NSLog(@"asdfasf");
}

- (void)publishFunc
{
    NSLog(@"publishFunc");
}

@end
