//
//  AddAddressViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/19.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "AddAddressViewController.h"
#import "LBB_AddressPickerView.h"

@interface AddAddressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *postalNumTextFiled;

@property(nonatomic,weak) IBOutlet UILabel *userNameLabel;
@property(nonatomic,weak) IBOutlet UILabel *phoneLabel;
@property(nonatomic,weak) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *postalNumLabel;

@property(nonatomic,weak) IBOutlet UIView *line1;
@property(nonatomic,weak) IBOutlet UIView *line2;
@property(nonatomic,weak) IBOutlet UIView *line3;
@property(nonatomic,weak) IBOutlet UIView *line4;
@property(nonatomic,weak) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *showAddressBtn;


@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *phoneNum;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *street;
@property(nonatomic,copy) NSString *postNum;

@property(nonatomic,strong) LBB_AddressPickerView *addressPicker;

@end


@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseViewType =  eAddAddress;
    [self initUI];
}

- (void)buildControls
{
    @weakify(self);
    [self.userNameTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.userName = self.userNameTextField.text;
    }];
    
    [self.phoneNumTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.phoneNum = self.phoneNumTextField.text;
    }];
    
    [self.addressTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.address = self.addressTextField.text;
    }];
    
    [self.streetTextField.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.street = self.streetTextField.text;
    }];
    
    [self.postalNumTextFiled.rac_textSignal subscribeNext:^(id x) {
        @strongify(self);
        self.postNum = self.postalNumTextFiled.text;
    }];
    
}

- (void)initUI
{
    self.userNameTextField.borderStyle = UITextBorderStyleNone;
    self.phoneNumTextField.borderStyle = UITextBorderStyleNone;
    self.addressTextField.borderStyle = UITextBorderStyleNone;
    self.streetTextField.borderStyle = UITextBorderStyleNone;
    self.postalNumTextFiled.borderStyle = UITextBorderStyleNone;
    
    self.userNameTextField.exclusiveTouch = YES;
    self.phoneNumTextField.exclusiveTouch = YES;
    self.addressTextField.exclusiveTouch = YES;
    self.streetTextField.exclusiveTouch = YES;
    self.postalNumTextFiled.exclusiveTouch = YES;
    self.saveBtn.exclusiveTouch = YES;
    self.showAddressBtn.exclusiveTouch = YES;
    
    self.line1.backgroundColor = ColorLine;
    self.line2.backgroundColor = ColorLine;
    self.line3.backgroundColor = ColorLine;
    self.line4.backgroundColor = ColorLine;
    self.line5.backgroundColor = ColorLine;
    self.userNameLabel.font = Font16;
    self.phoneLabel.font = Font16;
    self.addressLabel.font = Font16;
    self.streetLabel.font = Font16;
    self.postalNumLabel.font = Font16;
    self.userNameLabel.textColor = ColorBlack;
    self.phoneLabel.textColor = ColorBlack;
    self.addressLabel.textColor = ColorBlack;
    self.streetLabel.textColor = ColorBlack;
    self.postalNumLabel.textColor = ColorBlack;
    self.addressTextField.userInteractionEnabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClickAction:(id)sender {
}

- (IBAction)showAddressPickView:(id)sender {
    
    if (!self.addressPicker) {
        self.addressPicker = [[LBB_AddressPickerView alloc] initWithTitle:NSLocalizedString(@"选择地址", nil)
                                                         showCancelButton:YES
                                                               parentView:self.view
                                                               showStreet:NO];
    }
    
    [self.addressPicker showPickerView];
    __weak typeof (self) weakSelf = self;
    self.addressPicker.myBlock = ^(NSString *address,NSArray *selections){
        if (address && [address length]) {
            weakSelf.addressTextField.text = address;
        }
    };

}

@end
