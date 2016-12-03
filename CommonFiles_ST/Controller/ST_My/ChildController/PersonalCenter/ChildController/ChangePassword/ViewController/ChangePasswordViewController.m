//
//  ChangePasswordViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LBB_LoginManager.h"

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
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;

@property(nonatomic,copy) NSString *orignPassword;
@property(nonatomic, copy) NSString *secondPassword;
@property(nonatomic, copy) NSString *comfirPassword;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orignBgViewHeightContraint;


@end

@implementation ChangePasswordViewController

- (void)dealloc
{
    self.account = nil;
    self.checkNum = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)buildControls
{
    @weakify(self);
    [self.orignTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.orignPassword = self.orignTextField.text;
    }];
    
    [self.secondTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.secondPassword = self.secondTextField.text;
    }];
    
    [self.comfirTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.comfirPassword = self.comfirTextField.text;
    }];
}

- (void)initUI
{
    self.orignLabel.textColor = ColorBlack;
    self.newpLabel.textColor = ColorBlack;
    self.comfirLabel.textColor = ColorBlack;
    self.tipLabel.textColor = ColorLightGray;
    
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    
    self.orignLabel.font = Font16;
    self.newpLabel.font = Font16;
    self.comfirLabel.font = Font16;
    self.tipLabel.font = Font14;

    self.orignTextField.secureTextEntry = YES;
    self.secondTextField.secureTextEntry = YES;
    self.comfirTextField.secureTextEntry = YES;
    
    [self.saveBtn.titleLabel setFont:Font16];
    
    switch (self.baseViewType) {
        case eChangePassword:
        {
            
        }
            break;
        case eResetPassword:
        {
            self.newpLabel.text = @"设置密码：";
            self.orignBgViewHeightContraint.constant = 0.f;
        }
            break;
        default:
            break;
    }
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
    
    self.orignPassword = [self.orignPassword Trim];
    self.secondPassword = [self.secondPassword Trim];
    self.comfirPassword = [self.comfirPassword Trim];
    if (self.baseViewType == eChangePassword) {
        if ([self.orignPassword length] == 0) {
            [self showHudPrompt:@"请输入原密码"];
            return;
        }
    }
    if (!([self.secondPassword length] >= 6 && [self.secondPassword length] <= 20)) {
        [self showHudPrompt:@"密码格式输入错误，请重新输入"];
        return;
    }
//    if (![self.secondPassword validatePassword]) {
//        [self showHudPrompt:@"密码输入错误，请重新输入"];
//        return;
//    }
    
    if (![self.secondPassword isEqualToString:self.comfirPassword]) {
         [self showHudPrompt:@"请确认密码是否正确"];
        return;
    }
    
    __weak typeof (self) weakSelf = self;
    switch (self.baseViewType) {
        case eChangePassword://todo 保存新密码 tips 提示后跳转个人中心
        {
            LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
            [loginManager changePassword:self.orignPassword
                             NewPassword:self.secondPassword
                           CompleteBlock:^(NSString* message,BOOL result){
                               if (result) {
                                   [weakSelf backToLoginView];
                               }else if(message){
                                   [weakSelf showHudPrompt:message];
                               }
                           }];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case eResetPassword: //调回登录页面
        {
            LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
            [loginManager findPassword:self.account
                             CheckNum:self.checkNum
                             Password:self.secondPassword
                        CompleteBlock:^(NSString* userToken,BOOL result){
                            if (result) {
                                [weakSelf backToLoginView];
                            }else if(userToken){
                                [weakSelf showHudPrompt:userToken];
                            }
                        }];
        }
            break;
        default:
            break;
    }
}

- (void)backToLoginView
{
    NSArray *viewArray = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[viewArray objectAtIndex:(viewArray.count - 3)]animated:YES];
}
#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end
