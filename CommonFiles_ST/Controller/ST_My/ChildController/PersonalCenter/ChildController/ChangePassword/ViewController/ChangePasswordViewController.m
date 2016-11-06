//
//  ChangePasswordViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/20.
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
@property (weak, nonatomic)  UIView *line1;
@property (weak, nonatomic)  UIView *line2;
@property (weak, nonatomic)  UIView *line3;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)buildControls
{
    self.orignLabel.textColor = ColorBlack;
    self.newpLabel.textColor = ColorBlack;
    self.comfirLabel.textColor = ColorBlack;
    self.tipLabel.textColor = ColorBlack;
    
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    
    self.orignLabel.font = Font14;
    self.newpLabel.font = Font14;
    self.comfirLabel.font = Font14;
    self.tipLabel.font = Font14;

    self.saveBtn.backgroundColor = [UIColor clearColor];
    [self.saveBtn setBackgroundImage:[UIImage createImageWithColor:ColorBtnYellow] forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    [self.saveBtn.titleLabel setFont:Font15];
    
    [self setTextFieldBackImage:self.orignTextField];
    [self setTextFieldBackImage:self.secondTextField];
    [self setTextFieldBackImage:self.comfirTextField];
}

- (void)setTextFieldBackImage:(UITextField*)textField
{
    if (textField) {
        [textField setBackground:[UIImage createImageWithColor:[UIColor clearColor]]];
        textField.borderStyle = UITextBorderStyleNone;
    }
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
