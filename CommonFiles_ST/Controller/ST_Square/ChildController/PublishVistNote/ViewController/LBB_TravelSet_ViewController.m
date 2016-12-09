//
//  LBB_TravelSet_ViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/12/9.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_TravelSet_ViewController.h"

@interface LBB_TravelSet_ViewController ()
{
    NSInteger  tag;
}
@property(nonatomic,strong)NSArray  *itemArray;
@end

@implementation LBB_TravelSet_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"游记设置";
    self.view.backgroundColor = WHITECOLOR;
    _itemArray = @[@{@"image":@"zjmgongkai",@"selectImage":@"zjmgongkaixuanzhong",@"title":@"公开游记"},
  @{@"image":@"zjmhaoyou",@"selectImage":@"zjmhaoyouxuanzhong",@"title":@"好友可见"},
                   @{@"image":@"zjmziji",@"selectImage":@"zjmzijixuanzhong",@"title":@"自己可见"},
                   
                   
                   @{@"image":@"zjmguanbi",@"selectImage":@"zjmdakai"}];
    [self initView];
}

- (void)initView
{
    for(UIView *view in [self.view subviews])
    {
        if(view.tag < 3)
        {
            [view removeFromSuperview];
        }
    }
    for(int i = 0;i < 3;i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((DeviceWidth / 3)*i, 0, DeviceWidth / 3, DeviceWidth / 3)];
        btn.centerY = DeviceHeight / 2 - 64;
        if(tag == i)
        {
            [btn setImage:IMAGE(_itemArray[i][@"selectImage"]) forState:0];
            [btn setTitleColor:ColorBtnYellow forState:0];
        }else{
            [btn setImage:IMAGE(_itemArray[i][@"image"]) forState:0];
             [btn setTitleColor:ColorLightGray forState:0];
        }//ColorLightGray
        [btn setTitle:_itemArray[i][@"title"] forState:0];
        btn.titleLabel.font = Font12;
        btn.tag = i;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(AUTO(-30), AUTO(50), 0, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(AUTO(30), 0, 0, 0)];
        [btn addTarget:self action:@selector(btnFunc:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
      UIButton *synBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, DeviceHeight / 2 + (DeviceWidth / 6) + 10 - 64, DeviceWidth, 40)];
    [synBtn setImage:IMAGE(_itemArray[3][@"image"]) forState:0];
    [synBtn setTitle:@"仅使用wifi时自动同步数据" forState:0];
    [synBtn setTitleColor:ColorBlack forState:0];
    synBtn.titleLabel.font = Font15;
    synBtn.tag = 3;
    [synBtn addTarget:self action:@selector(synBtnFunc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:synBtn];
}

- (void)btnFunc:(UIButton *)btn
{
    tag = btn.tag;
    self.blockBtnFunc(btn.tag + 1);
    [self initView];
}

- (void)synBtnFunc:(UIButton *)btn
{
    [btn setImage:IMAGE(_itemArray[3][@"selectImage"]) forState:0];
}

@end
