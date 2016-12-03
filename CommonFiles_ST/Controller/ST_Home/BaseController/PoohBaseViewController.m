//
//  PoohBaseViewController.m
//  ST_Travel
//
//  Created by 柯尔祥 on 2016/10/17.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "PoohBaseViewController.h"

#define BUTTON_MARGIN 5
@interface PoohBaseViewController ()

@property (nonatomic, assign) UIStatusBarStyle barStyle;


@end

@implementation PoohBaseViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    WS(ws);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.baseNavigationBarView = [UIView new];
    [self.view addSubview:self.baseNavigationBarView];
    [self.baseNavigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.view.mas_width);
        make.top.mas_equalTo(ws.view);
        make.centerX.equalTo(ws.view);
    }];
    self.baseContentView = [UIView new];
    [self.view addSubview:self.baseContentView];
    [self.baseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.view.mas_width);
        make.top.mas_equalTo(ws.baseNavigationBarView.mas_bottom);
        make.bottom.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
    }];
    
    [self setBaseNavigationBarHidden:YES];
    [self setupTitleAndButton];
    
    // Do any additional setup after loading the view.
    self.baseContentView.backgroundColor = ColorBackground;
    self.baseNavigationBarView.backgroundColor = ColorBackground;
    [self setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setBaseNavigationBarColor:[UIColor blackColor]];
   // self.automaticallyAdjustsScrollViewInsets = NO;//对策scroll View自动向下移动20像素问题
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self unsubscribeAll];
    NSLog(@"dealloc");
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self enableInteractivePopGesture:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)addBackButton:(SEL)selector{
    if (selector==nil) {
        [self addLeftButtonSelector:@selector(goBack)];
    }else{
        [self addLeftButtonSelector:selector];
    }
    
    [self setLeftButtonImage:[UIImage imageNamed:@"poohBack"]];
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupFullContentView{
    WS(ws);
    [self.baseContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.equalTo(ws.view);
    }];
    [self.view bringSubviewToFront:self.baseNavigationBarView];
    self.baseNavigationBarView.backgroundColor = [UIColor clearColor];
}

- (void)dismiss{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Private
- (void)setupTitleAndButton{
    WS(ws);
    self.baseLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.baseNavigationBarView addSubview:self.baseLeftButton];
    self.baseRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.baseNavigationBarView addSubview:self.baseRightButton];
    
    [self.baseLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(IAppNavigationBarHeight, IAppNavigationBarHeight));
        make.left.equalTo(ws.baseNavigationBarView).offset(BUTTON_MARGIN);
        make.bottom.equalTo(ws.baseNavigationBarView);
    }];
    
    [self.baseRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(IAppNavigationBarHeight);
        make.height.mas_equalTo(IAppNavigationBarHeight);
        make.right.equalTo(ws.baseNavigationBarView).offset(-BUTTON_MARGIN);
        make.bottom.equalTo(ws.baseNavigationBarView);
    }];
    
    self.baseNavigationBarLabel = [UILabel new];
    self.baseNavigationBarLabel.textAlignment = NSTextAlignmentCenter;
    [self.baseNavigationBarView addSubview:self.baseNavigationBarLabel];
    [self.baseNavigationBarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(self.baseLeftButton.mas_right);
        //        make.right.mas_equalTo(self.baseRightButton.mas_left);
        make.centerX.equalTo(ws.baseNavigationBarView);
        make.height.mas_equalTo(IAppNavigationBarHeight);
        make.bottom.mas_equalTo(ws.baseNavigationBarView);
        make.width.mas_equalTo(@200);
    }];
    
}

#pragma mark - Public
- (void)setBaseNavigationBarHidden:(BOOL)hidden{
    if (hidden) {
        [self.baseNavigationBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFLOAT_MIN);
        }];
    }else{
        [self.baseNavigationBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(IAppNavigationBarHeight+IAppStatusBarHeight));
        }];
    }
}

- (void)setBaseNavigationBarTitle:(NSString *)barTitle{
    self.baseNavigationBarLabel.text = barTitle;
}

- (void)setBaseNavigationBarColor:(UIColor *)barColor{
    self.baseNavigationBarLabel.textColor = barColor;
}

- (void)setBaseNavigationBarBackgroundColor:(UIColor *)barColor{
    self.baseNavigationBarView.backgroundColor = barColor;
}

- (void)updateLeftButtonWidth:(CGFloat)width{
    [self.baseLeftButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}

- (void)updateRightButtonWidth:(CGFloat)width{
    [self.baseRightButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)addLeftButtonSelector:(SEL)selector{
    [self.baseLeftButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.baseLeftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}
- (void)addRightButtonSelector:(SEL)selector{
    [self.baseRightButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.baseRightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}
#pragma clang diagnostic pop

- (void)setLeftButtonImage:(UIImage *)image{
    [self.baseLeftButton setImage:image forState:UIControlStateNormal];
}
- (void)setRightButtonImage:(UIImage *)image{
    [self.baseRightButton setImage:image forState:UIControlStateNormal];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.barStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)style{
    self.barStyle = style;
    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)enableInteractivePopGesture:(BOOL)enable{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = enable;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

@end
