//
//  LBB_ResgisterViewController.m
//  ST_Travel
//
//  Created by Diana on 16/11/1.
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

@property(nonatomic,weak) IBOutlet UIImageView *userHeadImgView;
@property(nonatomic,weak) IBOutlet UILabel *accountLabel;
@property(nonatomic,weak) IBOutlet UILabel *passwordLabel;

@property(nonatomic,weak) IBOutlet UILabel *girlLabel;
@property(nonatomic,weak) IBOutlet UILabel *boyLabel;

@property(nonatomic,weak) IBOutlet UIButton *girlButton;
@property(nonatomic,weak) IBOutlet UIButton *boyButton;

@property(nonatomic,weak) IBOutlet UIView *line1;
@property(nonatomic,weak) IBOutlet UIView *line2;
@property(nonatomic,weak) IBOutlet UIView *line3;
@property(nonatomic,weak) IBOutlet UIView *line4;

@property(nonatomic,strong) LBB_AddressPickerView *addressPicker;
@property(nonatomic,strong) LBB_ImagePickerViewController *imagePicker;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,assign) LoginType loignType;
@property(nonatomic,assign) UIImage *userHeadImage;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *comfirmPassword;
@property(nonatomic,copy) NSString *address;

@end

@implementation LBB_ResgisterViewController

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
    self.comfirmTextField.borderStyle = UITextBorderStyleNone;
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    self.line4.backgroundColor = ColorLine;
    self.accountLabel.font = Font14;
    self.passwordLabel.font = Font14;
    self.boyLabel.font = Font14;
    self.girlLabel.font = Font14;
    self.accountLabel.textColor = ColorBlack;
    self.passwordLabel.textColor = ColorBlack;
    self.boyLabel.textColor = ColorBlack;
    self.girlLabel.textColor = ColorBlack;
    self.boyButton.exclusiveTouch = YES;
    self.girlButton.exclusiveTouch = YES;
    
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
        self.comfirmPassword = self.passwordTextField.text;
    }];
}

- (void)showAddressPickerMenu:(id)sender
{
    if (!self.addressPicker) {
        self.addressPicker = [[LBB_AddressPickerView alloc] initWithTitle:NSLocalizedString(@"选择地址", nil)
                                                         showCancelButton:YES
                                                               parentView:self.view
                                                               showStreet:NO];
    }
    
    [self.addressPicker showPickerView];
    @weakify(self)
    self.addressPicker.myBlock = ^(NSString *address,NSArray *selections){
        @strongify(self)
        if (address && [address length]) {
            self.address = [self removeWhiteSpaceWithOrignString:address];
        }
    };
}

#pragma mark - UI Action
- (IBAction)loignAction:(id)sender
{
    self.loignType = eLoginTelePhone;
    self.account = [self removeWhiteSpaceWithOrignString:self.account];
    self.password = [self removeWhiteSpaceWithOrignString:self.password];
    self.comfirmPassword = [self removeWhiteSpaceWithOrignString:self.comfirmPassword];
    if (self.account && self.password && self.comfirmPassword) {
        LBB_LoginManager *loginManager = [LBB_LoginManager shareInstance];
 
        [loginManager registered:self.loignType
                   UserHeadImage:self.userHeadImage
                         Account:self.account
                        Password:self.password
                             Sex:self.sex
                         Address:self.address];
        
        loginManager.resgisterCompleteBlock = ^(BOOL result){
            if (result) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [self showHudPrompt:@"注册失败，请检查账号和密码是否正确"];
            }
        };
    }else if([self.password isEqualToString:self.comfirmPassword]){
        [self showHudPrompt:@"注册失败,请检查密码是否正确"];
    }else {
         [self showHudPrompt:@"注册失败,请检查信息是否完整"];
    }
}

- (IBAction)girlBtnAction:(id)sender
{
    self.sex = 1;
    self.boyButton.selected = NO;
    self.girlButton.selected = YES;
}

- (IBAction)boyBtnAction:(id)sender
{
    self.sex = 0;
    self.boyButton.selected = YES;
    self.girlButton.selected = NO;
}

- (IBAction)userHeadBtnAction:(id)sender
{
    self.imagePicker = nil;
    
    self.imagePicker = [[LBB_ImagePickerViewController alloc] initPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary Parent:self];
    
   @weakify(self)
    [self.imagePicker showPicker:^(UIImage *resultImage){
        NSLog(@"%d",resultImage == nil);
        @strongify(self)
        self.userHeadImage = resultImage;
    }];
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
