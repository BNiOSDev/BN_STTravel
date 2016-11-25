//
//  LBB_PulishContain_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/11/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_PulishContain_ViewController.h"
#import "Header.h"
#import "LBB_Pulish_ImageContain_View.h"
#import "LBB_EditPulishContain_Controller.h"

@interface LBB_PulishContain_ViewController ()
@property(nonatomic, strong)LBB_Pulish_ImageContain_View   *imageContainView;
@end

@implementation LBB_PulishContain_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布内容";
    self.view.backgroundColor = ColorWhite;
    
    UIBarButtonItem  *backItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:0 target:self action:@selector(backToController)];
    backItem.tintColor = [UIColor blueColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self initView];
}

- (void)backToController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initView
{
    UILabel  *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, AUTO(10.0), DeviceWidth, AUTO(20))];
    tipLabel.font = FONT(AUTO(12.0));
    tipLabel.textColor = MORELESSBLACKCOLOR;
    tipLabel.text = @"点击图片添加标签，至少添加一个标签";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    _imageContainView = [[LBB_Pulish_ImageContain_View alloc]initWithFrame:CGRectMake(AUTO(5), tipLabel.bottom + AUTO(10), DeviceWidth - AUTO(10), DeviceWidth - AUTO(20))];
    _imageContainView._blockAddTip = ^(UIView *view)
    {
        NSLog(@"这是什么鬼");
    };
    _imageContainView.imageArray = _selectImageArray;
    [self.view addSubview:_imageContainView];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(AUTO(30), _imageContainView.bottom + AUTO(20), DeviceWidth - AUTO(60), AUTO(45))
                         ];
    nextBtn.backgroundColor = UIColorFromRGB(0xAB783A);
    [nextBtn setTitle:@"下一步" forState:0];
    [nextBtn setTitleColor:WHITECOLOR forState:0];
    nextBtn.titleLabel.font = FONT(AUTO(15));
    [nextBtn addTarget:self action:@selector(editPulish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

- (void)editPulish
{
    LBB_EditPulishContain_Controller *Vc = [[LBB_EditPulishContain_Controller alloc]init];
    Vc.imageArray = self.selectImageArray;
    [self.navigationController pushViewController:Vc animated:YES];
}

@end
