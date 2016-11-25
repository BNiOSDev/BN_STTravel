//
//  ChangePhoneNumViewController.m
//  ST_Travel
//
//  Created by 晨曦 on 16/10/20.
//  Copyright © 2016年 GL_RunMan. All rights reserved.
//

#import "ChangePhoneNumViewController.h"

@interface ChangePhoneNumViewController ()<
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UILabel *phoneTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UILabel *checkTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCheckNumBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation ChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.baseViewType == eChangePhoneNum) {
        self.phoneNumLabel.hidden = NO;
        self.phoneNumTextField.hidden = YES;
        self.phoneNumTextField.userInteractionEnabled = NO;
    }else if (self.baseViewType == eCheckPhoneNum)  {
        self.phoneNumLabel.hidden = YES;
        self.phoneNumTextField.hidden = NO;
        [self.nextBtn setTitle:NSLocalizedString(@"绑定", nil) forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Action
- (IBAction)getCheckNumBtnClickAction:(id)sender {
    
}

- (IBAction)nextBtnClickAction:(id)sender {
    if (self.baseViewType == eChangePhoneNum) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
        ChangePhoneNumViewController *phoneVC = [main instantiateViewControllerWithIdentifier:@"ChangePhoneNumViewController"];
        phoneVC.baseViewType = eCheckPhoneNum;
        [self.navigationController pushViewController:phoneVC animated:YES];
    }else {
        //请求后台进行绑定后跳转到前一页
        //Todo
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

@end
