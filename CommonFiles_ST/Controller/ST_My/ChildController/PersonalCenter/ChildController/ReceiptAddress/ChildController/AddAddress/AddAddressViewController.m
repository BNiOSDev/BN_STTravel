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

@property (nonatomic,strong) SJR_Area  *provinceArea;
@property (nonatomic,strong) SJR_Area  *cityArea;
@property (nonatomic,assign) SJR_Area  *streetArea;
@end


@implementation AddAddressViewController

- (void)dealloc
{
    self.addressModel = nil;
}

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
    self.addressTextField.userInteractionEnabled = NO;
    
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
    
    if (self.addressModel) {
        self.phoneNumTextField.text = self.addressModel.phone;
        self.userNameTextField.text = self.addressModel.name;
        self.addressTextField.text = [NSString stringWithFormat:@"%@ %@",self.addressModel.provinceName,self.addressModel.cityName];
        self.streetTextField.text = self.addressModel.address;
        self.postalNumTextFiled.text = self.addressModel.zipcode;
    }
    self.phoneNum = self.phoneNumTextField.text;
    self.userName = self.userNameTextField.text;
    self.address = self.addressTextField.text;
    self.street = self.streetTextField.text;
    self.postNum = self.postalNumTextFiled.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnClickAction:(id)sender {
    self.userName = [self.userName Trim];
    self.phoneNum = [self.phoneNum Trim];
    self.address = [self.address Trim];
    self.street = [self.street Trim];
    self.postNum = [self.postNum Trim];
    if ([self.userName length] == 0) {
        [self showHudPrompt:@"请填写收件人名称"];
        return;
    }
    
    if ([self.phoneNum validateMobile] == 0) {
        [self showHudPrompt:@"请输入正确的手机号码"];
        return;
    }
    if ([self.address length] == 0) {
        [self showHudPrompt:@"请选择所在区域"];
        return;
    }
//    if ([self.street length] == 0) {
//        [self showHudPrompt:@"请填写详细地址"];
//        return;
//    }
//    
//    if ([self.postNum length] == 0) {
//        [self showHudPrompt:@"请填写邮政编码"];
//        return;
//    }
    
    if (!self.addressModel) {
        self.addressModel = [[LBB_AddressModel alloc] init];
    }
    self.addressModel.name = self.userName;
    self.addressModel.phone = self.phoneNum;
    self.addressModel.provinceId = [[self.provinceArea CODE] intValue];
    self.addressModel.cityId = [[self.cityArea CODE] intValue];
    self.addressModel.provinceName = self.provinceArea.NAME;
    self.addressModel.cityName = self.cityArea.NAME;
    self.addressModel.districtId = [[self.streetArea CODE] intValue];
    self.addressModel.address = self.street;
    self.addressModel.zipcode = self.postNum;
    
    __weak typeof (self) weakSelf = self;
    [self.addressModel.loadSupport setDataRefreshblock:^{
        [weakSelf showHudPrompt:@"保存成功！"];
    }];
    
    [self.addressModel.loadSupport setDataRefreshFailBlock:^(NetLoadEvent code ,NSString* remark){
        [weakSelf showHudPrompt:remark];
    }];
    
    [self.addressModel updateAddress];
}

- (IBAction)showAddressPickView:(id)sender {
    
    //隐藏键盘
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
    });
    
    if (self.addressPicker) {
        [self.addressPicker removeFromSuperview];
        self.addressPicker = nil;
    }
    
    if (!self.addressPicker) {
        self.addressPicker = [[LBB_AddressPickerView alloc] initWithTitle:NSLocalizedString(@"选择地址", nil)
                                                         showCancelButton:YES
                                                               parentView:self.view
                                                               showStreet:YES];
    }
    
    __weak typeof (self) weakSelf = self;
    self.addressPicker.myBlock = ^(SJR_Area *privience,SJR_Area *city ,SJR_Area *street){
        NSString *address = [NSString stringWithFormat:@"%@ %@ %@",privience.NAME,city.NAME,street.NAME];
        if (address && [address length]) {
            weakSelf.addressTextField.text = address;
            weakSelf.address = address;
            if (street.ZIPCODE) {
                weakSelf.postalNumTextFiled.text = [NSString stringWithFormat:@"%@",@(city.ZIPCODE)];
            }else if(city.ZIPCODE){
                weakSelf.postalNumTextFiled.text = [NSString stringWithFormat:@"%@",@(city.ZIPCODE)];
            }else if(privience.ZIPCODE){
                weakSelf.postalNumTextFiled.text = [NSString stringWithFormat:@"%@",@(city.ZIPCODE)];
            }
            weakSelf.postNum = weakSelf.postalNumTextFiled.text;
        }
    };

}

@end
