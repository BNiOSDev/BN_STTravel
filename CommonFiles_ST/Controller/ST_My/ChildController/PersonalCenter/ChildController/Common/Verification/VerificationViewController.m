//
//  VerificationViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "VerificationViewController.h"

@interface VerificationViewController ()<
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *phoneTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkTipLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipBgViewHeightContraint;

@property (weak, nonatomic) IBOutlet UIView *tipBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewTopContraint;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;

@property (copy,nonatomic) NSString *checkNum;
@property (copy,nonatomic) NSString *phoneNum;

@end

@implementation VerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)buildControls
{
    @weakify(self)
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self)
        self.checkNum = self.textField.text;
    }];
    
    [self.phoneTextFiled.rac_textSignal subscribeNext:^(id x) {
        @strongify(self)
        self.checkNum = self.phoneTextFiled.text;
    }];
}

- (void)initUI
{
    self.phoneTextFiled.textColor = ColorBlack;
    self.phoneTipLabel.textColor = ColorBlack;
    self.checkTipLabel.textColor = ColorBlack;
    self.textField.textColor = ColorBlack;
    self.phoneTextFiled.font = Font16;
    self.phoneTipLabel.font = Font16;
    self.checkTipLabel.font = Font16;
    self.tipLabel.font = Font14;
    self.tipLabel.textColor = ColorBlack;
    self.tipLabel.numberOfLines = 0;
    self.tipLabel.adjustsFontSizeToFitWidth = YES;
    self.tipBgView.backgroundColor = ColorBackground;
    self.textField.font = Font16;
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.nextBtn.backgroundColor = ColorBtnYellow;
    [self.nextBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    
    //找回密码验证、修改手机号
   [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    switch (self.baseViewType) {
        case eFindPassword:
        {
            self.tipBgViewHeightContraint.constant = 0.f;
            self.tipBgView.hidden = YES;
            self.middleViewTopContraint.constant = 0.f;
            self.navigationItem.title = @"找回密码";
            self.phoneTextFiled.userInteractionEnabled = NO;
        }
            break;
        case eChangePhoneNum:
        {
            self.tipLabel.text = @"修改手机号，需要对旧的手机号码进行验证";
            self.navigationItem.title = @"修改手机号码";
            self.phoneTextFiled.userInteractionEnabled = NO;
        }
            break;
        case eCheckPhoneNum:
        {
            self.tipLabel.text = @"请您输入需要更换绑定的新手机号码，并进行短信验证。";
            self.navigationItem.title = @"验证手机号码";
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI Action
- (IBAction)getVerificationNum:(id)sender {
    
}

- (IBAction)startVerificatiteAction:(id)sender {
    switch (self.baseViewType) {
        case eFindPassword:
        {
            
        }
            break;
        case eChangePhoneNum:
        {
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
            VerificationViewController* vc = [main instantiateViewControllerWithIdentifier:@"VerificationViewController"];
            vc.baseViewType = eCheckPhoneNum;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case eCheckPhoneNum:
        {
            [self showHudPrompt:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
   
}

#pragma mark - UITextFiled Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

@end
