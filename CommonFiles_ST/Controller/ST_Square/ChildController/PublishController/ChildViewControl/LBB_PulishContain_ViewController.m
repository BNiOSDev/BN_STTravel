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
#import "LBB_TagView.h"

@interface LBB_PulishContain_ViewController ()
{
    BOOL    addTaged;//是否已添加标签
}
@property(nonatomic, strong)LBB_Pulish_ImageContain_View   *imageContainView;
@property(nonatomic,strong)NSMutableArray   *tagsViewArray;
@end

@implementation LBB_PulishContain_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册监听者。
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back:) name:@"goBack" object:nil];
    
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

- (void)back:(NSNotification *)notification
{
    [self backToController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.view addSubview:_imageContainView];
}

- (void)initView
{
    _tagsViewArray = [[NSMutableArray alloc]init];
    //初始化标签数组，为了后续使用代替方法
    for (int i = 0; i < _selectImageArray.count; i++) {
        [_tagsViewArray addObject:@""];
    }

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
    if(!addTaged)
    {
        [self showHudPrompt:@"至少选择一张照片添加标签"];
        return;
    }
    LBB_EditPulishContain_Controller *Vc = [[LBB_EditPulishContain_Controller alloc]init];
    Vc.imageArray = self.selectImageArray;
    Vc.tagsViewArray = _tagsViewArray;
    Vc.imageContainView = _imageContainView;
//    Vc.imageContainView = [self duplicate:_imageContainView];
    [self.navigationController pushViewController:Vc animated:YES];
}

- (void)transTagsWithViewTag:(NSArray *)tagList viewTag:(NSInteger )tag
{
    [_tagsViewArray replaceObjectAtIndex:tag withObject:tagList];
    addTaged = YES;
    NSLog(@"数组总长度%ld",_tagsViewArray.count);
}

//完全复制UIview，序列化
- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

@end
