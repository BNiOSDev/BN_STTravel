//
//  LBB_LoginViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LoginViewController.h"
#import "LBB_LoginManager.h"
#import "LBB_ResgisterViewController.h" 
#import "VerificationViewController.h"

@interface LBB_LoginViewController ()

@property(nonatomic,weak) IBOutlet UITextField *accountTextField;
@property(nonatomic,weak) IBOutlet UITextField *passwordTextField;

@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *checkNum;
@property(nonatomic,assign) LoginType loignType;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property(nonatomic,weak) IBOutlet UIButton *registerButton;
@property(nonatomic,weak) IBOutlet UIButton *forgetButton;
@property(nonatomic,weak) IBOutlet UIButton *QQBtn;
@property(nonatomic,weak) IBOutlet UIButton *wechatBtn;

@property(nonatomic,weak) IBOutlet UIView *line1;
@property(nonatomic,weak) IBOutlet UIView *line2;
@property(nonatomic,weak) IBOutlet UIView *line3;
@property(nonatomic,weak) IBOutlet UIView *line4;

@property (weak, nonatomic) IBOutlet UIImageView *accountImgView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImgView;
@property (weak, nonatomic) IBOutlet UILabel *otherLoginTypeLabel;

@end

@implementation LBB_LoginViewController

- (void)dealloc
{
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eLogin;
    self.accountTextField.text = @"13489145937";
    self.passwordTextField.text = @"123456";
    self.account = self.accountTextField.text;
    self.password = self.passwordTextField.text;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initLocalData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLocalData
{
    LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
    LoginUserInfo *userInfo = [loginManager getLoginUserInfo];
    if (userInfo) {
        self.accountTextField.text = userInfo.account;
        self.passwordTextField.text = userInfo.password;
        self.account = userInfo.account;
        self.password = userInfo.password;
    }
}

- (void)buildControls
{
    self.accountTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.secureTextEntry = YES;
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    self.registerButton.exclusiveTouch = YES;
    self.forgetButton.exclusiveTouch = YES;
    self.wechatBtn.exclusiveTouch = YES;
    self.QQBtn.exclusiveTouch = YES;
    self.loginButton.backgroundColor = ColorBtnYellow;
    
    @weakify(self);
    [self.accountTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.account = self.accountTextField.text;
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.password = self.passwordTextField.text;
    }];
}

#pragma mark - UI Action
- (IBAction)loignAction:(id)sender
{
    self.loignType = eLoginTelePhone;
    self.account = [self.account Trim];
    self.password = [self.password Trim];
    
    __weak typeof (self) weakSelf = self;
    
    if ([self.account length] && [self.password length]) {
        [self showHud:YES];
        LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
        [loginManager login:self.loignType
                    Account:self.account
                   Password:self.password
              CompleteBlock:^(NSString *userToken,BOOL result){
                  [weakSelf showHud:NO];
                  if (result) {
                      [weakSelf.navigationController popViewControllerAnimated:YES];
                  }else {
                      [weakSelf showHudPrompt:userToken];
                  }
              }];
    }else{
        [self showHudPrompt:@"请检查账号和密码是否正确"];
    }
}


#pragma mark - UI Action
- (IBAction)registerAction:(id)sender
{
    [self performSegueWithIdentifier:@"LBB_ResgisterViewController" sender:nil];
}

- (IBAction)forgetPassword:(id)sender
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    VerificationViewController* vc = [main instantiateViewControllerWithIdentifier:@"VerificationViewController"];
    vc.baseViewType = eFindPassword;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)wechatLoginBtnClickAction:(id)sender {
}

- (IBAction)QQLoginBtnClickAction:(id)sender {
}


- (NSString*)removeWhiteSpaceWithOrignString:(NSString *)orignStr
{
    if (orignStr) {
        //去掉前后空格和换行
        NSString *newStr = [orignStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([newStr length] == 0) {
            return nil;
        }
        return newStr;
    }
    return nil;
}

#pragma mark - textfield delegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (self.accountTextField == textField) {
//        self.account = [self removeWhiteSpaceWithOrignString:self.account];
//        self.password = [self removeWhiteSpaceWithOrignString:self.password];
//    }
//    
//    return YES;
//}

@end
