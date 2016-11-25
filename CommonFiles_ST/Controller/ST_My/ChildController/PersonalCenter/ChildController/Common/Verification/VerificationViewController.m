//
//  VerificationViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "VerificationViewController.h"
#import "LBB_LoginManager.h"
#import "ChangePasswordViewController.h"


@interface VerificationViewController ()<
UITextFieldDelegate
>
@property(nonatomic,strong) LBB_PersonalModel *personModel;

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

- (void)dealloc
{
    self.mainPersonModel = nil;
    self.personModel = nil;
}

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
        self.phoneNum = self.phoneTextFiled.text;
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
    [self.nextBtn.titleLabel setFont:Font16];
    
    //找回密码验证、修改手机号
   [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    switch (self.baseViewType) {
        case eFindPassword:
        {
            self.tipBgViewHeightContraint.constant = 0.f;
            self.tipBgView.hidden = YES;
            self.middleViewTopContraint.constant = 0.f;
            self.navigationItem.title = @"找回密码";
        }
            break;
        case eChangePhoneNum:
        {
            self.tipLabel.text = @"修改手机号，需要对旧的手机号码进行验证";
            self.navigationItem.title = @"修改手机号码";
            self.phoneTextFiled.text = self.mainPersonModel.phoneNum;
            self.phoneNum = self.phoneTextFiled.text;
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
    self.phoneNum = [self.phoneNum Trim];
    if (![self.phoneNum validateMobile]) {
        UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"手机号不对" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    int type = 4;
    if (self.baseViewType == eCheckPhoneNum) {
        type = 5;
    }
    [[LBB_LoginManager shareInstance] getVerificationCode:self.phoneNum Type:4];
}

- (IBAction)startVerificatiteAction:(id)sender {
    
    self.phoneNum = [self.phoneNum Trim];
    self.checkNum = [self.checkNum Trim];
    if ([self.phoneNum length] == 0) {
        [self showHudPrompt:@"请输入手机号"];
        return;
    }
    if([self.checkNum length] == 0){
        [self showHudPrompt:@"请输入验证码"];
        return;
    }
    
    switch (self.baseViewType) {
        case eFindPassword:
        {
            [self setPassword];
        }
            break;
        case eChangePhoneNum:
        {
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
            VerificationViewController* vc = [main instantiateViewControllerWithIdentifier:@"VerificationViewController"];
            vc.baseViewType = eCheckPhoneNum;
            vc.mainPersonModel = self.mainPersonModel;
            [self.navigationController pushViewController:vc animated:YES];
         
        }
            break;
        case eCheckPhoneNum:
        {
            if (!self.personModel) {
                self.personModel = [[LBB_PersonalModel alloc] init];
            }
            
            [self.personModel updatePhoneNum:self.phoneNum VerifyCode:self.checkNum Token:self.userToken];
            __weak typeof (self) weakSelf = self;
            
            [self.personModel.loadSupport setDataRefreshblock:^{
                weakSelf.mainPersonModel.phoneNum = weakSelf.phoneNum;
                weakSelf.mainPersonModel.loadSupport.loadEvent = NetLoadSuccessfulEvent;
                NSArray *vcArray = weakSelf.navigationController.viewControllers;
                UIViewController *vc = weakSelf.navigationController.topViewController;
                if (vcArray.count >= 3) {
                    vc = [vcArray objectAtIndex:(vcArray.count - 3)];
                }
                [weakSelf.navigationController popToViewController:vc animated:YES];
            }];
            [self.personModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code ,NSString* remark){
                [weakSelf showHudPrompt:remark];
            }];

        }
            break;
            
        default:
            break;
    }
   
}

- (void)setPassword
{
    self.phoneNum = [self.phoneNum Trim];
    self.checkNum = [self.checkNum Trim];
    if (![self.phoneNum validateMobile]) {
        [self showHudPrompt:@"手机号不对"];
        return;
    }
    if ([self.checkNum length] == 0) {
        [self showHudPrompt:@"请输入验证码"];
    }
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    ChangePasswordViewController  *vc  = [main instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    vc.baseViewType = eResetPassword;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITextFiled Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

@end
