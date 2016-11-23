//
//  ZJMBaseViewController.m
//  ST_Travel
//
//  Created by dawei che on 2016/10/18.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ZJMBaseViewController.h"
#import "Header.h"
#import "ST_TabBarController.h"

@interface ZJMBaseViewController ()

@end

@implementation ZJMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark --  处理网络状态变化的view的显示问题
- (void)dealNetWorkChange
{
//    [[ZYDefaultNetWorkStatus sharedManager] addObserver:self forKeyPath:@"despNetWorkStatus" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark -- 判断页面是否处于当前显示
- (BOOL)isVisiable
{
    return  (self.isViewLoaded && self.view.window);
}

#pragma mark - 覆盖方法
#pragma mark 重写observeValueForKeyPath方法，当账户余额变化后此处获得通知
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    LRLog(@"%@",keyPath);
//    LRLog(@"%@",change[@"new"]);
    if([change[@"new"] isEqualToString:@"fail"] && [self isVisiable])
    {
        NSLog(@"显示提示view的处理地方");
    }
    
}

/**
 *  隐藏多余tablecell
 *
 *  @param tableView void
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

/**
 *  goBack重写系统的返回事件
 */

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//touch hide keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
