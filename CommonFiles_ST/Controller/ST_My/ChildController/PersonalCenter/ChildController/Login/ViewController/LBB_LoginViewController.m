//
//  LBB_LoginViewController.m
//  ST_Travel
//
//  Created by Diana on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_LoginViewController.h"
#import "LBB_LoginManager.h"
#import "LBB_ResgisterViewController.h"

@interface LBB_LoginViewController ()

@property(nonatomic,weak) IBOutlet UITextField *accountTextField;
@property(nonatomic,weak) IBOutlet UITextField *passwordTextField;

@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,assign) LoginType loignType;

@property(nonatomic,weak) IBOutlet UILabel *accountLabel;
@property(nonatomic,weak) IBOutlet UILabel *passwordLabel;
@property(nonatomic,weak) IBOutlet UIButton *registerButton;
@property(nonatomic,weak) IBOutlet UIButton *forgetButton;

@property(nonatomic,weak) IBOutlet UIView *line1;
@property(nonatomic,weak) IBOutlet UIView *line2;
@property(nonatomic,weak) IBOutlet UIView *line3;

@end

@implementation LBB_LoginViewController

- (void)dealloc
{
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buildControls
{
    self.accountTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    self.accountLabel.font = Font14;
    self.passwordLabel.font = Font14;
    self.accountLabel.textColor = ColorBlack;
    self.passwordLabel.textColor = ColorBlack;
    self.registerButton.exclusiveTouch = YES;
    self.forgetButton.exclusiveTouch = YES;
    
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
    self.account = [self removeWhiteSpaceWithOrignString:self.account];
    self.password = [self removeWhiteSpaceWithOrignString:self.password];
    if (self.account && self.password) {
        LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
        [loginManager login:self.loignType Account:self.account Password:self.password];
        loginManager.loginCompleteBlock = ^(NSString *userID,BOOL result){
            if (result) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else {
                [self showHudPrompt:@"登录失败，请检查账号和密码是否正确"];
            }
        };
    }
}

- (IBAction)registerAction:(id)sender
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    LBB_ResgisterViewController *resgisterVC = [main instantiateViewControllerWithIdentifier:@"LBB_ResgisterViewController"];
    [self presentViewController:resgisterVC animated:YES completion:nil];
}

- (IBAction)forgetPassword:(id)sender
{
    
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


@end
