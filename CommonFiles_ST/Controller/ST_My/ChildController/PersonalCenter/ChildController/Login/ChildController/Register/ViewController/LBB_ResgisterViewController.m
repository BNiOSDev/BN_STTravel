//
//  LBB_ResgisterViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/11/1.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "LBB_ResgisterViewController.h"
#import "LBB_LoginManager.h"
#import "LBB_AddressPickerView.h"
#import "LBB_ImagePickerViewController.h" 

@interface LBB_ResgisterViewController ()

@property(nonatomic,weak) IBOutlet UITextField *accountTextField;
@property(nonatomic,weak) IBOutlet UITextField *passwordTextField;
@property(nonatomic,weak) IBOutlet UITextField *comfirmTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkTextField;

@property(nonatomic,weak) IBOutlet UILabel *accountLabel;
@property(nonatomic,weak) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfirmLabel;

@property (weak, nonatomic) IBOutlet UILabel *checkLabel;

@property(nonatomic,weak) IBOutlet UIView *line1;
@property(nonatomic,weak) IBOutlet UIView *line2;
@property(nonatomic,weak) IBOutlet UIView *line3;
@property(nonatomic,weak) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumBtn;
@property (weak, nonatomic) IBOutlet UIButton *resgisterBtn;


@property(nonatomic,strong) LBB_AddressPickerView *addressPicker;
@property(nonatomic,strong) LBB_ImagePickerViewController *imagePicker;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,assign) LoginType loignType;
@property(nonatomic,assign) UIImage *userHeadImage;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *comfirmPassword;
@property(nonatomic,copy) NSString *checkNum;
@property(nonatomic,copy) NSString *address;

@end

@implementation LBB_ResgisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType = eResgister;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildControls
{
    self.accountTextField.borderStyle = UITextBorderStyleNone;
    self.passwordTextField.borderStyle = UITextBorderStyleNone;
    self.comfirmTextField.borderStyle = UITextBorderStyleNone;
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    self.line4.backgroundColor = ColorLine;
    self.accountLabel.font = Font16;
    self.passwordLabel.font = Font16;
    self.comfirmLabel.font = Font16;
    self.checkLabel.font = Font16;
    self.accountLabel.textColor = ColorBlack;
    self.passwordLabel.textColor = ColorBlack;
    self.comfirmLabel.textColor = ColorBlack;
    self.checkLabel.textColor = ColorBlack;
    
    @weakify(self);
    [self.accountTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.account = self.accountTextField.text;
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.password = self.passwordTextField.text;
    }];
    
    [self.comfirmTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.comfirmPassword = self.comfirmTextField.text;
    }];
    
    [self.checkTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.checkNum = self.checkTextField.text;
    }]; 
}


#pragma mark - UI Action
- (IBAction)getCheckNumBtnClickAction:(id)sender
{
    self.account = [self.account Trim];
    if (![self.account validateMobile]) {
        [self showHudPrompt:@"手机号输入错误，请重新输入"];
        return;
    }
    
    [[LBB_LoginManager shareInstance] getVerificationCode:self.account Type:1];
}

- (IBAction)resgisterBtnClickAction:(id)sender
{
    self.loignType = eLoginTelePhone;
    self.account = [self.account Trim];
    self.password = [self.password Trim];
    self.comfirmPassword = [self.comfirmPassword Trim];
    
    if (![self.account validateMobile]) {
         [self showHudPrompt:@"手机号输入错误，请重新输入"];
        return;
    }
    
    if (![self.password validatePassword]) {
        [self showHudPrompt:@"密码输入错误，请重新输入"];
        return;
    }
    if (![self.password isEqualToString:self.comfirmPassword]) {
        [self showHudPrompt:@"请确认密码是否正确"];
        return;
    }
    if ([self.checkNum length] == 0) {
        [self showHudPrompt:@"验证码不能为空"];
        return;
    }
    
    if (self.account && self.password && self.comfirmPassword) {
        LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
        
        __weak typeof (self) weakSelf = self;
        [loginManager registered:self.loignType
                   UserHeadImage:self.userHeadImage
                         Account:self.account
                        Password:self.password
                        CheckNum:self.checkNum
                             Sex:self.sex
                         Address:self.address
                   CompleteBlock:^(NSString *userToken,BOOL result){
                       if (result) {
                           [weakSelf.navigationController popViewControllerAnimated:YES];
                       }else {
                           [weakSelf showHudPrompt:@"注册失败，请检查账号、密码、验证码是否正确"];
                       }
                   }];
    }else if([self.password isEqualToString:self.comfirmPassword]){
        [self showHudPrompt:@"注册失败,请检查密码是否正确"];
    }else {
        [self showHudPrompt:@"注册失败,请检查信息是否完整"];
    }
}


//#pragma mark - UI Action
//
//- (IBAction)userHeadBtnAction:(id)sender
//{
//    self.imagePicker = nil;
//    
//    self.imagePicker = [[LBB_ImagePickerViewController alloc] initPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary Parent:self];
//    
//    @weakify(self)
//    [self.imagePicker showPicker:^(UIImage *resultImage){
//        NSLog(@"%d",resultImage == nil);
//        @strongify(self)
//        self.userHeadImage = resultImage;
//    }];
//}
//
//- (void)showAddressPickerMenu:(id)sender
//{
//    if (!self.addressPicker) {
//        self.addressPicker = [[LBB_AddressPickerView alloc] initWithTitle:NSLocalizedString(@"选择地址", nil)
//                                                         showCancelButton:YES
//                                                               parentView:self.view
//                                                               showStreet:NO];
//    }
//    
//    [self.addressPicker showPickerView];
//    @weakify(self)
//    self.addressPicker.myBlock = ^(NSString *address,NSArray *selections){
//        @strongify(self)
//        if (address && [address length]) {
//            self.address = [self.account Trim];
//        }
//    };
//}

@end
