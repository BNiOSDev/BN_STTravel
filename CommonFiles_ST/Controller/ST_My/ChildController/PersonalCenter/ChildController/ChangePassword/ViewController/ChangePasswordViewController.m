//
//  ChangePasswordViewController.m
//  ST_Travel
//
//  Created by Diana on 16/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *orignLabel;
@property (weak, nonatomic) IBOutlet UILabel *newpLabel;

@property (weak, nonatomic) IBOutlet UILabel *comfirLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *orignTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UITextField *comfirTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Action
- (IBAction)saveBtnClickAction:(id)sender {
    //todo 保存新密码 tips 提示后跳转个人中心
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end
